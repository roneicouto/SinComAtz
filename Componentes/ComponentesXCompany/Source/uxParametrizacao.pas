unit uxParametrizacao;

interface

uses
  Vcl.ComCtrls, System.Classes, Vcl.Dialogs, uFormEditorParametros,
  Data.DB, System.SysUtils, System.generics.collections, uClasseFuncoes,
  uClasseParametros, uFrmDigitaParametro,
  Datasnap.DBClient, uFrmLocalizarParametro;

type
  TextoMemo = tArray<WideString>;

  TXParametrizacao = class(TTreeView)

  private
    Parametros: TDictionary<String, TParametro>;
    DescricaoParametros: TDictionary<String, TParametro>;

    fTreeView: TTreeView;
    fParametro: TParametro;

    fLinhas: tArray<WideString>;
    fImageIndex: Integer;
    fDataSet: tclientDataSet;
    fImageIndexParametros: Integer;
    fLoja: Integer;
    fEstacaoTrabalho: Integer;
    FListaNo: TList<ttreenode>;

    procedure SetTreeView(const Value: TTreeView);
    procedure TVCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure SetImageIndex(const Value: Integer);
    procedure SetImageIndexParametros(const Value: Integer);
    procedure SetListaNo(const Value: TList<ttreenode>);

    { private declarations }
  protected
    function CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage; var PaintImages: Boolean): Boolean; override;
    { protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { public declarations }

    function Execute: Boolean;

    procedure AddNo(tree: TTreeView; No: TTreeNode);
    procedure CarregaParametros(tree: TTreeView; Imagem: Integer); Overload;
    procedure CarregaParametros(); overload;
    procedure CarregaConfiguracaoParametro(No: TTreeNode);
    Function CarregaDescricao(No: TTreeNode): String;
    Function CarregaID(No: TTreeNode): String;
    procedure DigitaParametro(tree: TTreeNode; ValorAnterior: string);
    Function CarregaTipoGrupo(No: TTreeNode): string;
    procedure LocalizaParametro(Key: Char);
    Function ValorParametro(Nome: string): String;
    property ListaNo: TList<ttreenode> read FListaNo write SetListaNo;
  published

    property TreeView: TTreeView read fTreeView write SetTreeView;
    property Parametro: TParametro read fParametro write fParametro;
    Property ImageIndex: Integer read fImageIndex Write SetImageIndex;
    Property ImageIndexParametros: Integer read fImageIndexParametros
      Write SetImageIndexParametros;
    Property DataSet: tclientDataSet Read fDataSet Write fDataSet;
    property Loja: Integer read fLoja write fLoja;
    property EstacaoTrabalho: Integer read fEstacaoTrabalho
      write fEstacaoTrabalho;
    { published declarations }

  end;

procedure register;

implementation

uses
  Vcl.Controls;

procedure register;
begin
  RegisterComponents('xComponentes', [TXParametrizacao]);
  RegisterComponents('xComponentes', [TParametro]);
end;

{ TXParametrizacao }

procedure TXParametrizacao.AddNo(tree: TTreeView; No: TTreeNode);
Var
  No2: TTreeNode;
  I: Integer;
begin
  if No.Count = 0 then
  begin
    tree.Items.AddChild(No.Parent, No.Text);

  end
  else
  begin
    for I := 0 to No.Count - 1 do
    begin
      if No.Item[I].Count > 0 then
      begin
        AddNo(tree, No.Item[I]);
      end
      else
      begin
        tree.Items.AddChild(No.Parent, No.Text);
      end;
    end;
  end;

end;

procedure TXParametrizacao.CarregaConfiguracaoParametro(No: TTreeNode);
Var
  I: Integer;
  s: string;
  aRet: tArray<String>;
begin
  s := '';
  s := Funcoes.PegaParent(No);
  fParametro := TParametro.Create(nil);
  if (Parametros.TryGetValue(s, fParametro) = False) then
  begin
    Parametro := TParametro.Create(nil);
  end;

end;

function TXParametrizacao.CarregaDescricao(No: TTreeNode): String;
begin
  Result := '';
  CarregaConfiguracaoParametro(No);
  Result := Funcoes.PegaDescricaoCompleta(No);
end;

function TXParametrizacao.CarregaID(No: TTreeNode): String;
begin
  Result := '';
  Result := Funcoes.PegaParent(No);
end;

procedure TXParametrizacao.CarregaParametros;
Var
  I: Integer;
  s: string;
  pa: TParametro;
  aRet: tArray<String>;
  TipoGrupo: string;
  sSql: string;
begin
  Parametros := TDictionary<String, TParametro>.Create;
  DescricaoParametros := TDictionary<String, TParametro>.Create;

  for I := 0 to Self.Items.Count - 1 do
  begin
    s := Funcoes.PegaParent(Self.Items[I]);
    TipoGrupo := '';
    TipoGrupo := CarregaTipoGrupo(Self.Items[I]);
    pa := TParametro.Create(nil);
    aRet := Self.Items[I].Text.Split(['|']);
    if Length(aRet) = 5 then
    begin
      if Self.Items[I].Count = 0 then
      begin
        try
          if Assigned(DataSet) then
          begin
            sSql := DataSet.CommandText;
            if TipoGrupo = '1' then
              DataSet.CommandText := 'Select * from ( ' + sSql +
                ') as sql where codigoloja = ' + Loja.ToString
            else if TipoGrupo = '2' then
              DataSet.CommandText := 'Select * from ( ' + sSql +
                ') as sql where codigoestacao = ' + EstacaoTrabalho.ToString;
            DataSet.Params[0].Value := s;

            DataSet.Close;
            DataSet.Open;
            DataSet.CommandText := sSql;
            if not DataSet.Eof then
            begin
              pa.Valor := DataSet.FieldByName('valor').AsString;
            end;
          end;

        except
          on E: Exception do
            pa.Valor := '';
        end;

      end;

      pa.Nome := aRet[0];
      pa.valores := aRet[1];
      pa.padrao := aRet[2];
      pa.TipoGrupo := TipoGrupo;
      pa.tipo := TFuncoes.IIf(aRet[3] = 'C', tpCheck,
        TFuncoes.IIf(aRet[3] = 'L', tpLista, TFuncoes.IIf(aRet[3] = 'I',
        tpintervalo, tpValor)));
      pa.Hint := aRet[4];

    end
    else
    begin
      pa.Nome := Self.Items[I].Text;
      pa.valores := '';
      pa.padrao := '';
      pa.TipoGrupo := '0';
      pa.tipo := tpValor;

    end;

    Parametros.Add(s, pa);
    if Assigned(TreeView) then
    begin
      s := '';
      s := CarregaDescricao(TreeView.Items[I]);
      DescricaoParametros.Add(TFuncoes.TiraAcento(UpperCase(s)), pa);


    end;

    s := '';
  end;

end;

function TXParametrizacao.CarregaTipoGrupo(No: TTreeNode): string;
var
  aRet: tArray<String>;
  s: string;

begin
  s := '';
  s := Funcoes.PegaPai(No).Text;
  aRet := s.Split(['|']);
  if Length(aRet) = 0 then
    Result := '0'
  else
  begin

    Result := aRet[2];
  end;

end;

procedure TXParametrizacao.CarregaParametros(tree: TTreeView; Imagem: Integer);
Var
  I: Integer;
  s: string;
  pa: TParametro;
  aRet: tArray<String>;
  TipoGrupo: String;
begin
  tree.Items.BeginUpdate;
  tree.Items.Assign(Self.Items);
  tree.Items.EndUpdate;

  for I := 0 to tree.Items.Count - 1 do
  begin
    // s := '';
    // s := Funcoes.PegaParent(Tree.Items[I]);
    // pa := TParametro.Create(nil);
    aRet := tree.Items[I].Text.Split(['|']);

    if Length(aRet) = 5 then
    begin
      tree.Items[I].Text := aRet[0];
      if tree.Items[I].Count > 0 then
      begin
        tree.Items[I].ImageIndex := ImageIndex;
        tree.Items[I].SelectedIndex := ImageIndex;
      end
      else
      begin
        tree.Items[I].ImageIndex := ImageIndexParametros;
        tree.Items[I].SelectedIndex := ImageIndexParametros;
      end;
    end;

  end;
  Parametros := TDictionary<String, TParametro>.Create;
  for I := 0 to Self.Items.Count - 1 do
  begin
    s := Funcoes.PegaParent(Self.Items[I]);
    TipoGrupo := '';
    TipoGrupo := CarregaTipoGrupo(Self.Items[I]);
    pa := TParametro.Create(nil);
    aRet := Self.Items[I].Text.Split(['|']);
    if Length(aRet) = 5 then
    begin
      pa.Nome := aRet[0];
      pa.valores := aRet[1];
      pa.padrao := aRet[2];
      pa.TipoGrupo := TipoGrupo;
      pa.tipo := TFuncoes.IIf(aRet[3] = 'C', tpCheck,
        TFuncoes.IIf(aRet[3] = 'L', tpLista, TFuncoes.IIf(aRet[3] = 'I',
        tpintervalo, tpValor)));
      pa.Hint := aRet[4];

    end
    else
    begin
      pa.Nome := Self.Items[I].Text;
      pa.valores := '';
      pa.padrao := '';
      pa.tipo := tpValor;
      pa.TipoGrupo := '0';

    end;
    Parametros.Add(s, pa);
    s := '';
  end;

end;

constructor TXParametrizacao.Create(AOwner: TComponent);
var
  I: Integer;
  s: string;
  aRet: tArray<String>;
  pa: TParametro;
begin
  inherited;
  font.Color := 16777215;
  Color := 16777215;
  Visible := False;
  CarregaParametros();

end;

function TXParametrizacao.CustomDrawItem(Node: TTreeNode;
  State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages: Boolean): Boolean;
begin

end;

procedure TXParametrizacao.DigitaParametro(tree: TTreeNode;
  ValorAnterior: string);
var
  Form: tFrmDigitaParametro;
  aRet: tArray<String>;
  I: Integer;
begin
  CarregaParametros();
  Form := tFrmDigitaParametro.Create(nil);
  try
    CarregaConfiguracaoParametro(tree);
    if ValorAnterior = '' then
      ValorAnterior := Parametro.Valor;
    if Parametro.tipo = tpLista then
    begin
      Form.lstValor.Visible := True;
      aRet := Parametro.valores.Split([',']);
      for I := 0 to Length(aRet) - 1 do
        Form.lstValor.AddItem(aRet[I], nil);
      Form.lstValor.Text := ValorAnterior;
    end
    else if Parametro.tipo = tpCheck then
    begin
      Form.checkValor.Checked := (ValorAnterior = 'V');
      Form.checkValor.Visible := True;
    end
    else
    begin
      Form.edtValor.Visible := True;
      Form.edtValor.Text := ValorAnterior;
    end;

    Form.edtpadrao.Text := Parametro.padrao;
    Form.edthint.Text := Parametro.Hint;
    Form.edtDescricao.Text := Self.CarregaDescricao(tree);
    Form.Parametro := Parametro;
    Form.ShowModal;
    if Form.Tag = 1 then
    begin
      Parametro := Form.Parametro;
    end;
  finally
    Form.Free;
  end;

end;

function TXParametrizacao.Execute: Boolean;
var
  Form: TfrmEditorParametros;
  I: Integer;
  No: TTreeNode;
  s: string;
  pa: TParametro;
  aRet: tArray<string>;
begin

  Result := True;
  Form := TfrmEditorParametros.Create(nil);
  Form.TreeView1.Items.BeginUpdate;
  Form.TreeView1.Items.Assign(Self.Items);
  Form.TreeView1.Items.EndUpdate;
  Form.Parametros := TDictionary<String, TParametro>.Create;
  for I := 0 to Self.Items.Count - 1 do
  begin
    s := Funcoes.PegaParent(Self.Items[I]);
    pa := TParametro.Create(nil);
    aRet := Self.Items[I].Text.Split(['|']);
    if Length(aRet) = 5 then
    begin
      pa.Nome := aRet[0];
      pa.valores := aRet[1];
      pa.padrao := aRet[2];
      pa.tipo := TFuncoes.IIf(aRet[3] = 'C', tpCheck,
        TFuncoes.IIf(aRet[3] = 'L', tpLista, TFuncoes.IIf(aRet[3] = 'I',
        tpintervalo, tpValor)));
      pa.Hint := aRet[4];

    end
    else
    begin
      pa.Nome := Self.Items[I].Text;
      pa.valores := '';
      pa.padrao := '';
      pa.tipo := tpValor;

    end;
    Form.Parametros.Add(s, pa);

    s := '';
  end;

  for I := 0 to Form.TreeView1.Items.Count - 1 do
  begin
    s := '';
    s := Funcoes.PegaParent(Form.TreeView1.Items[I]);
    pa := TParametro.Create(nil);
    aRet := Form.TreeView1.Items[I].Text.Split(['|']);

    if Length(aRet) = 5 then
    begin
      Form.TreeView1.Items[I].Text := aRet[0];
    end;

  end;

  try
    if Form.ShowModal = mrOk then
    begin
      // TreeView := form.TreeView1;

    end
    else

      Self.Items.BeginUpdate;
    Self.Items.Assign(Form.TreeView1.Items);
    Self.Items.EndUpdate;

    for I := 0 to Self.Items.Count - 1 do
    begin
      s := '';
      s := Funcoes.PegaParent(Self.Items[I]);
      pa := TParametro.Create(nil);
      Form.Parametros.TryGetValue(s, pa);

      if Assigned(pa) then
      begin
        Self.Items[I].Text := pa.Nome + '|' + pa.valores + '|' + pa.padrao + '|'
          + TFuncoes.IIf(pa.tipo = tpCheck, 'C', TFuncoes.IIf(pa.tipo = tpLista,
          'L', TFuncoes.IIf(pa.tipo = tpintervalo, 'I', 'V'))) + '|' +
          pa.Hint + '|';
      end;

      s := '';
    end;

    Result := True;
    if Assigned(TreeView) then
      CarregaParametros(TreeView, Self.ImageIndex);
  finally
    Form.Free;
  end;

end;

procedure TXParametrizacao.LocalizaParametro(Key: Char);
var
  Form: TFrmLocalizaParametro;
  No: TTreeNode;

begin
  if Assigned(TreeView) then
  begin
    Form := TFrmLocalizaParametro.Create(Self);
    try
      Form.edtTextoLocalizar.Text := Trim(Key);
      Form.ShowModal();
      if Form.edtTextoLocalizar.Text <> '' then
        fListaNo :=  TList<TTreeNode>.Create;
        fListaNo := Funcoes.LocalizaNO(TreeView, Form.edtTextoLocalizar.Text);
      if FListaNo.Count = 0 then

        ShowMessage('Parâmetro não localizado !');

    finally
      Form.Free;
    end;
  end
  else
    ShowMessage('TreeView não definido no componente');

end;

function TXParametrizacao.ValorParametro(Nome: string): String;
var
  p: Integer;
begin

  if TFuncoes.tirasimbolos(Nome,'0123456789') <> '' then
  begin

    if (DescricaoParametros.TryGetValue(Nome, Self.fParametro) = False) then
      Self.Parametro := TParametro.Create(nil);

    if Parametro.Valor = '' then
      Exit(Self.Parametro.padrao)
    else
      Exit(Self.Parametro.Valor);
  end
  else
  begin
    if (Parametros.TryGetValue(Nome, Self.fParametro) = False) then
      Self.Parametro := TParametro.Create(nil);

    if Parametro.Valor = '' then
      Exit(Self.Parametro.padrao)
    else
      Exit(Self.Parametro.Valor);
  end;
end;

procedure TXParametrizacao.SetImageIndex(const Value: Integer);
begin
  fImageIndex := Value;
  try
    if (csDesigning in ComponentState) then
      CarregaParametros(TreeView, Value);
  except
    on E: Exception do
  end;

end;

procedure TXParametrizacao.SetImageIndexParametros(const Value: Integer);
begin
  fImageIndexParametros := Value;
  try
    if (csDesigning in ComponentState) then
      CarregaParametros(TreeView, Self.ImageIndex);
  except
    on E: Exception do
  end;

end;

procedure TXParametrizacao.SetListaNo(const Value: TList<ttreenode>);
begin
  FListaNo := Value;
end;

procedure TXParametrizacao.SetTreeView(const Value: TTreeView);
begin
  fTreeView := Value;
  if Assigned(fTreeView) then
    CarregaParametros(fTreeView, Self.ImageIndex);
end;

procedure TXParametrizacao.TVCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  inherited;

end;

{ TParametro }

end.
