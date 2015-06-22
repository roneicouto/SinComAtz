unit uFrmGerador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Vcl.Grids, Vcl.DBGrids,
  RzDBGrid, uXDBGridZebrado, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  Xmlxform, uDmAtualizador, Vcl.StdCtrls, Vcl.DBCtrls, RzDBEdit, RzButton,
  uXCompanyBotoes, uClasseFuncoes, uFrmAguarde, Vcl.Mask, RzEdit, RzBtnEdt,
  uXEdit, uDmImagens, dxGDIPlusClasses, Vcl.ExtCtrls, System.zip, FileCtrl,
  Vcl.Samples.Spin, System.IniFiles;

const
  SELDIRHELP = 1000;

type
  TfrmGerador = class(TForm)
    XMLProviderObjetos: TXMLTransformProvider;
    cdsObjetos: TClientDataSet;
    cdsObjetostipo: TStringField;
    dsObjeto: TDataSource;
    cdsTabela: TClientDataSet;
    btnProcessar: TxBtnCoringa;
    cdsCatalogo: TClientDataSet;
    cdsTabelascript_create: TWideMemoField;
    cdsObjetosdefinicao: TWideMemoField;
    cdsTabelas: TClientDataSet;
    cdsTabelastipo: TStringField;
    cdsTabelasnome: TStringField;
    cdsTabelasdefinicao: TWideMemoField;
    cdsTabelasindices: TWideMemoField;
    DataSource1: TDataSource;
    Label1: TLabel;
    edtArquivo: TxButtonEdit;
    cdsConstraints: TClientDataSet;
    cdsTriggers: TClientDataSet;
    cdsConstraintstipo: TWideMemoField;
    cdsConstraintsnome: TWideMemoField;
    cdsConstraintstabela: TWideMemoField;
    cdsConstraintstabelaestrangeira: TWideMemoField;
    cdsConstraintscoluna: TWideMemoField;
    cdsConstraintscolunaestrangeira: TWideMemoField;
    cdsConstraintsacaoupdate: TWideMemoField;
    cdsConstraintsacaodelete: TWideMemoField;
    cdsTabelasconstraints: TWideMemoField;
    xBtnCoringa1: TxBtnCoringa;
    OpenDialog1: TOpenDialog;
    dsCatalogo: TDataSource;
    cdsCatalogoid: TIntegerField;
    cdsCatalogoschema: TWideStringField;
    cdsCatalogonome: TWideMemoField;
    cdsCatalogotipo: TWideMemoField;
    cdsCatalogotipodesincronismodedados: TIntegerField;
    cdsCatalogotamanho: TWideStringField;
    cdsCatalogoscopo: TWideMemoField;
    cdsTriggersoid: TIntegerField;
    cdsTriggersschemaname: TWideStringField;
    cdsTriggerstablename: TWideStringField;
    cdsTriggerstriggername: TWideStringField;
    cdsTriggersfunction_name: TWideStringField;
    cdsTriggersResultdatatype: TWideMemoField;
    cdsTriggersArgumentdatatypes: TWideMemoField;
    cdsTriggersType: TWideMemoField;
    cdsTriggerstrigger_def: TWideMemoField;
    edtSenha: TMaskEdit;
    edtUsuario: TxEdit;
    edtBanco: TxEdit;
    edtHost: TxEdit;
    Label5: TLabel;
    edtPorta: TSpinEdit;
    LbIPServi: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BtnTestaConexao: TxBtnCoringa;
    cdsTabelasprimarykey: TWideMemoField;
    cdsObjetosnome: TWideMemoField;
    procedure FormShow(Sender: TObject);
    procedure btnProcessarClick(Sender: TObject);
    procedure edtArquivoButtonClick(Sender: TObject);
    procedure xBtnCoringa1Click(Sender: TObject);
    procedure BtnTestaConexaoClick(Sender: TObject);
  private
    { Private declarations }
    ZipFile: TZipFile;
    IniConfig: TIniFile;
    function BuscaConteudoTabela(pSchema: string; pTabela: string;
      TipoSincronismo: Integer): WideString;
    procedure BuscaTrigger(pSchema: string);
    function BuscaConstraintsTabela(pSchema: string; pTabela: string)
      : WideString;
    function BuscaPrimaryKeyTabela(pSchema: string; pTabela: string)
      : WideString;
    function BuscaIndicesTabela(pSchema: string; pTabela: string): WideString;
    function Conectar: Boolean;
  public
    { Public declarations }
  end;

