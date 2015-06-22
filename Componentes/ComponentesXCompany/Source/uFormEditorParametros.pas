unit uFormEditorParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  uClasseParametros, Vcl.Buttons, System.Generics.Collections, RzCmboBx,
  uClasseFuncoes, RzButton, uXCompanyBotoes, Vcl.Mask, RzEdit, uXEdit,
  uXComboBox, RzPanel, Vcl.ExtCtrls, RzRadGrp;

type
  TfrmEditorParametros = class(TForm)
    TreeView1: TTreeView;
    btnAdd: TSpeedButton;
    btnRemove: TSpeedButton;
    btnConfirma: Tbutton;
    SpeedButton1: TSpeedButton;
    xBtnCoringa1: TxBtnCoringa;
    rdGrupo: TRzRadioGroup;
    painel1: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNome: TxEdit;
    edtValores: TxEdit;
    edtPadrao: TxEdit;
    edtHint: TMemo;
    edtTipo: TxComboBox;
    Label6: TLabel;
    edtNomeGrupo: TxEdit;
    edtId: TxEdit;
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure btnInserirClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure xBtnCoringa1Click(Sender: TObject);
    procedure edtTipoChange(Sender: TObject);

    procedure edtValoresExit(Sender: TObject);
    procedure edtPadraoExit(Sender: TObject);
    procedure rdGrupoExit(Sender: TObject);
  private

    { Private declarations }
  public
    Parametros: TDictionary<String, TParametro>;
    { Public declarations }
  end;

var
  frmEditorParametros: TfrmEditorParametros;

implementation

uses uxParametrizacao;
{$R *.dfm}

procedure TfrmEditorParametros.btnAddClick(Sender: TObject);
begin
  btnRemove.Enabled := False;
  btnConfirma.Enabled := True;
  if TreeView1.Items.Count > 0 then
  begin
    TreeView1.Selected.Expand(True);
    TreeView1.Selected := TreeView1.Items.AddChild(TreeView1.Selected, '');
  end
  else
    TreeView1.Selected := TreeView1.Items.AddChild(nil, '');
  edtNome.SetFocus;
end;

procedure TfrmEditorParametros.btnConfirmaClick(Sender: TObject);
var
  s: string;
  p: TParametro;
  texto: String;
  aRet: TArray<String>;

begin

  if TreeView1.Selected.Level = 0 then
  begin
    TreeView1.Selected.Text := edtNomeGrupo.Text;
    s := '';

    s := Funcoes.PegaParent(TreeView1.Selected);
    p := TParametro.Create(nil);
    if (Parametros.TryGetValue(s, p) = True) then
    begin
      p.Nome := edtNomeGrupo.Text;
      p.padrao := rdGrupo.ItemIndex.ToString;
    end
    else
    begin
      p := TParametro.Create(nil);
      p.Nome := edtNomeGrupo.Text;
      p.padrao := rdGrupo.ItemIndex.ToString;
      Parametros.Add(s, p);

    end;

  end
  else
  begin
    texto := edtValores.Text;
    aRet := texto.Split([',']);
    if ((edtTipo.Value = 'L') and (Length(aRet) = 0)) or
      ((edtTipo.Value = 'I') and (Length(aRet) <> 2)) then
    begin
      ShowMessage('Valores inválido para o tipo !');
      edtValores.SetFocus;

    end
    else
    begin
      btnRemove.Enabled := False;
      btnConfirma.Enabled := False;
      TreeView1.Selected.Text := edtNome.Text;
      s := '';
      s := Funcoes.PegaParent(TreeView1.Selected);

      p := TParametro.Create(nil);
      if (Parametros.TryGetValue(s, p) = True) then
      begin
        p.Nome := edtNome.Text;
        p.Valores := edtValores.Text;
        p.padrao := edtPadrao.Text;
        p.Tipo := TFuncoes.IIf(edtTipo.Value = 'C', tpCheck,
          TFuncoes.IIf(edtTipo.Value = 'L', tpLista,
          TFuncoes.IIf(edtTipo.Value = 'I', tpintervalo, tpValor)));
        p.Hint := edtHint.Text;
      end
      else
      begin

        p := TParametro.Create(nil);
        p.Nome := edtNome.Text;
        p.Valores := edtValores.Text;
        p.padrao := edtPadrao.Text;
        p.Tipo := TFuncoes.IIf(edtTipo.Value = 'C', tpCheck,
          TFuncoes.IIf(edtTipo.Value = 'L', tpLista,
          TFuncoes.IIf(edtTipo.Value = 'I', tpintervalo, tpValor)));
        p.Hint := edtHint.Text;
        Parametros.Add(s, p);
      end;

    end;
  end;

end;

procedure TfrmEditorParametros.btnInserirClick(Sender: TObject);
begin
  // Edit1.Text  := TreeView1.Items[4].Index.ToString;