var
  frmGerador: TfrmGerador;

implementation

{$R *.dfm}

uses uClasseExportar;

procedure TfrmGerador.btnProcessarClick(Sender: TObject);
var
  msg: string;

begin
  frmAguarde.Abrir('AGUARDE: conectando ao banco de dados', SELF,
    Height, Width);
  if not Conectar then
  begin
    TFuncoes.Mensagem('Não foi possível conectar ao servidor especificado');
    frmAguarde.Fechar;
    Exit;
  end;
  IniConfig.WriteString('Conexao', 'IP Servidor', edtHost.Text);
  IniConfig.WriteString('Conexao', 'Nome Banco', edtBanco.Text);
  IniConfig.WriteString('Conexao', 'Usuario Banco', edtUsuario.Text);
  IniConfig.WriteString('Conexao', 'Senha Banco', edtSenha.Text);
  IniConfig.WriteInteger('Conexao', 'Porta Servidor', edtPorta.value);

  // cdsCatalogo.Params.ParamByName('tipo').Value := 'Table';
  ZipFile := TZipFile.Create;
  ZipFile.Open(edtArquivo.Text, zmWrite);

  frmAguarde.Informacao := 'AGUARDE... Gerando arquivo de atualização';
  Application.ProcessMessages;
  try
    frmAguarde.Abrir(msg, SELF);
        cdsObjetos.FileName := '';
    cdsCatalogo.Close;
    cdsCatalogo.Open;
    cdsObjetos.Close;
    cdsObjetos.CreateDataSet;
    cdsTabelas.Close;
    cdsTabelas.CreateDataSet;
    cdsCatalogo.First;
    while not cdsCatalogo.Eof do
    begin
      cdsTabela.Params.ParamByName('Tabela').value := cdsCatalogonome.value;
      cdsTabela.Params.ParamByName('Tipo').value := cdsCatalogotipo.value;
      cdsTabela.Params.ParamByName('scopo').value := cdsCatalogoscopo.AsString;
      // if (cdsTabela.Params.ParamByName('Tipo').Value = 'Trigger Function') or
      // (cdsTabela.Params.ParamByName('Tipo').Value = 'Function') then
      // cdsTabela.Params.ParamByName('Tabela').Value :=
      // cdsCatalogoespecific_name.Value;

      Application.ProcessMessages;
      cdsTabela.Close;
      cdsTabela.Open;
      if not cdsTabela.IsEmpty then
      begin
        if cdsCatalogotipo.value = 'Table' then
        begin
          cdsTabelas.Append;
          cdsTabelastipo.value := cdsCatalogotipo.value;
          cdsTabelasnome.value := cdsCatalogonome.value;
          cdsTabelasdefinicao.value := cdsTabelascript_create.value;
          if StrToIntDef(cdsCatalogotipodesincronismodedados.AsString, 0)
            in [1, 2] then
            BuscaConteudoTabela(cdsCatalogoschema.value, cdsCatalogonome.value,cdsCatalogotipodesincronismodedados.asinteger );
          cdsTabelasindices.value := BuscaIndicesTabela(cdsCatalogoschema.value,
            cdsCatalogonome.value);
          cdsTabelasconstraints.value :=
            BuscaConstraintsTabela(cdsCatalogoschema.value,
            cdsCatalogonome.value);
          cdsTabelasprimarykey.value :=
            BuscaPrimaryKeyTabela(cdsCatalogoschema.value,
            cdsCatalogonome.value);
          cdsTabelas.Post;
        end
        else
        begin

          cdsObjetos.Append;
          cdsObjetostipo.value := cdsCatalogotipo.value;
          cdsObjetosnome.value := cdsCatalogonome.value;
          cdsObjetosdefinicao.value := cdsTabelascript_create.value;
          cdsObjetos.Post;


        end;
      end;

      cdsCatalogo.Next;
    end;
    BuscaTrigger(cdsCatalogoschema.value);
    cdsObjetos.SaveToFile('objetos.xml');
    cdsTabelas.Close;
    cdsObjetos.Close;


    cdsObjetos.FileName := '';
    cdsTabelas.CreateDataSet;
    cdsObjetos.CreateDataSet;

    ZipFile.Add('tabelas.xml');
    ZipFile.Add('objetos.xml');
    ZipFile.Close;
    frmAguarde.Fechar;
    TFuncoes.Mensagem('Arquivo gerado com sucesso!');
    FreeAndNil(ZipFile);

  except
    on E: Exception do
    begin
      frmAguarde.Fechar;
      TFuncoes.Mensagem('Problema ao gerar o arquivo de atualização objeto: ' +
        cdsCatalogonome.value, mtError, E.Message);
      FreeAndNil(ZipFile);

    end;
  end;

  // cdsObjetos.ApplyUpdates(0);