end;

procedure TfrmEditorParametros.btnRemoveClick(Sender: TObject);
begin
  btnRemove.Enabled := False;
  btnConfirma.Enabled := False;
  TreeView1.Selected.Delete;

end;

procedure TfrmEditorParametros.edtTipoChange(Sender: TObject);
begin

  if edtTipo.Value = 'C' then
  begin
    edtValores.Text := 'V,F';
    edtPadrao.Text := 'F';
    edtValores.Enabled := False;
  end
  else
  begin
    edtValores.Enabled := True;
  end;
end;

procedure TfrmEditorParametros.edtPadraoExit(Sender: TObject);
var
  aRet: TArray<string>;
  s: string;
  i: Integer;
  r: Boolean;
begin
  r := False;
  s := edtValores.Text;
  aRet := s.Split([',']);
  if edtTipo.Value = 'I' then
  begin
    if Length(aRet) <> 2 then
    begin
      ShowMessage('Erro na lista de valores');
      edtValores.SetFocus;
    end
    else
    begin

      if (StrToIntDef(edtPadrao.Text,0) >= StrToIntDef(aRet[0],0)) and (StrToIntDef(edtPadrao.Text,0) <= StrToIntDef(aRet[1],0)) then
        r := True;
    end;
  end
  else if edtValores.Text = '' then
      r := True

  else
  begin
    for i := 0 to Length(aRet) - 1 do
    begin

      if aRet[i] = edtPadrao.Text then
        r := True;

    end;
  end;
  if NOT r then
    edtPadrao.Text := '';

end;

procedure TfrmEditorParametros.SpeedButton1Click(Sender: TObject);
begin
  btnRemove.Enabled := False;
  btnConfirma.Enabled := True;
  rdGrupo.ItemIndex := 0;
  TreeView1.Selected := TreeView1.Items.AddChild(nil, '');
  edtNomeGrupo.Text := '';
  edtNomeGrupo.SetFocus;

end;

procedure TfrmEditorParametros.TreeView1Change(Sender: TObject;
  Node: TTreeNode);
var
  aRet: TArray<string>;
  s: String;
  p: TParametro;
begin
  edtNome.Text := Node.Text;
  btnRemove.Enabled := True;
  btnConfirma.Enabled := True;
  s := '';
  s := Funcoes.PegaParent(Node);
  if TreeView1.Selected.Level = 0 then
  begin
    painel1.Visible := False;
    rdGrupo.Visible := True;
    Label6.Visible := True;
    edtNomeGrupo.Visible := True;

  end
  else
  begin
    painel1.Visible := True;
    rdGrupo.Visible := False;
    Label6.Visible := False;
    edtNomeGrupo.Visible := False;
  end;
  p := TParametro.Create(nil);
  if (Parametros.TryGetValue(s, p) = True) then
  begin

    edtNome.Text := p.Nome;
    edtValores.Text := p.Valores;
    edtPadrao.Text := p.padrao;
    edtNomeGrupo.Text := p.Nome;
    rdGrupo.ItemIndex := StrToIntDef(p.padrao, 0);
    case p.Tipo of
      tpValor:
        begin
          edtTipo.Value := 'V';
        end;
      tpLista:
        begin
          edtTipo.Value := 'L';
        end;
      tpintervalo:
        begin
          edtTipo.Value := 'I';
        end;
      tpCheck:
        begin
          edtTipo.Value := 'C';
        end;

    end;
    edtHint.Text := p.Hint;
  end
  else
  begin
    edtValores.Text := '';
    edtPadrao.Text := '';
    edtTipo.Value := 'V';
    edtHint.Text := '';

  end;
  edtId.Text := Funcoes.PegaParent(Node);
  aRet := s.Split(['|']);

  // p := TestaParametro(Parametro1, aRet,0)  ;
  // Parametro1.Items[0].Nome := 'Testesteste';
  // ShowMessage('fim ' + Parametro1.Items.Count.ToString);
  //

end;

procedure TfrmEditorParametros.TreeView1Click(Sender: TObject);
begin
  // Edit1.Text := TreeView1.Items.
end;

procedure TfrmEditorParametros.xBtnCoringa1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditorParametros.edtValoresExit(Sender: TObject);
var
  aRet: TArray<String>;
  s: string;
begin
  s := edtValores.Text;
  aRet := s.Split([',']);

  if edtTipo.Value = 'I' then
  begin
    if Length(aRet) <> 2 then
    begin
      ShowMessage('Erro na lista de valores');
      edtValores.SetFocus;
    end

  end;

end;

procedure TfrmEditorParametros.rdGrupoExit(Sender: TObject);
begin
  edtPadrao.Text := rdGrupo.ItemIndex.ToString;
end;

end.