end;

function TfrmGerador.Conectar: Boolean;
begin

  Try

    dmAtualizador.DbConexao.Close;
    dmAtualizador.DbConexao.Params.Values['hostname'] := edtHost.Text + ':' +
      edtPorta.Text;
    dmAtualizador.DbConexao.Params.Values['Database'] := edtBanco.Text;
    dmAtualizador.DbConexao.Params.Values['User_Name'] := edtUsuario.Text;
    dmAtualizador.DbConexao.Params.Values['Password'] := edtSenha.Text;
    dmAtualizador.DbConexao.Params.Values['Port'] := edtPorta.Text;

    try
      if not dmAtualizador.DbConexao.Connected then
        dmAtualizador.DbConexao.Connected := true;

      Result := dmAtualizador.DbConexao.Connected;
    Except
      On E: Exception do
      begin
        Result := false;
        showmessage('Erro ao conectar ao banco de dados.' + #13#13 + E.Message);

      end;
    end;
  Finally

  End;
end;

procedure TfrmGerador.BtnTestaConexaoClick(Sender: TObject);
begin
  if Conectar then
    TFuncoes.Mensagem('Conexão realizada com sucesso!')
  else
    TFuncoes.Mensagem('Falhou!')

end;

function TfrmGerador.BuscaConstraintsTabela(pSchema, pTabela: string)
  : WideString;
var
  cds: TClientDataSet;

begin
  try
    cds := TClientDataSet.Create(nil);
    Result := '';
    cds := TFuncoes.CriaClientDataSet
      ('select * from vs_constraint where table_name = ' + QuotedStr(pTabela) +
      ' and constraint_schema=' + QuotedStr(pSchema) + ' and constraint_type = '
      + QuotedStr('FOREIGN KEY'));
    if not cds.IsEmpty then
    begin
      while not cds.Eof do
      begin
        Result := Result + 'alter table ' + pTabela + ' add constraint ' +
          cds.FieldByName('conname').value + ' ' + cds.FieldByName('condef')
          .value + ';' + #13 + #10;
        cds.Next;
      end;
    end;
  except
    on E: Exception do
      TFuncoes.Mensagem('Problema ao buscar as  constraints da tabela ' +
        pSchema + '.' + pTabela, mtError, E.Message);
  end;
end;

function TfrmGerador.BuscaConteudoTabela(pSchema, pTabela: string;
  TipoSincronismo: Integer): WideString;
var
  cdsConteudo: TClientDataSet;

begin
  try
    if pTabela = 'cep_enderecos' then
      pTabela := pTabela;
    cdsConteudo := TClientDataSet.Create(nil);
    TFuncoes.CriaClientDataSet('select * from ' + pSchema + '.' + pTabela,
      cdsConteudo);
    Result := '';

    if not cdsConteudo.IsEmpty then
    begin
      if TipoSincronismo = 1 then
        ExpTXT(cdsConteudo, pTabela + '.conteudo')
      else
        cdsConteudo.SaveToFile(pTabela + '.conteudo');

      ZipFile.Add(pTabela + '.conteudo');
    end;
    FreeAndNil(cdsConteudo);

  except
    on E: Exception do
      TFuncoes.Mensagem('Problema ao gerar o conteúdo da tabela' + pSchema + '.'
        + pTabela, mtError, E.Message);
  end;
end;

function TfrmGerador.BuscaIndicesTabela(pSchema, pTabela: string): WideString;
var
  cds: TClientDataSet;

begin
  try
    cds := TClientDataSet.Create(nil);
    Result := '';
    cds := TFuncoes.CriaClientDataSet('select * from vs_indexes where tabela = '
      + QuotedStr(pTabela) + ' and schema=' + QuotedStr(pSchema));
    if not cds.IsEmpty then
    begin
      while not cds.Eof do
      begin
        Result := Result + cds.FieldByName('column_name').value + ';' +
          #13 + #10;
        cds.Next;
      end;
    end;
  except
    on E: Exception do
      TFuncoes.Mensagem('Problema ao buscar os indexes da tabela ' + pSchema +
        '.' + pTabela, mtError, E.Message);
  end;
end;

function TfrmGerador.BuscaPrimaryKeyTabela(pSchema, pTabela: string)
  : WideString;
var
  cds: TClientDataSet;

begin
  try
    cds := TClientDataSet.Create(nil);
    Result := '';
    cds := TFuncoes.CriaClientDataSet
      ('select * from vs_constraint where table_name = ' + QuotedStr(pTabela) +
      ' and constraint_schema=' + QuotedStr(pSchema) +
      ' and constraint_type IN (' + QuotedStr('PRIMARY KEY') + ',' +
      QuotedStr('UNIQUE') + ')');
    if not cds.IsEmpty then
    begin
      while not cds.Eof do
      begin
        Result := Result + 'alter table ' + pTabela + ' add constraint ' +
          cds.FieldByName('conname').value + ' ' + cds.FieldByName('condef')
          .value + ';' + #13 + #10;
        cds.Next;
      end;
    end;
  except
    on E: Exception do
      TFuncoes.Mensagem('Problema ao buscar as  constraints  da tabela ' +
        pSchema + '.' + pTabela, mtError, E.Message);
  end;
end;

procedure TfrmGerador.BuscaTrigger(pSchema: string);
var
  cdsTrigger: TClientDataSet;

begin
  try
    cdsTrigger := TClientDataSet.Create(nil);
    cdsTrigger := TFuncoes.CriaClientDataSet
      ('Select * from vs_trigger_definicao where schemaname=' +
      QuotedStr(pSchema));

    if not cdsTrigger.IsEmpty then
    begin

      cdsTrigger.SaveToFile('trigger.catalogo');

    end;
    FreeAndNil(cdsTrigger);
    ZipFile.Add('trigger.catalogo');

  except
    on E: Exception do
      TFuncoes.Mensagem('Problema ao gerar o catálogo de triggers', mtError,
        E.Message);
  end;
end;

procedure TfrmGerador.edtArquivoButtonClick(Sender: TObject);
var

  Dir: string;
begin
  Dir := extractfilepath(Application.exename);
  if FileCtrl.SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],
    SELDIRHELP) then
    edtArquivo.Text := Dir + '\xcompany_atualizacao_banco.zip';
end;

procedure TfrmGerador.FormShow(Sender: TObject);
begin
  IniConfig := TIniFile.Create(extractfilepath(Application.exename) +
    'gerador.ini');
  edtHost.Text := IniConfig.ReadString('Conexao', 'IP Servidor', 'localhost');
  edtBanco.Text := IniConfig.ReadString('Conexao', 'Nome Banco', 'xcompany');
  edtUsuario.Text := IniConfig.ReadString('Conexao', 'Usuario Banco',
    'postgres');
  edtSenha.Text := IniConfig.ReadString('Conexao', 'Senha Banco', 'admin');
  edtPorta.value := IniConfig.ReadInteger('Conexao', 'Porta Servidor', 5432);

 // cdsObjetos.Close;
 // cdsObjetos.Open;
  edtArquivo.Text := extractfilepath(Application.exename) +
    'arquivo_atualizacao_banco.zip';

end;

procedure TfrmGerador.xBtnCoringa1Click(Sender: TObject);
begin
  Close;
end;

end.
