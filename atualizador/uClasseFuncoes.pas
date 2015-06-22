unit uClasseFuncoes;

interface

uses
  DB, Menus, IdMessage, IdComponent, Jpeg, uXPageControl,
  IdTCPClient, IdMessageClient, IdSMTP, IdExplicitTLSClientServerBase,
  IdSMTPBase, IdTCPConnection, IdText, IdAttachmentFile, Classes, Forms,
  Datasnap.DBClient, SqlExpr, WinApi.Windows, uXPanel,
  Vcl.StdCtrls, StrUtils, Vcl.Dialogs, DBGrids, RzDBGrid, RzTabs, RzButton,
  IdHashMessageDigest,
  RzDBBnEd, Controls, RzDBEdit, Vcl.ComCtrls, Vcl.Graphics, RzPanel, ActnList,
  DBAdvGrid, Variants, SysUtils, ShellApi, RzEdit, uClasseXQuery,
  System.Generics.collections, uXDBGridZebrado,
  RegularExpressions, uXEdit;

type
  TTipoCentralizacao = (CentralizaVertical, CentralizaHorizontal,
    CentralizaVerticalHorizontal);

  TFuncoes = class
  private

  public
    (* Declarações publicas *)
    class function FormataTelefone(NumTelefone: string; PField: TField)
      : integer;
    class function DefineMascaraTelefone(NumTelefone: string;
      PField: TField): integer;
    class function ExtraiNumeros(texto, Numeros: String): string;
    class function ValidarEMail(peMail: string): Boolean;

    class procedure ConvertBMP_JPG(xFile: string; Quality: integer);
    class Function ValidaCPF(cpf: string): Boolean;
    class Function ValidaCNPJ(numCNPJ: string): Boolean;
    class function asc(character: char): integer;
    class function ProximaSequencia(NomeSequencia: string): integer;
    class function SequenciaAtual(NomeSequencia: string): integer;
    class function ValidaId(id: string): Boolean;
    class function Replicate(S: String; qt: integer): String;
    class procedure SimulaShiftTab;
    class procedure FuncionalidadeIdisponivel;
    class procedure Mensagem(texto: String;
      tipoMenssagem: TMsgDlgType = mtInformation; TextoErro: string = '';
      TituloError: string = '');
    class procedure MenssagemMult(pListaMsg: TList<String>;
      pInfoAdicional: string = ''; pWidth: integer = 576;
      pHeight: integer = 282); overload;
    class procedure MenssagemMult(pListaMsg: TStringList;
      pInfoAdicional: string = ''; pWidth: integer = 576;
      pHeight: integer = 282); overload;
    class function Confirma(Pergunta: String): Boolean;

    // Funcao pra corrigir valores do edits dos filtro tipo in
    class function CorrigeIn(S: string): string;
    /// <summary> Tela de pergunta com 3 botões.</summary>
    /// <param name="Titulo"> Titulo da pergunta.</param>
    /// <param name="Pergunta"> Pergunta a ser realizada.</param>
    /// <param name="pTitulos"> Captions dos 3 botões.</param>
    /// <returns> Retorna 1-Primeiro botão, 2-Segundo botão e 3-Terceiro botão</returns>
    class Function PerguntaBotoesConf(Titulo: String; Pergunta: String;
      Botoes: Array Of String): Word;

    class function IIf(Condicao: Boolean; Str1, Str2: Variant): Variant;
    class function EnviarEmail(De, Para, Titulo, Corpo, Arquivo: String;
      usuario: string; senha: string; servidor_smtp: string;
      porta: integer): Boolean;

    class procedure Menu_AddRel(PrintMenu: TPopupMenu; ItemComando: TMenuItem);
    class function PegaValorPK(pDataSet: TDataSet): String;
    // pega campos pk de um dataset

    (* funcoes de data *)
    class function DataEua(Data: TDatetime): String;
    class procedure CentralizarComponente(pComponente, pParent: TWinControl;
      pTipoCentralizacao: TTipoCentralizacao; pAlturaBorda: integer = 12);
    (* data no formato yyyy/mm/dd *)
    class function DiaAtual(): Word;
    class function MesAtual(): Word;
    class function AnoAtual(): Word;
    class function AnoMesDia(Data: TDatetime): string;

    class function ExtraiDia(Data: TDatetime): Word;
    class function ExtraiMes(Data: TDatetime): Word;
    class function ExtraiAno(Data: TDatetime): Word;
    class function MontaData(dia: Word; mes: Word; ano: Word): TDatetime;

    class function UltimoDiaMes(Data: TDatetime): TDatetime; overload;
    class function UltimoDiaMes(mes, ano: Word): TDatetime; overload;
    class function PrimeiroDiaMes(Data: TDatetime): TDatetime; overload;
    class function PrimeiroDiaMes(mes, ano: Word): TDatetime; overload;
    class function DatasDiff(const dataInicial: TDatetime;
      const dataFinal: TDatetime): integer;
    class function DiasNoMes(Data: TDatetime): Word; overload; virtual;
    class function DiasNoMes(mes, ano: Word): Word; overload;
    class function IsDate(Data: string): Boolean;
    class function IsTime(hora: string): Boolean;
    class function DataHoraServidor(): String;
    class function DataServidor(): String;

    (* funcoes numericas *)
    class function IsNum(Data: string): Boolean; overload;
    class function IsNum(Field: TField): Boolean; overload;
    class function IsInteger(Data: string): Boolean;
    (* Strings *)
    class function QuoteItensLista(texto: string; separador: string = ',')
      : string; overload;
    class function QuoteItensLista(lista: TStringList; separador: string = ',')
      : string; overload;
    class function At(texto, subtexto: string): Boolean;
    class function StrToStringList(separadores: TSysCharSet; texto: String)
      : TStringList; static;
    class function TiraSimbolos(texto: string; Adic: string = ''): string;
    class function TiraAcento(Str: string): string;
    class function CompletaStr(texto, Completa: String; Quant: integer): string;
    class function Codifica(Const Strl: String): string;
    class function CountChar(texto: String; C: char): integer;
    class function sem_acento(texto: string;
      ConvertePraMaiusculas: Boolean = true): string;
    class function PathAplicacao(): string;
    class procedure SimulaAltSetaCima();
    class procedure SimulaAltF4;
    class procedure SimulaTecla(tecla: byte);
    class procedure SimulaTexto(texto: String);
    class procedure LimpaEdits(pOwner: TWinControl);
    class function NumeroFormatoSQL(numero: double;
      decimais: integer = 6): String;
    class function ImagemToBMP(pPicture: TPicture): string;

    (* Auditoria/Segurança *)
    class function GravaAuditoria(Tabela: TDataSet; tipoacao, acao: string;
      CodigoUsuario: integer = 0; num_estacao: smallint = 1): Boolean;

    (* Forms e Pacotes *.DPK *)
    class procedure AbreFormPacote(NomeBPL: string);
    class procedure AbreForm(aForm: TComponentClass; menuTag: integer);
    class procedure CriaFormComNome(strClass: string; menuTag: integer);

    (* Similar a anterior so que salva no HINT do form o nome do objeto que o chamou *)
    /// <summary> Abre o formulário com uma lista de opções.</summary>
    /// <param name="pCaptions"> Captions dos bootões.</param>
    /// <param name="pHints"> Hints dos bootões.</param>
    /// <returns> Retorna o índice do array referente ao caption dos botões ou -1 se nenhum item for escolhido.</returns>

    class function CriaFormPeloNome(strClass: string; MenuItem: string;
      RepositorioPai: TWinControl = nil;
      MultiplasInstanciasDoForm: Boolean = false;
      AbreForm: Boolean = true): TForm;
    /// <summary>Abre o formulário genérico de consulta.</summary>
    /// <returns>String</returns>

    /// <summary>Clonsultas</summary>

    (* *********************************************** *)
    (* FiltrarDados: Chama tela padrao de filtro *)
    (* *********************************************** *)

    (* Diversas *)
    class Function CapsLock(): Boolean;
    class Function NumLock(): Boolean;
    class function InArray(pVal: Variant; pValues: array of Variant)
      : Boolean; overload;
    class function InStringArray(pVal: string;
      pValues: array of string): integer;
    class function InArray(pVal: Variant; pValues: TList<Variant>)
      : Boolean; overload;
    class Function MascaraCasasDecimais(qtdeCasas: integer): string;
    class Function MascaraCasasDecimaisQuantidade(qtdeCasas: integer): string;
    class Function VerificaMascara(texto: string): Boolean;
    class function ChavePrimaria(pTabela: string): string;
    class function ConsultaSqlCampo(InstrucaoSql: string;
      const Prm: array of TVarRec; NumCampo: integer): Variant;
    /// <summary> Cria um objeto TSqlQuery a partir de uma instrução sql</summary>
    /// <param name="sql"> Instrução sql</param>
    /// <param name="pOpenDataSet"> Se True executa o método Open do objeto TSqlQuery</param>
    /// <returns>Retorna um objeto TSqlQuery</returns>
    class Function CriaQuery(sql: String; pOpenDataSet: Boolean = true)
      : TXQuery;
    /// <summary> Cria um objeto TClientDataSet a partir de uma instrução sql</summary>
    /// <param name="sql"> Instrução sql</param>
    /// <param name="pOpenDataSet"> Se True executa o método Open do objeto TClientDataSet</param>
    /// <returns>Retorna um objeto TClientDataSet</returns>
    class function CriaClientDataSet(pSql: string; pOpenDataSet: Boolean = true)
      : TClientDataSet; overload;
    class function CriaClientDataSet(pSql: string;
      var pClientDataSet: TClientDataSet): Boolean; overload;

    class Function ExecQuery(Query: TSqlQuery;
      mostraerro: Boolean = true): String;
    // Executa um instrução e retorna a quantidade de linha afetadas;
    class function ExecSql(var msg: String; sql: string;
      pUsaTransacao: Boolean = true): integer; overload;
    class function ExecSql(pSqls: TStringList; pUsaTransacao: Boolean = true)
      : Boolean; overload;
    class function Clone(pObj: tobject): tobject;
    class procedure ValidaCampoNumerico(Edit: TRzDBEdit; Tamanho: integer);
    class function GetAuditoriaExclusao(Tabela: TDataSet): string;
    class function ValidaIE(Inscricao, Tipo: String): Boolean;
    class function nívelAnterior(classificacao: string): string;
    class function ValidaPost(dataset: TDataSet): Boolean; virtual;
    class function FVal(dataset: TDataSet; NomeDoCampo: String): Variant;
    class procedure NaoPermiteValorMaior(RzDBEdit: TRzDBEdit; valor: double);
    // Valida um field para percentual de validacao (menor que cem e maior que zero)
    class procedure ValidaFieldPercentual(Sender: TField; Text: string;
      pPermiteMaior100: Boolean = false);
    // Valida um field para valor (maior que zero)
    class procedure ValidaFieldValor(Sender: TField; Text: string;
      PermiteNegativo: Boolean = false);

    class procedure RedimensionaGrid(dbg: TxDBGridZebrado;
      AIndiceColunaAutoAjustavel: integer); overload;
    class procedure RedimensionaGrid(dbg: TxDBGridZebrado;
      control: TWinControl); overload;

    // Define cores do componetes

    // CRUD
    class procedure AdicionaDetalhe(cdsMestre, cdsDetalhe: TClientDataSet;
      FieldFoco: TField; GridFoco: TxDBGridZebrado);
    class procedure DesfazDetalhe(cdsDetalhe: TClientDataSet;
      GridFoco: TxDBGridZebrado);

    class procedure GravaDetalhe(cdsMestre, cdsDetalhe: TClientDataSet;
      GridFoco: TxDBGridZebrado);
    class procedure BloqueiaAbas(PageControl: TRzPageControl;
      DataSource: TDataSource);

    class function AdicionaMascaraCpfOuCnpj(CpfCnpj: string): string;
    class function ValidaCpfOuCnpj(CpfCnpj: string;
      lMsg: Boolean = true): Boolean;

    class function RetornaFieldNameRequerido(dataset: TDataSet): string;

    class function ClonaDataSet(CdsClonar: TDataSet;
      updateStatus: TUpdateStatus = TUpdateStatus(nil)): TDataSet;

    // Financeiro
    class function ValorPercentual(pValor, pPercentual: double): double;
    class function PercentualValor(pValorTotal, pValor: double): double;
    class function ExecutaCalculo(Expressao: string; Objeto: tobject): double;
    // class function At( vSearch: Variant; sString: string ): integer;

    // Abre, Executa o arquivo passado no primeiro parâemtro.
    class Function ExecuteFile(const pFileName, pParams, pDir: String;
      ShowCmd: integer = 0): THandle;
    /// <Sumary>Converte uma variavel qualquer em uma valor para ser executada numa query</Sumary>
    /// <Param Name="pValor">Valor</Param>
    /// <Param Name="pDecimais">Casas decimais</Param>
    /// <Param Name="pRound">Arredondamento</Param>
    /// <Rweturns>Retorna uma string convertendo a em ponto</Returns>
    class function FloatToStr(pValor: double; pDecimais: integer = -1;
      pRound: Boolean = false): String;
    class function CompareDateTimeEdit(edTinicio: TxDateTimeEdit;
      edTfim: TxDateTimeEdit): Boolean;
    class function CompareNumericEdit(edTinicio: TxEditNumerico;
      edTfim: TxEditNumerico): Boolean;
  end;

implementation

uses
  DateUtils,
  Datasnap.Provider,
  System.Rtti,
  Data.DBXCommon,
  Generics.collections,
  uFrmMensagem,
  uFrmPerguntaBotoesConf,
  UConexaoBanco,
  Math, RzLstBox, Vcl.ExtCtrls, uXDbText, uFrmMensagensMultiplas,
  uXCompanyBotoes,
  RzBtnEdt, uDmImagens;

{ TFuncoes }

{ tecla NUMLOCK }
class function TFuncoes.NumeroFormatoSQL(numero: double;
  decimais: integer = 6): String;
var
  S: String;
  X: integer;
begin
  S := FloatToStr(RoundTo(numero, -(decimais)));
  X := Pos(',', S);
  if X > 0 then
    S[X] := '.';
  result := S;
end;

class Function TFuncoes.NumLock(): Boolean;
Begin
  if odd(GetKeyState(VK_NUMLOCK)) then
    result := true
  else
    result := false
End;

// Mapea as propriedades de uma classe, e executa um calculo através de uma expressão passada
class Function TFuncoes.ExecutaCalculo(Expressao: string;
  Objeto: tobject): double;
var
  sql: string;
  Query: TSqlQuery;

  procedure CarregaParametros;
  var
    contexto: TRttiContext;
    Tipo: TRttiType;
    propriedade: TRttiProperty;
    I: integer;

  begin
    try
      contexto := TRttiContext.Create;
      Tipo := contexto.GetType(Objeto.ClassType);

      for I := 0 to Query.Params.Count - 1 do
      begin
        try
          propriedade := Tipo.GetProperty(Query.Params[I].Name);
          if propriedade.GetValue(Objeto).AsObject is TField then
          begin
            Query.Params.ParamByName(propriedade.Name).AsFloat :=
              TField(propriedade.GetValue(Objeto).AsObject).AsFloat;
          end
          else
          begin
            Query.Params.ParamByName(propriedade.Name).AsCurrency :=
              propriedade.GetValue(Objeto).AsCurrency;
          end;
        except
          on E: Exception do
            TFuncoes.Mensagem('Propriedade ou Parâmetro ' +
              QuotedStr(Query.Params[I].Name) +
              ' inexistente ou incorreto! Verifique a formula ou propriedades da classe: '
              + Objeto.ClassName, mtError);
        end;
      end;

    finally
      contexto.Free;
    end;
  end;

begin

  try
    sql := 'select ' + Expressao + ' as resultado';
    try
      Query := TSqlQuery.Create(nil);
      Query.SQLConnection := ConexaoBanco.Conexao;
      Query.sql.Text := sql;
      CarregaParametros;
      Query.Open;

      result := Query.FieldByName('resultado').AsFloat;
    except
      on E: Exception do
        TFuncoes.Mensagem(E.Message, mtError);
    end;

  finally
    FreeAndNil(Query);
  end;
end;

class procedure TFuncoes.ConvertBMP_JPG(xFile: string; Quality: integer);
var
  BMP: TBitmap;
  JPG: TJPegImage;
begin
  if ExtractFileExt(xFile) <> '.bmp' then
  begin
    ShowMessage('Formato diferente de bmp' + #13 + 'Formato atual : ' +
      ExtractFileExt(xFile));
    Exit;
  end;
  BMP := TBitmap.Create;
  try
    BMP.LoadFromFile(xFile);
    JPG := TJPegImage.Create;
    try
      JPG.CompressionQuality := Quality;
      JPG.Assign(BMP);
      JPG.SaveToFile(ChangeFileExt(xFile, '.jpg'));
    finally
      FreeAndNil(JPG);
    end;
  finally
    FreeAndNil(BMP);
  end;
end;

// Abre, Executa o arquivo passado no primeiro parâemtro.
class function TFuncoes.ExecuteFile(const pFileName, pParams, pDir: String;
  ShowCmd: integer = 0): THandle;
var
  FileName, Params, Dir: array [0 .. 79] of char;
begin
  result := ShellExecute(Application.MainForm.Handle, nil,
    StrPCopy(FileName, pFileName), StrPCopy(Params, pParams),
    StrPCopy(Dir, pDir), ShowCmd);
end;

class Function TFuncoes.ProximaSequencia(NomeSequencia: string): integer;
var
  QrTemp: TSQLDataSet;
begin
  QrTemp := TSQLDataSet.Create(nil);
  QrTemp.SQLConnection := ConexaoBanco.Conexao;
  QrTemp.CommandText := ' SELECT NEXTVAL(' + QuotedStr(NomeSequencia) +
    ') as proximo';
  Try
    QrTemp.Open;
    result := QrTemp.FieldByName('proximo').AsInteger;
  Except
    on E: Exception do
    begin
      result := 0;
      raise Exception.Create('Erro: ' + E.Message);
    end;
  End;
end;

class function TFuncoes.SequenciaAtual(NomeSequencia: string): integer;
var
  Query: TSqlQuery;
  sql: string;
begin

  try
    sql := 'select last_value as sequencia from ' + NomeSequencia;
    Query := TFuncoes.CriaQuery(sql);
    result := Query.FieldByName('sequencia').AsInteger;
  finally
    FreeAndNil(Query);
  end;
end;

class procedure TFuncoes.NaoPermiteValorMaior(RzDBEdit: TRzDBEdit;
  valor: double);
var
  caractere: char;
begin
  if (RzDBEdit.Text <> '') and (RzDBEdit.DataSource.State in [dsInsert, dsedit])
  then
  begin
    if Pos('-', RzDBEdit.Text) > 0 then
    begin
      RzDBEdit.Text := '0';
      RzDBEdit.SetFocus;
    end;
    if TFuncoes.IsNum(RzDBEdit.Text) then
    begin
      if (StrToFloat(RzDBEdit.Text) > valor) then
      begin
        RzDBEdit.Text := Copy(RzDBEdit.Text, 0, (Length(RzDBEdit.Text) - 1));

        if Pos(',', RzDBEdit.Text) = Length(RzDBEdit.Text) then
        begin
          RzDBEdit.Text := Copy(RzDBEdit.Text, 0, (Length(RzDBEdit.Text) - 1));
        end;

        RzDBEdit.SelStart := Length(RzDBEdit.Text);
        RzDBEdit.SetFocus;

        TFuncoes.Mensagem(('Só é permitido valor entre ( 0,00 e ' +
          FloatToStr(valor) + ',00)!'), mtInformation);
      end;
    end
    else
    begin
      RzDBEdit.Text := Copy(RzDBEdit.Text, 0, (Length(RzDBEdit.Text) - 1));
      RzDBEdit.SelStart := Length(RzDBEdit.Text);
      RzDBEdit.SetFocus;
    end;
  end;
end;

// Retorna o valor corresponde ao percentual do valor informado
class function TFuncoes.ValorPercentual(pValor, pPercentual: double): double;
begin
  result := pValor * (pPercentual / 100.00);
end;

// Retorna o percentual correspondente do valorTotal informado
class function TFuncoes.PercentualValor(pValorTotal, pValor: double): double;
begin
  result := (pValor * 100.00) / TFuncoes.IIf(pValorTotal = 0, 1, pValorTotal);
end;

(* Cria e retorno instrucao sql do filtro *)

class function TFuncoes.FloatToStr(pValor: double; pDecimais: integer;
  pRound: Boolean): String;
var
  valor: double;
  texto, parte1, parte2: String;
  posPonto: integer;
begin

  if pDecimais >= 0 then
  begin
    pValor := TFuncoes.IIf(pRound, RoundTo(pValor, -pDecimais), pValor);
    texto := pValor.ToString.Replace('.', '').Replace(',', '.');
    posPonto := TFuncoes.IIf(Pos('.', texto) > 0, Pos('.', texto) - 1,
      Length(texto));
    parte1 := texto.Substring(0, posPonto);
    parte2 := texto.Substring(posPonto, pDecimais);
    texto := parte1 + TFuncoes.IIf(pDecimais > 0, '.' + parte2, '');
  end
  else
    texto := pValor.ToString.Replace('.', '').Replace(',', '.');

  result := texto;
end;

class procedure TFuncoes.FuncionalidadeIdisponivel;
begin
  TFuncoes.Mensagem('Funcionalidade ainda não implementada!');
end;

class function TFuncoes.FVal(dataset: TDataSet; NomeDoCampo: String): Variant;
begin
  with dataset.FieldByName(NomeDoCampo) do
  begin

    if DataType = ftString then
      result := AsString
    else if DataType IN [ftInteger, ftSmallint, ftWord, ftAutoInc, ftLongWord,
      ftShortInt, ftByte] then
      result := AsInteger
    else if DataType = ftLargeInt then
      result := AsLargeInt
    else if DataType = ftBoolean then
      result := AsBoolean
    else if DataType = ftFloat then
      result := AsFloat
    else if DataType = ftSingle then
      result := AsSingle
    else if DataType = ftCurrency then
      result := AsCurrency
    else if DataType = ftFMTBcd then
      result := AsFloat
    else if DataType IN [ftDate, ftDateTime] then
      result := AsDateTime
    else if DataType IN [ftMemo, ftWideMemo, ftWideString] then
      result := AsWideString
    else
      result := Value;
  end;
end;

class function TFuncoes.nívelAnterior(classificacao: string): string;
var
  resultado: string;
  conteudo: TStringList;
  indice: integer;
begin
  classificacao := Trim(classificacao);
  classificacao := StringReplace(classificacao, '. ', '.', [rfReplaceAll]);
  classificacao := StringReplace(classificacao, '..', '.', [rfReplaceAll]);
  indice := Length(classificacao);
  if (classificacao[indice] = '.') then
  begin
    classificacao := Copy(classificacao, 0, (indice - 1));
    indice := indice - 1;
  end;

  resultado := '';
  while (indice - 1) > 0 do
  begin
    if (classificacao[indice] = '.') and (classificacao[indice - 1] <> ' ') then
    begin
      resultado := Copy(classificacao, 0, (indice - 1));
      Break;
    end;
    indice := indice - 1;
  end;
  result := resultado;
end;

class function TFuncoes.ValidarEMail(peMail: string): Boolean;
var
  bRegExp: String;
begin
  bRegExp := '[_a-zA-Z\d\-\.]+@([_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+)';
  result := TRegEx.IsMatch(peMail, bRegExp);
end;

class function TFuncoes.FormataTelefone(NumTelefone: string;
  PField: TField): integer;
var
  num: string;
begin
  begin
    num := TFuncoes.TiraSimbolos(NumTelefone);
    TWideStringField(PField).EditMask := TFuncoes.IIf(Length(num) <= 10,
      '(99)9999-9999;1;_', '(99)99999-9999;1;_');
    PField.AsString := FormatFloat(TFuncoes.IIf(Length(num) <= 10,
      '(00)0000-0000', '(00)00000-0000'), num.ToDouble);
  end;
end;

{ tecla NUMLOCK }
class Function TFuncoes.CapsLock(): Boolean;
Begin
  if odd(GetKeyState(VK_CAPITAL)) then
    result := true
  else
    result := false
End;

class function TFuncoes.ChavePrimaria(pTabela: string): string;
var
  qry: TXQuery;
  sql: string;
begin
  try
    sql := 'SELECT a.attname AS chave_pk FROM pg_class c' +
      ' INNER JOIN pg_attribute a ON (c.oid = a.attrelid) ' +
      ' INNER JOIN pg_index i ON (c.oid = i.indrelid) WHERE' +
      '  i.indkey[0] = a.attnum AND i.indisprimary = ' + QuotedStr('t') +
      ' AND Upper(c.relname) = ' + UpperCase(pTabela.QuotedString) + '';
    qry := TXQuery(TFuncoes.CriaQuery(sql));
    result := qry.AsStr('chave_pk');
  finally
    FreeAndNil(qry);
  end;
end;

{ class function TFuncoes.CarregaPessoa(cpfOuCnpj: string;
  Tabela: TDataSet): boolean;
  var
  Pessoa: TPessoa;
  begin
  Pessoa := TPessoa.Create;
  Result := false;
  try
  Tabela.FieldByName('cpfcnpj').Value := TFuncoes.AdicionaMascaraCpfOuCnpj
  (cpfOuCnpj);
  if (Tabela.Fields.FindField('pessoafisica') <> nil) then
  begin
  if Length(Tabela.FieldByName('cpfcnpj').AsString) = 14 then
  begin
  Tabela.FieldByName('pessoafisica').AsInteger := 1;
  end
  else if Length(Tabela.FieldByName('cpfcnpj').AsString) = 18 then
  begin
  Tabela.FieldByName('pessoafisica').AsInteger := 0;
  end;
  end;

  if Pessoa.ConsultarPessoa(cpfOuCnpj) then
  begin
  Result := true;
  if (Tabela.Fields.FindField('codigopessoa') <> nil) then
  begin
  Tabela.FieldByName('codigopessoa').AsInteger := Pessoa.codigoPessoa;
  end;

  if (Tabela.Fields.FindField('nome') <> nil) then
  begin
  Tabela.FieldByName('nome').AsString := Pessoa.Nome;
  end;

  if (Tabela.Fields.FindField('sexo') <> nil) then
  begin
  Tabela.FieldByName('sexo').AsString := Pessoa.Sexo;
  end;

  if (Tabela.Fields.FindField('pessoafisica') <> nil) then
  begin
  Tabela.FieldByName('pessoafisica').AsInteger := Pessoa.PessoaFisica;
  end;

  if (Tabela.Fields.FindField('datanascimento') <> nil) then
  begin
  Tabela.FieldByName('datanascimento').AsDateTime :=
  Pessoa.DataNascimento;
  end;

  if (Tabela.Fields.FindField('Rg') <> nil) then
  begin
  Tabela.FieldByName('Rg').AsString := Pessoa.RG;
  end;

  if (Tabela.Fields.FindField('apelidonomefantasia') <> nil) then
  begin
  Tabela.FieldByName('apelidonomefantasia').AsString :=
  Pessoa.ApelidoNomeFantasia;
  end;

  if (Tabela.Fields.FindField('fax') <> nil) then
  begin
  Tabela.FieldByName('fax').AsString := Pessoa.Fax;
  end;

  if (Tabela.Fields.FindField('email') <> nil) then
  begin
  Tabela.FieldByName('email').AsString := Pessoa.Email;
  end;

  if (Tabela.Fields.FindField('celular') <> nil) then
  begin
  Tabela.FieldByName('celular').AsString := Pessoa.Celular;
  end;

  if (Tabela.Fields.FindField('fone') <> nil) then
  begin
  Tabela.FieldByName('fone').AsString := Pessoa.Telefone;
  end;

  // Carrega o endreço da pessoa
  CarregaEndereco(Pessoa.Endereco.Endereco.IdLogradouro, Tabela);

  if (Tabela.Fields.FindField('numeroendereco') <> nil) then
  begin
  Tabela.FieldByName('numeroendereco').AsString := Pessoa.NumeroEndereco;
  end;

  if (Tabela.Fields.FindField('complemento') <> nil) then
  begin
  Tabela.FieldByName('complemento').AsString := Pessoa.Complemento;
  end;
  end;

  finally
  FreeAndNil(Pessoa);
  end;
  end; }

{ Clona um ClientDataSet somente com os registros atuais exibidos }
class function TFuncoes.ClonaDataSet(CdsClonar: TDataSet;
  updateStatus: TUpdateStatus = TUpdateStatus(nil)): TDataSet;
var
  bmRegistroAtual: TBookmark;
  I, J: integer;
  cdsClone: TClientDataSet;
begin
  if CdsClonar.Active then
  begin
    bmRegistroAtual := CdsClonar.GetBookmark;
    cdsClone := TClientDataSet.Create(nil);
    cdsClone.FieldDefs := CdsClonar.FieldDefs;

    for J := 0 to cdsClone.FieldDefs.Count - 1 do
    begin
      if cdsClone.FieldDefs[J].DataType = ftDataSet then
      begin
        cdsClone.FieldDefs.Delete(J);
      end;
    end;
    cdsClone.CreateDataSet;

    CdsClonar.First;
    if CdsClonar.State = dsBrowse then
      while not CdsClonar.Eof do
      begin
        cdsClone.Append;
        for I := 0 to CdsClonar.FieldCount - 1 do
        begin
          if not(CdsClonar.Fields[I] is TDataSetField) then
          begin
            if updateStatus = TUpdateStatus(nil) then
            begin
              cdsClone.FieldValues[CdsClonar.Fields[I].FieldName] :=
                CdsClonar.FieldValues[CdsClonar.Fields[I].FieldName];
            end
            else if CdsClonar.updateStatus = updateStatus then
            begin
              cdsClone.FieldValues[CdsClonar.Fields[I].FieldName] :=
                CdsClonar.FieldValues[CdsClonar.Fields[I].FieldName];
            end;
          end;
        end;
        CdsClonar.Next;
      end;

    if cdsClone.State <> dsBrowse then
    begin
      cdsClone.Post;
    end;

    if bmRegistroAtual <> nil then
      if CdsClonar.BookmarkValid(bmRegistroAtual) then
      begin
        CdsClonar.Bookmark := bmRegistroAtual;
      end;

    result := cdsClone;
  end;
end;

class function TFuncoes.Clone(pObj: tobject): tobject;
var
  ctx, ctxResult: TRttiContext;
  Tipo, tipoResult: TRttiType;
  prop: TRttiProperty;
  Field: TRttiField;

begin
  try
    if not Assigned(pObj) then
    begin
      raise Exception.Create
        ('Parametro não instanciado. "class function Clone()"');
    end;

    result := pObj.NewInstance;
    ctx := TRttiContext.Create;
    ctxResult := TRttiContext.Create;
    Tipo := ctx.GetType(pObj.ClassInfo);
    tipoResult := ctx.GetType(result.ClassInfo);

    for Field in Tipo.GetFields do
    begin
      tipoResult.GetField(Field.Name).SetValue(result, Field.GetValue(pObj));
    end;

  finally
    ctx.Free;
    ctxResult.Free;
  end;
end;

class procedure TFuncoes.RedimensionaGrid(dbg: TxDBGridZebrado;
  AIndiceColunaAutoAjustavel: integer);
var
  tamanhoAtualGrid, I, scrollVWidth, tamAnteriorColAjustavel: integer;
  a: TxDBGridZebrado;
  Scroll: TScrollBar;
  bScrollBarV, bScrollBarH: Boolean;
begin
  // Verifica se a ScrollBar Horizontal esta visivél
  bScrollBarH := ((GetWindowLong(dbg.Handle, GWL_STYLE) and WS_HSCROLL) <> 0);
  // Verifica se a ScrollBar Vertial esta visivél
  bScrollBarV := ((GetWindowLong(dbg.Handle, GWL_STYLE) and WS_VSCROLL) <> 0);

  tamanhoAtualGrid := 0;
  scrollVWidth := TFuncoes.IIf(bScrollBarV,
    GetSystemMetrics(SM_CXVSCROLL), 6) + 7;
  tamAnteriorColAjustavel := dbg.Columns[AIndiceColunaAutoAjustavel].Width;
  dbg.Columns[AIndiceColunaAutoAjustavel].Width := 10;
  for I := 0 to dbg.Columns.Count - 1 do
  begin
    if dbg.Columns[I].visible then
    begin
      tamanhoAtualGrid := tamanhoAtualGrid + dbg.Columns[I].Width;
    end;
  end;

  if tamanhoAtualGrid < dbg.Width then
  begin
    dbg.Columns[AIndiceColunaAutoAjustavel].Width :=
      dbg.Columns[AIndiceColunaAutoAjustavel].Width +
      (dbg.Width - tamanhoAtualGrid - scrollVWidth);
  end
  else
  begin
    dbg.Columns[AIndiceColunaAutoAjustavel].Width := tamAnteriorColAjustavel;
  end;
end;

class procedure TFuncoes.RedimensionaGrid(dbg: TxDBGridZebrado;
  control: TWinControl);
type
  TArray = Array of integer;
  procedure AjustarColumns(Swidth, TSize: integer; Asize: TArray);
  var
    idx: integer;
  begin
    if TSize = 0 then
    begin
      TSize := dbg.Columns.Count;
      for idx := 0 to dbg.Columns.Count - 1 do
        dbg.Columns[idx].Width := (dbg.Width - dbg.Canvas.TextWidth('AAAAAA'))
          div TSize + 3
    end
    else
    begin
      for idx := 0 to dbg.Columns.Count - 1 do
        dbg.Columns[idx].Width := dbg.Columns[idx].Width +
          (Swidth * Asize[idx] div TSize) + 3;
    end;
  end;

var
  I, idx, Twidth, TSize, Swidth: integer;
  AWidth: TArray;
  Asize: TArray;
  NomeColuna: String;

begin

  SetLength(AWidth, dbg.Columns.Count);
  SetLength(Asize, dbg.Columns.Count);
  Twidth := 0;
  TSize := 0;
  for idx := 0 to dbg.Columns.Count - 1 do
  begin
    NomeColuna := dbg.Columns[idx].Title.Caption;
    dbg.Columns[idx].Width := dbg.Canvas.TextWidth
      (dbg.Columns[idx].Title.Caption + 'A');
    AWidth[idx] := dbg.Columns[idx].Width;
    Twidth := Twidth + AWidth[idx];
    Asize[idx] := dbg.Columns[idx].Field.Size;
    TSize := TSize + Asize[idx];
  end;
  if dgColLines in dbg.Options then
    Twidth := Twidth + dbg.Columns.Count;

  // adiciona a largura da coluna indicada do cursor
  if dgIndicator in dbg.Options then
    Twidth := Twidth + IndicatorWidth;

  Swidth := dbg.ClientWidth - Twidth - (dbg.Columns.Count * 3);
  AjustarColumns(Swidth, TSize, Asize);
  dbg.Width := dbg.Width + dbg.Canvas.TextWidth('AAAAAA');
  dbg.Left := (control.Width - dbg.Width) div 2 -
    (dbg.Canvas.TextWidth('AA') div 2);
end;

class function TFuncoes.Replicate(S: String; qt: integer): String;
var
  n: integer;
begin
  result := '';
  For n := 1 To qt Do
    result := result + S;
end;

class function TFuncoes.PegaValorPK(pDataSet: TDataSet): String;
var
  sRetorno: String;
  I: integer;
begin
  sRetorno := '';
  for I := 0 to pDataSet.Fields.Count - 1 do
  begin
    If pfInkey in pDataSet.Fields[I].ProviderFlags then
    begin
      if sRetorno = '' then
      begin
        sRetorno := pDataSet.Fields[I].DisplayLabel;
        sRetorno := sRetorno + ' = ' + pDataSet.Fields[I].AsString
      end
      else
      begin
        sRetorno := sRetorno + ' E ' + pDataSet.Fields[I].DisplayLabel;
        sRetorno := sRetorno + ' = ' + pDataSet.Fields[I].AsString;
      end;
    end;
  end;
  result := sRetorno;
end;

class function TFuncoes.AnoAtual: Word;
begin
  result := YearOf(date);
end;

class function TFuncoes.AnoMesDia(Data: TDatetime): string;
begin
  result := Format('%4.4d', [YearOf(Data)]) + Format('%2.2d', [MonthOf(Data)]) +
    Format('%2.2d', [DayOf(Data)]);
end;

class function TFuncoes.asc(character: char): integer;
var
  I: integer;
begin
  I := 32;
  while I < 255 do
  begin
    if Chr(I) = character then
      Break;
    I := I + 1;
  end;
  result := I;

end;

(* Completa o parametro com o caracter informado informado tantas vezes *)
class function TFuncoes.CompletaStr(texto, Completa: string;
  Quant: integer): String;
var
  retorna: string;
  z: integer;
begin
  If Length(Trim(texto)) < Quant then
  begin
    retorna := Trim(texto);
    For z := 1 to Quant - Length(retorna) do
      retorna := retorna + Completa;
  end
  Else
    retorna := Copy(texto, 1, Quant);

  result := retorna;
end;

class function TFuncoes.Confirma(Pergunta: String): Boolean;
var
  FrmPerguntaBotoesConf: TFrmPerguntaBotoesConf;
begin
  Try
    FrmPerguntaBotoesConf := TFrmPerguntaBotoesConf.Create(nil);
    FrmPerguntaBotoesConf.Caption := 'Confirmação';
    FrmPerguntaBotoesConf.Label1.Caption := Pergunta;

    FrmPerguntaBotoesConf.Button1.visible := false;
    FrmPerguntaBotoesConf.Button2.Caption := '&Sim';
    FrmPerguntaBotoesConf.Button2.Cancel := false;
    FrmPerguntaBotoesConf.Button2.ModalResult := mrYes;
    FrmPerguntaBotoesConf.Button3.Caption := '&Não';
    FrmPerguntaBotoesConf.Button3.Cancel := true;
    FrmPerguntaBotoesConf.Button3.ModalResult := mrNo;
    FrmPerguntaBotoesConf.ActiveControl := FrmPerguntaBotoesConf.Button2;
    FrmPerguntaBotoesConf.ShowModal;
  Finally
    case FrmPerguntaBotoesConf.ModalResult of
      mrYes:
        result := true;
      mrNo:
        result := false;
    end;
    FreeAndNil(FrmPerguntaBotoesConf);
  End;
end;

class function TFuncoes.DataEua(Data: TDatetime): String;
begin
  result := FormatDateTime('yyyy/mm/dd', Data);
end;

(* retorna data (timestamp) do servidor de banco de dados *)
class function TFuncoes.DataHoraServidor: String;
var
  qryTemp: TSqlQuery;
begin
  qryTemp := TFuncoes.CriaQuery('SELECT current_timestamp as datahoraservidor');
  result := qryTemp.FieldByName('datahoraservidor').AsString;
  FreeAndNil(qryTemp);
end;

(* retorna data do servidor de banco de dados *)
class function TFuncoes.DataServidor: String;
var
  qryTemp: TSqlQuery;
begin
  qryTemp := TFuncoes.CriaQuery('SELECT current_date as dataservidor');
  result := qryTemp.FieldByName('dataservidor').AsString;
  FreeAndNil(qryTemp);
end;

class function TFuncoes.DiaAtual(): Word;
begin
  result := DayOf(date)
end;

class function TFuncoes.DiasNoMes(Data: TDatetime): Word;
begin
  result := DaysInMonth(Data)
end;

class function TFuncoes.DiasNoMes(mes, ano: Word): Word;
begin
  result := DaysInAMonth(ano, mes)
end;

class function TFuncoes.DatasDiff(const dataInicial: TDatetime;
  const dataFinal: TDatetime): integer;
begin
  result := DaysBetween(dataInicial, dataFinal);
end;

class function TFuncoes.IIf(Condicao: Boolean; Str1, Str2: Variant): Variant;
begin
  If Condicao then
    result := Str1
  Else
    result := Str2
end;

class function TFuncoes.ImagemToBMP(pPicture: TPicture): string;
var
  dirBmp: string;
  Bitmap: TBitmap;
begin
  dirBmp := TFuncoes.PathAplicacao + 'img_temp.bmp';
  try
    Bitmap := TBitmap.Create;
    Bitmap.Width := pPicture.Width;
    Bitmap.Height := pPicture.Height;
    Bitmap.Canvas.Draw(0, 0, pPicture.Graphic);
    Bitmap.SaveToFile(dirBmp);
    pPicture.LoadFromFile(dirBmp);
    result := dirBmp;
  finally
    FreeAndNil(Bitmap);
  end;
end;

class function TFuncoes.InArray(pVal: Variant; pValues: TList<Variant>)
  : Boolean;
var
  I: integer;
begin
  result := false;
  for I := 0 to pValues.Count - 1 do
  begin
    if pVal = pValues[I] then
    begin
      result := true;
      Break;
    end;
  end;
end;

class function TFuncoes.InStringArray(pVal: string;
  pValues: array of string): integer;
var
  I: integer;
begin
  for I := 0 to Length(pValues) - 1 do
  begin
    if pVal = pValues[I] then
    begin
      result := I;
      Break;
    end;
  end;
end;

class function TFuncoes.InArray(pVal: Variant;
  pValues: array of Variant): Boolean;
var
  I: integer;
begin
  result := false;
  for I := 0 to Length(pValues) - 1 do
  begin
    if pVal = pValues[I] then
    begin
      result := true;
      Break;
    end;
  end;
end;

(* Retorna verdadeiro caso a string possa ser convertida para data *)
class function TFuncoes.IsTime(hora: string): Boolean;
var
  saida: Boolean;
begin
  saida := true;
  try
    StrToTime(hora);
  except
    on ECONVERTERROR dO
      saida := false;
  end;
  result := saida;
end;

(* Retorna verdadeiro caso a string possa ser convertida para data *)
class function TFuncoes.IsDate(Data: string): Boolean;
var
  saida: Boolean;
begin
  saida := true;
  try
    StrToDate(Data);
  except
    on ECONVERTERROR dO
      saida := false;
  end;
  result := saida;
end;

(* Retorna verdadeiro caso a string possa ser convertida para numero *)
class function TFuncoes.IsNum(Data: string): Boolean;
var
  saida: Boolean;
begin
  saida := true;
  try
    StrToFloat(Data);
  except
    on ECONVERTERROR dO
      saida := false;
  end;
  result := saida;
end;

(* Retorna verdadeiro caso a string possa ser convertida para numero *)
class function TFuncoes.IsInteger(Data: string): Boolean;
var
  saida: Boolean;
begin
  saida := true;
  try
    StrToInt(Data);
  except
    on ECONVERTERROR dO
      saida := false;
  end;
  result := saida;
end;

class function TFuncoes.IsNum(Field: TField): Boolean;
begin
  result := Field.DataType in [ftSmallint, ftWord, ftInteger, ftFMTBcd, ftFloat,
    ftBCD, ftCurrency, ftLargeInt];
end;

// Limpa os edits
class procedure TFuncoes.LimpaEdits(pOwner: TWinControl);
var
  I: integer;
begin
  for I := 0 to pOwner.ComponentCount - 1 do
  begin
    if (pOwner.Components[I] is TxButtonEdit) then
    begin
      TxButtonEdit(pOwner.Components[I]).Clear;
    end;
    if (pOwner.Components[I] is TxEdit) then
    begin
      TxEdit(pOwner.Components[I]).Clear;
    end;
  end;
end;

class function TFuncoes.ExtraiAno(Data: TDatetime): Word;
begin
  result := YearOf(Data);
end;

class function TFuncoes.ExtraiDia(Data: TDatetime): Word;
begin
  result := DayOf(Data);
end;

class function TFuncoes.ExtraiMes(Data: TDatetime): Word;
begin
  result := MonthOf(Data);
end;

(* Retorna o texto contendo o texto com pk excluida *)
class function TFuncoes.GetAuditoriaExclusao(Tabela: TDataSet): string;
var
  I: integer;
  RetornoAuditoria: string;
begin
  for I := 0 to Tabela.Fields.Count - 1 do
  begin
    If pfInkey in Tabela.Fields[I].ProviderFlags then
    begin
      if RetornoAuditoria = '' then
      begin
        RetornoAuditoria := Tabela.Fields[I].DisplayLabel;
        RetornoAuditoria := RetornoAuditoria + ' = ' + Tabela.Fields[I].AsString
      end
      else
      begin
        RetornoAuditoria := RetornoAuditoria + ' E ' + Tabela.Fields[I]
          .DisplayLabel;
        RetornoAuditoria := RetornoAuditoria + ' = ' + Tabela.Fields[I]
          .AsString;
      end;
    end;
  end;
  result := RetornoAuditoria;
end;

(* Ler de um dataset o registro corrente e registra as alteracoes em banco *)
class function TFuncoes.GravaAuditoria(Tabela: TDataSet; tipoacao, acao: string;
  CodigoUsuario: integer = 0; num_estacao: smallint = 1): Boolean;
var
  SqlGrava: TSqlQuery;
  TextoLog: String;
  iUsuario: integer;

  function Campo_OldValue(indiceCampo: integer): string;
  var
    retorno: string;
  begin
    retorno := '';
    try
      if Tabela.Fields[indiceCampo].DataType in [ftString, ftWideString,
        ftBoolean] then
      begin
        if Tabela.Fields[indiceCampo].OldValue <> null then
          retorno := Tabela.Fields[indiceCampo].OldValue
      end
      else if Tabela.Fields[indiceCampo].DataType
        in [ftFloat, ftCurrency, ftInteger, ftSmallint, ftWord, ftBCD,
        ftLargeInt, ftFMTBcd] then
      begin
        if Tabela.Fields[indiceCampo].OldValue <> null then
        begin
          retorno := FloatToStr(Tabela.Fields[indiceCampo].OldValue);
        end;
      end
      else
      begin
        if Tabela.Fields[indiceCampo].DataType
          In [ftDateTime, ftDate, ftTimeStamp] then
        begin
          if Tabela.Fields[indiceCampo].OldValue <> null then
          begin
            retorno := DateToStr(Tabela.Fields[indiceCampo].OldValue)
          end
        end
        else
        begin
          retorno := Tabela.Fields[indiceCampo].OldValue;
        end;
      end;
    finally
      result := retorno;
    end;
  end;

(* Pegando todos os registros alterados caso tipoacao seja igual a "A" *)
  procedure GeraLog();
  var
    I: integer;
    bAlterado: Boolean;
    StrAuxiliar: String;

  begin
    StrAuxiliar := PegaValorPK(Tabela);
    bAlterado := Tabela.State = dsedit;
    if bAlterado then
    begin
      for I := 0 to Tabela.Fields.Count - 1 do
      begin
        if (Tabela.Fields[I].FieldKind <> fkData) then
          Continue;

        if Tabela.Fields[I].DataType = ftDataSet then
          Continue;

        if Tabela.Fields[I].OldValue <> Tabela.Fields[I].Value then
        begin
          SqlGrava.sql.Text :=
            'INSERT INTO auditoriacampos (codigoauditoria, camponome, valorantes, valorapos) '
            + 'VALUES (currval(' + QuotedStr('auditoria_codigoauditoria_seq') +
            '), ' + QuotedStr(Tabela.Fields[I].FieldName) + ', ' +
            QuotedStr(Campo_OldValue(I)) + ', ' +
            QuotedStr(Tabela.Fields[I].AsString) + ');';
          SqlGrava.ExecSql();
        end;
      end;
    end;
  end;

begin
  iUsuario := CodigoUsuario;
  SqlGrava := TSqlQuery.Create(nil);
  SqlGrava.SQLConnection := ConexaoBanco.Conexao;

  SqlGrava.sql.Text :=
    'INSERT INTO auditoria (codigousuario, dataentrada, hora, acao, numeroestacao, tipoacao) '
    + 'VALUES (' + IntToStr(iUsuario) + ', current_date, ' +
    QuotedStr(TimeToStr(time)) + ', ' + QuotedStr(acao) + ', ' +
    IntToStr(num_estacao) + ', ' + tipoacao + ');';
  SqlGrava.ExecSql();

  if Tabela <> nil then
  begin
    GeraLog();
  end;
end;

class function TFuncoes.TiraAcento(Str: string): string;
const
  ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  X: integer;
begin;
  for X := 1 to Length(Str) do
    if Pos(Str[X], ComAcento) <> 0 then
      Str[X] := SemAcento[Pos(Str[X], ComAcento)];
  result := UpperCase(Str);
end;

class function TFuncoes.PathAplicacao(): string;
begin
  result := ExtractFilePath(Application.ExeName);
end;

class function TFuncoes.MascaraCasasDecimais(qtdeCasas: integer): string;
begin
  result := '#,##0.' + StringofChar('0', qtdeCasas);
end;

class function TFuncoes.MascaraCasasDecimaisQuantidade
  (qtdeCasas: integer): string;
begin
  result := '0.' + StringofChar('0', qtdeCasas);
end;

class procedure TFuncoes.Mensagem(texto: String;
  tipoMenssagem: TMsgDlgType = mtInformation; TextoErro: string = '';
  TituloError: string = '');
begin
  if TituloError <> '' then
  begin

  end;
  if texto.Trim <> '' then
  begin
    Try
      FrmMensagem := TFrmMensagem.Create(nil);
      if TituloError <> '' then
      begin
        FrmMensagem.pnError.Titulo.Caption := TituloError;
        FrmMensagem.pnError.MostraTitulo := true;
      end;
      if TextoErro <> '' then
      begin
        FrmMensagem.edtError.Text := TextoErro;

      end
      else
        FrmMensagem.pnError.visible := false;
      FrmMensagem.Messagem(texto, tipoMenssagem);

    Finally
      FreeAndNil(FrmMensagem);
    End;
  end;
end;

class procedure TFuncoes.MenssagemMult(pListaMsg: TStringList;
  pInfoAdicional: string = ''; pWidth: integer = 576; pHeight: integer = 282);
var
  FrmMsg: TfrmMensagensMultiplas;
begin
  if pListaMsg <> nil then
    if pListaMsg.Count > 0 then
    begin
      Try
        FrmMsg := TfrmMensagensMultiplas.Create(pListaMsg, pInfoAdicional,
          pWidth, pHeight);
        FrmMsg.ShowModal;
      Finally
        FreeAndNil(FrmMsg);
      End;
    end;
end;

class procedure TFuncoes.MenssagemMult(pListaMsg: TList<String>;
  pInfoAdicional: string = ''; pWidth: integer = 576; pHeight: integer = 282);
var
  FrmMsg: TfrmMensagensMultiplas;
begin
  if pListaMsg.Count > 0 then
  begin
    Try
      FrmMsg := TfrmMensagensMultiplas.Create(pListaMsg, pInfoAdicional,
        pWidth, pHeight);
      FrmMsg.ShowModal;
    Finally
      FreeAndNil(FrmMsg);
    End;
  end;
end;

(* Funcao de Pergunta com possibilitade de modificar caption dos 2 primeiros botoes *)
class function TFuncoes.PerguntaBotoesConf(Titulo: String; Pergunta: String;
  Botoes: Array Of String): Word;
var
  FrmPerguntaBotoesConf: TFrmPerguntaBotoesConf;
begin
  result := 3;
  Try
    FrmPerguntaBotoesConf := TFrmPerguntaBotoesConf.Create(nil);
    FrmPerguntaBotoesConf.Caption := Titulo;
    FrmPerguntaBotoesConf.Label1.Caption := Pergunta;

    If Botoes[0] <> '' Then
      FrmPerguntaBotoesConf.Button1.Caption := Botoes[0];

    If Botoes[1] <> '' Then
      FrmPerguntaBotoesConf.Button2.Caption := Botoes[1];

    if Length(Botoes) >= 3 then
      If Botoes[2] <> '' Then
        FrmPerguntaBotoesConf.Button3.Caption := Botoes[2];

    FrmPerguntaBotoesConf.ShowModal;
  Finally
    case FrmPerguntaBotoesConf.ModalResult of
      mrYes:
        result := 1;
      mrNo:
        result := 2;
      mrCancel:
        result := 3;
    end;
    FreeAndNil(FrmPerguntaBotoesConf);
  End;
end;

(* Funcoes que simula um Alerta Estilo MSN - Retorno True se Botao for utilizado *)
{ class function TFuncoes.SolicitaSenhaUsuario(formulario: string;
  var CodigoUsuarioAutorizou: Integer): TAcesso;
  var
  usuarios: TUsuario;
  begin
  CodigoUsuarioAutorizou := 0;
  frmSolicitaSenhaUsuario := TfrmSolicitaSenhaUsuario.Create(nil);
  usuarios := TUsuario.Create;
  try
  if frmSolicitaSenhaUsuario.ShowModal = mrOK then
  begin
  if (usuarios.Consultar(frmSolicitaSenhaUsuario.edtUsuario.Text)) and
  (usuarios.SenhaValida(frmSolicitaSenhaUsuario.edtSenha.Text)) then
  begin
  Result := TNivelDeAcesso.PermissoesForm(usuarios.CodigoNivelAcesso,
  formulario);
  CodigoUsuarioAutorizou := usuarios.CodigoUsuario;
  end
  else
  begin
  CodigoUsuarioAutorizou := 0;
  Self.Mensagem('Usuário não encontrado!', mtError);
  end;
  end;
  finally
  FreeAndNil(usuarios);
  FreeAndNil(frmSolicitaSenhaUsuario);
  end;
  end;
}
// ; NomeFormulario:string; var PermissaoUsuario:TAcesso
class procedure TFuncoes.SimulaAltSetaCima;
begin
  keybd_event(VK_MENU, 0, 0, 0);
  keybd_event(VK_UP, 0, 0, 0);
  keybd_event(VK_UP, 0, KEYEVENTF_KEYUP, 0);
  keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0);
end;

class procedure TFuncoes.SimulaShiftTab;

begin
  keybd_event(VK_SHIFT, 0, 0, 0); // preciona o Shift
  keybd_event(VK_TAB, 0, 0, 0); // Preciona o TAB
  keybd_event(VK_TAB, 0, KEYEVENTF_KEYUP, 0); // Solta o F4
  keybd_event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0); // Solta o ALT

end;

// ; NomeFormulario:string; var PermissaoUsuario:TAcesso
class procedure TFuncoes.SimulaAltF4;
begin
  keybd_event(VK_MENU, 0, 0, 0); // preciona o ALT
  keybd_event(VK_F4, 0, 0, 0); // Preciona o F4
  keybd_event(VK_F4, 0, KEYEVENTF_KEYUP, 0); // Solta o F4
  keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0); // Solta o ALT
end;

// ; NomeFormulario:string; var PermissaoUsuario:TAcesso
class procedure TFuncoes.SimulaTecla(tecla: byte);
begin
  keybd_event(tecla, 0, 0, 0);
end;

class procedure TFuncoes.SimulaTexto(texto: String);
Var
  I: integer;
begin
  for I := 0 to texto.Length do
    SimulaTecla(ord(texto[I]));

end;

{ class Function TFuncoes.SolicitaPermissaoRemota(UsuarioSolicitou, Solicitacao,
  NomeFormulario: string; TipoSolicitacao: Integer;
  var UsuarioAutorizou: Integer; NumeroSolicitacao: Integer): boolean;
  var
  PermissoesUsuarioAutorizou: TAcesso;
  begin
  UsuarioAutorizou := 0;

  Result := AlertaMSN('Solicitação de Permissão',
  'Usuário: ' + #13 + UsuarioSolicitou + #13#13 + 'Hora: ' + #13 +
  TimeToStr(time) + #13#13 + 'Descrição da Solicitação: ' + #13 + Solicitacao,
  'Autorizar (Enter)', 'Negar (Esc)', NumeroSolicitacao);
  if Result then
  begin
  PermissoesUsuarioAutorizou := TFuncoes.SolicitaSenhaUsuario(NomeFormulario,
  UsuarioAutorizou);
  Result := (PermissoesUsuarioAutorizou.Autorizar) and (UsuarioAutorizou > 0);
  if Result then
  begin
  case TipoSolicitacao of
  1:
  Result := PermissoesUsuarioAutorizou.Inclui;
  2:
  Result := PermissoesUsuarioAutorizou.Exclui;
  3:
  Result := PermissoesUsuarioAutorizou.Altera;
  4:
  Result := PermissoesUsuarioAutorizou.Relatorio;
  5:
  Result := PermissoesUsuarioAutorizou.Cancelar;
  6:
  Result := PermissoesUsuarioAutorizou.Liberar;
  7:
  Result := PermissoesUsuarioAutorizou.Autorizar;
  8:
  Result := PermissoesUsuarioAutorizou.GerarRel;
  end;
  end;
  End;
  end; }

(* Adiciona ao Menu os Relatorio Pré-Existentes para a Tela *)
class procedure TFuncoes.Menu_AddRel(PrintMenu: TPopupMenu;
  ItemComando: TMenuItem);
var
  NewItem: TMenuItem;
  I: Word;
  SqlTemp: TSQLDataSet;
begin
  SqlTemp := TSQLDataSet.Create(nil);
  SqlTemp.SQLConnection := ConexaoBanco.Conexao;
  try
    Screen.cursor := crHourGlass;
    try
      SqlTemp.Close;
      SqlTemp.CommandText :=
        'SELECT * FROM relatoriosadm WHERE menuitem = :menuitem';
      // and idfilial = :filial
      SqlTemp.ParamByName('menuItem').Value := (PrintMenu.Owner as TForm).Name;
      SqlTemp.Open;
    finally
      Screen.cursor := crDefault;
    end;

    if not SqlTemp.IsEmpty then
    begin
      NewItem := TMenuItem.Create(nil);
      NewItem.Caption := '-';
      PrintMenu.Items.Add(NewItem);

      NewItem := TMenuItem.Create(nil);
      NewItem.Caption := '* * * OUTROS RELATÓRIOS * * *';
      PrintMenu.Items.Add(NewItem);

      NewItem := TMenuItem.Create(nil);
      NewItem.Caption := '-';
      PrintMenu.Items.Add(NewItem);

      I := 1;
      SqlTemp.First;
      while not SqlTemp.Eof do
      begin
        NewItem := TMenuItem.Create(nil);
        NewItem.Caption := IntToStr(I) + '. ' + SqlTemp.FieldByName
          ('TITULO').Value;
        NewItem.Hint := SqlTemp.FieldByName('NOMEARQUIVO').Value;

        // Evento OnClick do Item
        NewItem.OnClick := ItemComando.OnClick;

        if PrintMenu.Items.Find(NewItem.Caption) = nil then
          PrintMenu.Items.Add(NewItem);

        SqlTemp.Next;
        Inc(I);
      end;
    end;
  finally
    FreeAndNil(SqlTemp);
  end;
end;

(* Enviar Email *)
class function TFuncoes.EnviarEmail(De, Para, Titulo, Corpo, Arquivo: String;
  usuario: string; senha: string; servidor_smtp: string;
  porta: integer): Boolean;
var
  IdSMTP1: TIdSMTP;
  IdMessage1: TIdMessage;
begin
  try
    IdSMTP1 := TIdSMTP.Create(nil);
    IdMessage1 := TIdMessage.Create(nil);

    try
      IdMessage1.Clear;
      IdMessage1.From.Text := De;
      IdMessage1.ReplyTo.EMailAddresses := De;
      IdMessage1.Recipients.EMailAddresses := Para;
      IdMessage1.date := Now;
      IdMessage1.Subject := Titulo;
      IdMessage1.Priority := mpNormal;

      if (Arquivo <> '') then
      begin
        TIdAttachmentFile.Create(IdMessage1.MessageParts, Arquivo);
      end;

      IdMessage1.Body.Add(Corpo);
      IdSMTP1.AuthType := satDefault;
      // se nao tiver autenticacao
      // else IdSMTP1.AuthType:= satNone;

      IdSMTP1.Host := servidor_smtp;
      IdSMTP1.Port := porta;
      IdSMTP1.UserName := usuario;
      IdSMTP1.Password := senha;
      IdSMTP1.Connect;
      result := true;
      try
        try
          IdSMTP1.Send(IdMessage1);
        except
          on E: Exception do
          begin
            TFuncoes.Mensagem
              ('Falha ao enviar o email, tente novamente mais tarde.',
              mtWarning);
            result := false;
          end;
        end;
      finally
        IdSMTP1.Disconnect;
      end;
    except
      on E: Exception do
      begin
        TFuncoes.Mensagem
          ('Falha ao enviar o email verifique a configuração do servidor de e-mail.',
          mtWarning);
        result := false;
      end;
    end
  finally
    FreeAndNil(IdSMTP1);
    FreeAndNil(IdMessage1);
  end;
end;

class function TFuncoes.MesAtual: Word;
begin
  result := MonthOf(date);
end;

class function TFuncoes.MontaData(dia, mes, ano: Word): TDatetime;
begin
  try
    result := EncodeDate(ano, mes, 1) + dia - 1;
  except
    on E: Exception do
    Begin
      TFuncoes.Mensagem(E.Message);
      result := date;
    end;
  end;
end;

(* retorna o ultimo dia do mes da data informa / para mes e ano *)
class function TFuncoes.UltimoDiaMes(Data: TDatetime): TDatetime;
begin
  result := endOfTheMonth(date);
end;

(* retorna o ultimo dia do mes da data informa / para mes e ano *)
class function TFuncoes.UltimoDiaMes(mes, ano: Word): TDatetime;
begin
  result := endOfAMonth(ano, mes);
end;

class procedure TFuncoes.ValidaCampoNumerico(Edit: TRzDBEdit; Tamanho: integer);
var
  codigo: string;
begin
  codigo := TFuncoes.TiraSimbolos(Trim(Edit.Text));
  if Length(codigo) > Tamanho then
  begin
    Edit.Text := Copy(Edit.Text, 0, (Length(Edit.Text) - 1));
    Edit.SelStart := Length(Edit.Text);
  end;
end;

class function TFuncoes.ValidaCNPJ(numCNPJ: string): Boolean;
var
  cnpj: string;
  dg1, dg2: integer;
  X, total: integer;
  ret: Boolean;
begin
  ret := false;
  cnpj := '';
  // Analisa os formatos
  if Length(numCNPJ) = 18 then
    if (Copy(numCNPJ, 3, 1) + Copy(numCNPJ, 7, 1) + Copy(numCNPJ, 11, 1) +
      Copy(numCNPJ, 16, 1) = '../-') then
    begin
      cnpj := Copy(numCNPJ, 1, 2) + Copy(numCNPJ, 4, 3) + Copy(numCNPJ, 8, 3) +
        Copy(numCNPJ, 12, 4) + Copy(numCNPJ, 17, 2);
      ret := true;
    end;
  if Length(numCNPJ) = 14 then
  begin
    cnpj := numCNPJ;
    ret := true;
  end;
  // Verifica
  if ret then
  begin
    try
      // 1° digito
      total := 0;
      for X := 1 to 12 do
      begin
        if X < 5 then
        begin
          Inc(total, StrToInt(Copy(cnpj, X, 1)) * (6 - X))
        end
        else
        begin
          Inc(total, StrToInt(Copy(cnpj, X, 1)) * (14 - X));
        end;
      end;
      dg1 := 11 - (total mod 11);
      if dg1 > 9 then
      begin
        dg1 := 0;
      end;
      // 2° digito
      total := 0;
      for X := 1 to 13 do
      begin
        if X < 6 then
          Inc(total, StrToInt(Copy(cnpj, X, 1)) * (7 - X))
        else
          Inc(total, StrToInt(Copy(cnpj, X, 1)) * (15 - X));
      end;
      dg2 := 11 - (total mod 11);
      if dg2 > 9 then
        dg2 := 0;
      // Validação final
      if (dg1 = StrToInt(Copy(cnpj, 13, 1))) and
        (dg2 = StrToInt(Copy(cnpj, 14, 1))) then
      begin
        ret := true
      end
      else
      begin
        ret := false;
      end;
    except
      ret := false;
    end;
    // Inválidos
    case AnsiIndexStr(cnpj, ['00000000000000', '11111111111111',
      '22222222222222', '33333333333333', '44444444444444',

      '55555555555555', '66666666666666', '77777777777777', '88888888888888',
      '99999999999999']) of

      0 .. 9:
        ret := false;

    end;
  end;
  ValidaCNPJ := ret;
end;

class function TFuncoes.ValidaCPF(cpf: string): Boolean;
var
  I: integer;
  Want: char;
  Wvalid: Boolean;
  Wdigit1, Wdigit2: integer;
begin
  try
    Wdigit1 := 0;
    Wdigit2 := 0;
    Want := cpf[1];
    // variavel para testar se o cpf é repetido como 111.111.111-11
    Wvalid := false;
    Delete(cpf, ansipos('.', cpf), 1); // retira as mascaras se houver
    Delete(cpf, ansipos('.', cpf), 1);
    Delete(cpf, ansipos('-', cpf), 1);
    Delete(cpf, ansipos(' ', cpf), 1);

    if Length(cpf) < 11 then
    begin
      result := false;
      Exit;
    end;

    // testar se o cpf é repetido como 111.111.111-11
    for I := 1 to Length(cpf) do
    begin
      if cpf[I] <> Want then
      begin
        Wvalid := true;
        // se o cpf possui um digito diferente ele passou no primeiro teste
        Break
      end;
    end;
    // se o cpf é composto por numeros repetido retorna falso
    if not Wvalid then
    begin
      result := false;
      Exit;
    end;

    // executa o calculo para o primeiro verificador
    for I := 1 to 9 do
    begin
      Wdigit1 := Wdigit1 + (StrToInt(cpf[10 - I]) * (I + 1));
    end;
    Wdigit1 := ((11 - (Wdigit1 mod 11)) mod 11) mod 10;
    { formula do primeiro verificador
      soma=1°*2+2°*3+3°*4.. até 9°*10
      digito1 = 11 - soma mod 11
      se digito > 10 digito1 =0
    }

    // verifica se o 1° digito confere
    if IntToStr(Wdigit1) <> cpf[10] then
    begin
      result := false;
      Exit;
    end;

    for I := 1 to 10 do
    begin
      Wdigit2 := Wdigit2 + (StrToInt(cpf[11 - I]) * (I + 1));
    end;
    Wdigit2 := ((11 - (Wdigit2 mod 11)) mod 11) mod 10;
    { formula do segundo verificador
      soma=1°*2+2°*3+3°*4.. até 10°*11
      digito1 = 11 - soma mod 11
      se digito > 10 digito1 =0
    }

    // confere o 2° digito verificador
    if IntToStr(Wdigit2) <> cpf[11] then
    begin
      result := false;
      Exit;
    end;

  except
    on E: Exception do
      result := false;
  end;

  // se chegar até aqui o cpf é valido
  result := true;
end;

class function TFuncoes.ValidaId(id: string): Boolean;
var
  I: integer;
  R: Boolean;
begin
  R := true;
  for I := 0 to Length(id) do
  begin
    if Pos(Copy(id, I, 1), '0123456789,') = 0 then
    begin

      R := false;
    end;

  end;
  result := R;
end;

class function TFuncoes.ValidaIE(Inscricao, Tipo: String): Boolean;
Var
  Contador: ShortInt;
  Casos: ShortInt;
  Digitos: ShortInt;

  Tabela_1: String;
  Tabela_2: String;
  Tabela_3: String;

  Base_1: String;
  Base_2: String;
  Base_3: String;

  Valor_1: ShortInt;

  Soma_1: integer;
  Soma_2: integer;

  Erro_1: ShortInt;
  Erro_2: ShortInt;
  Erro_3: ShortInt;

  Posicao_1: string;
  Posicao_2: String;

  Tabela: String;
  Rotina: String;
  Modulo: ShortInt;
  Peso: String;

  Digito: ShortInt;

  resultado: String;
  retorno: Boolean;

Begin
  Try
    Tabela_1 := ' ';
    Tabela_2 := ' ';
    Tabela_3 := ' ';

    { }                                                                                                                 { }
    { Valores possiveis para os digitos (j) }
    { }
    { 0 a 9 = Somente o digito indicado. }
    { N = Numeros 0 1 2 3 4 5 6 7 8 ou 9 }
    { A = Numeros 1 2 3 4 5 6 7 8 ou 9 }
    { B = Numeros 0 3 5 7 ou 8 }
    { C = Numeros 4 ou 7 }
    { D = Numeros 3 ou 4 }
    { E = Numeros 0 ou 8 }
    { F = Numeros 0 1 ou 5 }
    { G = Numeros 1 7 8 ou 9 }
    { H = Numeros 0 1 2 ou 3 }
    { I = Numeros 0 1 2 3 ou 4 }
    { J = Numeros 0 ou 9 }
    { K = Numeros 1 2 3 ou 9 }
    { }
    { -------------------------------------------------------- }
    { }
    { Valores possiveis para as rotinas (d) e (g) }
    { }
    { A a E = Somente a Letra indicada. }
    { 0 = B e D }
    { 1 = C e E }
    { 2 = A e E }
    { }
    { -------------------------------------------------------- }
    { }
    { C T  F R M  P  R M  P }
    { A A  A O O  E  O O  E }
    { S M  T T D  S  T D  S }
    { }
    { a b  c d e  f  g h  i  jjjjjjjjjjjjjj }
    { 0000000001111111111222222222233333333 }
    { 1234567890123456789012345678901234567 }

    IF Tipo = 'AC' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     01NNNNNNX.14.00';
    IF Tipo = 'AC' Then
      Tabela_2 := '2.13.0.E.11.02.E.11.01. 01NNNNNNNNNXY.13.14';
    IF Tipo = 'AL' Then
      Tabela_1 := '1.09.0.0.11.01. .  .  .     24BNNNNNX.14.00';
    IF Tipo = 'AP' Then
      Tabela_1 := '1.09.0.1.11.01. .  .  .     03NNNNNNX.14.00';
    IF Tipo = 'AP' Then
      Tabela_2 := '2.09.1.1.11.01. .  .  .     03NNNNNNX.14.00';
    IF Tipo = 'AP' Then
      Tabela_3 := '3.09.0.E.11.01. .  .  .     03NNNNNNX.14.00';
    IF Tipo = 'AM' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     0CNNNNNNX.14.00';
    IF Tipo = 'BA' Then
      Tabela_1 := '1.08.0.E.10.02.E.10.03.      NNNNNNYX.14.13';
    IF Tipo = 'BA' Then
      Tabela_2 := '2.08.0.E.11.02.E.11.03.      NNNNNNYX.14.13';
    IF Tipo = 'CE' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     0NNNNNNNX.14.13';
    IF Tipo = 'DF' Then
      Tabela_1 := '1.13.0.E.11.02.E.11.01. 07DNNNNNNNNXY.13.14';
    IF Tipo = 'ES' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     0ENNNNNNX.14.00';
    IF Tipo = 'GO' Then
      Tabela_1 := '1.09.1.E.11.01. .  .  .     1FNNNNNNX.14.00';
    IF Tipo = 'GO' Then
      Tabela_2 := '2.09.0.E.11.01. .  .  .     1FNNNNNNX.14.00';
    IF Tipo = 'MA' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     12NNNNNNX.14.00';
    IF Tipo = 'MT' Then
      Tabela_1 := '1.11.0.E.11.01. .  .  .   NNNNNNNNNNX.14.00';
    IF Tipo = 'MS' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     28NNNNNNX.14.00';
    IF Tipo = 'MG' Then
      Tabela_1 := '1.13.0.2.10.10.E.11.11. NNNNNNNNNNNXY.13.14';
    IF Tipo = 'PA' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     15NNNNNNX.14.00';
    IF Tipo = 'PB' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     16NNNNNNX.14.00';
    IF Tipo = 'PR' Then
      Tabela_1 := '1.10.0.E.11.09.E.11.08.    NNNNNNNNXY.13.14';
    IF Tipo = 'PE' Then
      Tabela_1 := '1.14.1.E.11.07. .  .  .18ANNNNNNNNNNX.14.00';
    IF Tipo = 'PI' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     19NNNNNNX.14.00';
    IF Tipo = 'RJ' Then
      Tabela_1 := '1.08.0.E.11.08. .  .  .      GNNNNNNX.14.00';
    IF Tipo = 'RN' Then
      Tabela_1 := '1.09.0.0.11.01. .  .  .     20HNNNNNX.14.00';
    IF Tipo = 'RS' Then
      Tabela_1 := '1.10.0.E.11.01. .  .  .    INNNNNNNNX.14.00';
    IF Tipo = 'RO' Then
      Tabela_1 := '1.09.1.E.11.04. .  .  .     ANNNNNNNX.14.00';
    IF Tipo = 'RO' Then
      Tabela_2 := '2.14.0.E.11.01. .  .  .NNNNNNNNNNNNNX.14.00';
    IF Tipo = 'RR' Then
      Tabela_1 := '1.09.0.D.09.05. .  .  .     24NNNNNNX.14.00';
    IF Tipo = 'SC' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     NNNNNNNNX.14.00';
    IF Tipo = 'SP' Then
      Tabela_1 := '1.12.0.D.11.12.D.11.13.  NNNNNNNNXNNY.11.14';
    IF Tipo = 'SP' Then
      Tabela_2 := '2.12.0.D.11.12. .  .  .  NNNNNNNNXNNN.11.00';
    IF Tipo = 'SE' Then
      Tabela_1 := '1.09.0.E.11.01. .  .  .     NNNNNNNNX.14.00';
    IF Tipo = 'TO' Then
      Tabela_1 := '1.11.0.E.11.06. .  .  .   29JKNNNNNNX.14.00';

    IF Tipo = 'CNPJ' Then
      Tabela_1 := '1.14.0.E.11.21.E.11.22.NNNNNNNNNNNNXY.13.14';
    IF Tipo = 'CPF' Then
      Tabela_1 := '1.11.0.E.11.31.E.11.32.   NNNNNNNNNXY.13.14';

    { Deixa somente os numeros }

    Base_1 := '';

    For Contador := 1 TO 30 Do
      IF Pos(Copy(Inscricao, Contador, 1), '0123456789') <> 0 Then
        Base_1 := Base_1 + Copy(Inscricao, Contador, 1);

    { Repete 3x - 1 para cada caso possivel }

    Casos := 0;

    Erro_1 := 0;
    Erro_2 := 0;
    Erro_3 := 0;

    While Casos < 3 Do
    Begin

      Casos := Casos + 1;

      IF Casos = 1 Then
        Tabela := Tabela_1;
      IF Casos = 2 Then
        Erro_1 := Erro_3;
      IF Casos = 2 Then
        Tabela := Tabela_2;
      IF Casos = 3 Then
        Erro_2 := Erro_3;
      IF Casos = 3 Then
        Tabela := Tabela_3;

      Erro_3 := 0;

      IF Copy(Tabela, 1, 1) <> ' ' Then
      Begin

        { Verifica o Tamanho }

        IF Length(Trim(Base_1)) <> (StrToInt(Copy(Tabela, 3, 2))) Then
          Erro_3 := 1;

        IF Erro_3 = 0 Then
        Begin

          { Ajusta o Tamanho }

          Base_2 := Copy('              ' + Base_1,
            Length('              ' + Base_1) - 13, 14);

          { Compara com valores possivel para cada uma da 14 posições }

          Contador := 0;

          While (Contador < 14) AND (Erro_3 = 0) Do
          Begin

            Contador := Contador + 1;

            Posicao_1 := Copy(Copy(Tabela, 24, 14), Contador, 1);
            Posicao_2 := Copy(Base_2, Contador, 1);

            IF (Posicao_1 = ' ') AND (Posicao_2 <> ' ') Then
              Erro_3 := 1;
            IF (Posicao_1 = 'N') AND (Pos(Posicao_2, '0123456789') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'A') AND (Pos(Posicao_2, '123456789') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'B') AND (Pos(Posicao_2, '03578') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'C') AND (Pos(Posicao_2, '47') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'D') AND (Pos(Posicao_2, '34') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'E') AND (Pos(Posicao_2, '08') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'F') AND (Pos(Posicao_2, '015') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'G') AND (Pos(Posicao_2, '1789') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'H') AND (Pos(Posicao_2, '0123') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'I') AND (Pos(Posicao_2, '01234') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'J') AND (Pos(Posicao_2, '09') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 = 'K') AND (Pos(Posicao_2, '1239') = 0) Then
              Erro_3 := 1;
            IF (Posicao_1 <> Posicao_2) AND
              (Pos(Posicao_1, '0123456789') > 0) Then
              Erro_3 := 1;

          End;

          { Calcula os Digitos }

          Rotina := ' ';
          Digitos := 000;
          Digito := 000;

          While (Digitos < 2) AND (Erro_3 = 0) Do
          Begin

            Digitos := Digitos + 1;

            { Carrega peso }

            Peso := Copy(Tabela, 5 + (Digitos * 8), 2);

            IF Peso <> '  ' Then
            Begin

              Rotina := Copy(Tabela, 0 + (Digitos * 8), 1);
              Modulo := StrToInt(Copy(Tabela, 2 + (Digitos * 8), 2));

              IF Peso = '01' Then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
              IF Peso = '02' Then
                Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
              IF Peso = '03' Then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.00.02';
              IF Peso = '04' Then
                Peso := '00.00.00.00.00.00.00.00.06.05.04.03.02.00';
              IF Peso = '05' Then
                Peso := '00.00.00.00.00.01.02.03.04.05.06.07.08.00';
              IF Peso = '06' Then
                Peso := '00.00.00.09.08.00.00.07.06.05.04.03.02.00';
              IF Peso = '07' Then
                Peso := '05.04.03.02.01.09.08.07.06.05.04.03.02.00';
              IF Peso = '08' Then
                Peso := '08.07.06.05.04.03.02.07.06.05.04.03.02.00';
              IF Peso = '09' Then
                Peso := '07.06.05.04.03.02.07.06.05.04.03.02.00.00';
              IF Peso = '10' Then
                Peso := '00.01.02.01.01.02.01.02.01.02.01.02.00.00';
              IF Peso = '11' Then
                Peso := '00.03.02.11.10.09.08.07.06.05.04.03.02.00';
              IF Peso = '12' Then
                Peso := '00.00.01.03.04.05.06.07.08.10.00.00.00.00';
              IF Peso = '13' Then
                Peso := '00.00.03.02.10.09.08.07.06.05.04.03.02.00';
              IF Peso = '21' Then
                Peso := '05.04.03.02.09.08.07.06.05.04.03.02.00.00';
              IF Peso = '22' Then
                Peso := '06.05.04.03.02.09.08.07.06.05.04.03.02.00';
              IF Peso = '31' Then
                Peso := '00.00.00.10.09.08.07.06.05.04.03.02.00.00';
              IF Peso = '32' Then
                Peso := '00.00.00.11.10.09.08.07.06.05.04.03.02.00';

              { Multiplica }

              Base_3 := Copy(('0000000000000000' + Trim(Base_2)),
                Length(('0000000000000000' + Trim(Base_2))) - 13, 14);

              Soma_1 := 0;
              Soma_2 := 0;

              For Contador := 1 To 14 Do
              Begin

                Valor_1 := (StrToInt(Copy(Base_3, Contador, 01)) *
                  StrToInt(Copy(Peso, Contador * 3 - 2, 2)));

                Soma_1 := Soma_1 + Valor_1;

                IF Valor_1 > 9 Then
                  Valor_1 := Valor_1 - 9;

                Soma_2 := Soma_2 + Valor_1;

              End;

              { Ajusta valor da soma }

              IF Pos(Rotina, 'A2') > 0 Then
                Soma_1 := Soma_2;
              IF Pos(Rotina, 'B0') > 0 Then
                Soma_1 := Soma_1 * 10;
              IF Pos(Rotina, 'C1') > 0 Then
                Soma_1 := Soma_1 + (5 + 4 * StrToInt(Copy(Tabela, 6, 1)));

              { Calcula o Digito }

              IF Pos(Rotina, 'D0') > 0 Then
                Digito := Soma_1 Mod Modulo;
              IF Pos(Rotina, 'E12') > 0 Then
                Digito := Modulo - (Soma_1 Mod Modulo);

              IF Digito < 10 Then
                resultado := IntToStr(Digito);
              IF Digito = 10 Then
                resultado := '0';
              IF Digito = 11 Then
                resultado := Copy(Tabela, 6, 1);

              { Verifica o Digito }

              IF (Copy(Base_2, StrToInt(Copy(Tabela, 36 + (Digitos * 3), 2)), 1)
                <> resultado) Then
                Erro_3 := 1;
            End;
          End;
        End;
      End;
    End;

    { Retorna o resultado da Verificação }

    retorno := false;

    IF (Trim(Tabela_1) <> '') AND (Erro_1 = 0) Then
      retorno := true;
    IF (Trim(Tabela_2) <> '') AND (Erro_2 = 0) Then
      retorno := true;
    IF (Trim(Tabela_3) <> '') AND (Erro_3 = 0) Then
      retorno := true;

    IF Trim(Inscricao) = 'ISENTO' Then
      retorno := true;
    result := retorno;
  Except
    result := false;
  End;
End;

// Valida um field para percentual de validacao (menor que cem e maior que zero)
class procedure TFuncoes.ValidaFieldPercentual(Sender: TField; Text: string;
  pPermiteMaior100: Boolean = false);
var
  valor: string;

begin
  valor := StringReplace(Trim(Text), ' ', '', [rfReplaceAll]);
  valor := StringReplace(Trim(valor), '.', '', [rfReplaceAll]);
  while Pos('--', valor) > 0 do
  begin
    valor := StringReplace(Trim(valor), '--', '-', [rfReplaceAll]);
  end;

  if valor <> '' then
  begin
    if valor[Length(valor)] = ',' then
    begin
      valor := StringReplace(valor, ',', '', [rfReplaceAll]);
    end;
    if valor = '' then
    begin
      valor := '0';
    end;
  end
  else
  begin
    valor := '0';
    Sender.AsString := valor;
  end;
  try
    Sender.AsString := valor;
  except
    on E: Exception do
    begin
      TFuncoes.Mensagem('Número inválido para o campo ' +
        QuotedStr(Sender.DisplayLabel), mtWarning);
      Sender.AsString := '0';
      abort;
    end;
  end;
  if ((Sender.AsFloat >= 100.0) and (not pPermiteMaior100)) or
    (Sender.AsFloat < 0) then
  begin
    if not pPermiteMaior100 then
    begin
      TFuncoes.Mensagem
        ('Não é permitido valor negativo ou maior igual a 100.0% para o campo '
        + QuotedStr(Sender.DisplayLabel), mtWarning);
    end
    else
      TFuncoes.Mensagem('Não é permitido valor negativo para o campo ' +
        QuotedStr(Sender.DisplayLabel), mtWarning);
    Sender.AsString := '0';
    abort;
  end;
end;

// Valida um field para valor (maior que zero)
class procedure TFuncoes.ValidaFieldValor(Sender: TField; Text: string;
  PermiteNegativo: Boolean = false);
var
  valor: string;

begin
  valor := StringReplace(Trim(Text), ' ', '', [rfReplaceAll]);
  valor := StringReplace(Trim(valor), '.', '', [rfReplaceAll]);
  while Pos('--', valor) > 0 do
  begin
    valor := StringReplace(Trim(valor), '--', '-', [rfReplaceAll]);
  end;

  if valor <> '' then
  begin
    if valor[Length(valor)] = ',' then
    begin
      valor := StringReplace(valor, ',', '', [rfReplaceAll]);
    end;
    if valor = '' then
    begin
      valor := '0';
    end;
  end
  else
  begin
    valor := '0';
    Sender.AsString := valor;
  end;
  try
    Sender.AsString := valor;
  except
    on E: Exception do
    begin
      TFuncoes.Mensagem('Número inválido para o campo ' +
        QuotedStr(Sender.DisplayLabel), mtWarning);
      Sender.AsString := '0';
      abort;
    end;
  end;
  if (Sender.AsFloat < 0) and (not PermiteNegativo) then
  begin
    TFuncoes.Mensagem('Não é permitido valor negativo para o campo ' +
      QuotedStr(Sender.DisplayLabel), mtWarning);
    Sender.AsString := '0';
    abort;
  end;
end;

class function TFuncoes.ValidaPost(dataset: TDataSet): Boolean;
var
  I: integer;
  DisplayLabel, textoCampo: string;
begin
  result := true;
  for I := 0 to dataset.FieldCount - 1 do
  begin
    if dataset.Fields[I].Required then
    begin
      textoCampo := TiraSimbolos(Trim(dataset.Fields[I].Text));
      if (dataset.Fields[I].IsNull) or (textoCampo = '') then
      begin
        if Pos('<', dataset.Fields[I].DisplayLabel) > 0 then
        begin
          DisplayLabel := Copy(dataset.Fields[I].DisplayLabel, 1,
            (Pos('<', dataset.Fields[I].DisplayLabel) - 1));
        end
        else
        begin
          DisplayLabel := dataset.Fields[I].DisplayLabel;
        end;
        TFuncoes.Mensagem('O campo ' + QuotedStr(DisplayLabel) +
          ' é obrigatório.', mtInformation);
        result := false;
        dataset.Fields[I].FocusControl;
        Break;
      end;
    end;
  end;
end;

// verifica se a mascara se o texto contem somente caracteres (9 , .)
class function TFuncoes.VerificaMascara(texto: string): Boolean;
var
  I: integer;
  aux: char;
  valido: Boolean;
begin
  valido := true;

  for I := 1 to Length(texto) do
  begin
    aux := texto[I];
    if ((aux <> '9') and (aux <> '.')) then
    begin
      valido := false;
    end;
  end;

  result := valido;
end;

class function TFuncoes.PrimeiroDiaMes(Data: TDatetime): TDatetime;
begin
  result := StartOfTheMonth(Data);
end;

class function TFuncoes.PrimeiroDiaMes(mes, ano: Word): TDatetime;
begin
  result := StartOfAMonth(ano, mes);
end;

class function TFuncoes.RetornaFieldNameRequerido(dataset: TDataSet): string;
var
  I: integer;
  FieldName: string;
begin
  result := '';
  for I := 0 to dataset.FieldCount - 1 do
  begin
    if dataset.Fields[I].Required then
    begin
      if (dataset.Fields[I].IsNull) or (Trim(dataset.Fields[I].AsString) = '')
      then
      begin
        result := dataset.Fields[I].FieldName;
        Break;
      end;
    end;
  end;
end;

class function TFuncoes.sem_acento(texto: string;
  ConvertePraMaiusculas: Boolean = true): string;
const
  acentos = 'áàâãäéèêëíìïóòôõöúùûüÁÀÂÃÄÉÈÊËÍÌÏÓÒÔÕÖÚÙÛÜçÇ';
  equivalentes = 'aaaaaeeeeiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcC';
var
  auxiliar, posicao: integer;
  retorno: string;
begin
  retorno := texto;
  for auxiliar := 1 to Length(texto) do
  begin
    posicao := Pos(texto[auxiliar], acentos);
    if posicao > 0 then
    begin
      retorno[auxiliar] := equivalentes[posicao]
    end;
  end;
  if ConvertePraMaiusculas then
  begin
    retorno := UpperCase(retorno);
  end;
  result := retorno;
end;

(* retorna a string passada no paramentro sem os caracteres da constante *)
class function TFuncoes.TiraSimbolos(texto: string; Adic: string = ''): string;
var
  I: integer;
  sTemp, sRetorno: string;
Const
  Lixo = ' ,.:;/|()-';
begin
  for I := 1 to Length(texto) do
  begin
    sTemp := texto[I];
    if Pos(sTemp, Lixo + Adic) = 0 then
      sRetorno := sRetorno + sTemp;
  end;
  result := sRetorno;
end;

(* retorna a string passada no paramentro sem os caracteres alfabeticos *)
class function TFuncoes.ExtraiNumeros(texto: string; Numeros: String): string;
var
  I: integer;
  sTemp, sRetorno: string;
begin
  for I := 1 to Length(texto) do
  begin
    sTemp := texto[I];
    if Pos(sTemp, Numeros) > 0 then
      sRetorno := sRetorno + sTemp;
  end;
  result := sRetorno;
end;

(* Cria e abre um formulário de um pacote dinamicamene *)
class procedure TFuncoes.AbreFormPacote(NomeBPL: string);
var
  sPacote: String;
  hPacote: THandle;
  aClass: TPersistentClass;
  frmTela: TCustomForm;
begin
  sPacote := ExtractFilePath(ParamStr(0)) + NomeBPL + '.bpl';
  if not FileExists(sPacote) then
  begin
    raise Exception.Create('Pacote não encontrado!');
  end;

  hPacote := LoadPackage(sPacote);
  if hPacote <> 0 then
  begin
    aClass := GetClass(GetPackageDescription(pChar(sPacote)));
    frmTela := (TComponentClass(aClass).Create(Application) as TCustomForm);

    (* adicionado depois *)
    try
      frmTela.ShowModal;
    finally
      frmTela.Free;
      UnloadPackage(hPacote)
    end;
  end
  else
  begin
    raise Exception.Create('Ocorreu um erro ao carregar o pacote: ' + sPacote);
  end;
end;

class procedure TFuncoes.AdicionaDetalhe(cdsMestre, cdsDetalhe: TClientDataSet;
  FieldFoco: TField; GridFoco: TxDBGridZebrado);
begin
  if cdsDetalhe.State in [dsedit, dsInsert] then
  begin
    TFuncoes.GravaDetalhe(cdsMestre, cdsDetalhe, GridFoco);
    if cdsDetalhe.State = dsBrowse then
    begin
      cdsDetalhe.Append;
      FieldFoco.FocusControl;
    end;
  end
  else
  begin
    try
      cdsDetalhe.Append;
      cdsDetalhe.Cancel;
      cdsDetalhe.Append;
      FieldFoco.FocusControl;
    except
      on E: Exception do
      begin
        // ShowMessage(E.Message);
      end;
    end;
  end;
end;

class procedure TFuncoes.DesfazDetalhe(cdsDetalhe: TClientDataSet;
  GridFoco: TxDBGridZebrado);
begin
  if cdsDetalhe.State in [dsInsert, dsedit] then
  begin
    cdsDetalhe.Cancel;
    GridFoco.SetFocus;
  end;
end;

class procedure TFuncoes.GravaDetalhe(cdsMestre, cdsDetalhe: TClientDataSet;
  GridFoco: TxDBGridZebrado);
begin
  try
    cdsDetalhe.Post;
    cdsMestre.Edit;
    if GridFoco <> nil then
    begin
      if GridFoco.CanFocus then
      begin
        GridFoco.SetFocus;
      end;
    end;
  except
    On E: Exception do
    begin
      // TFuncoes.Mensagem('O seguinte erro ocorreu ao gravar!' + #13 + E.Message, mtInformation);
    end;
  end;
end;

(* Criacao Dinamica *)
class procedure TFuncoes.AbreForm(aForm: TComponentClass; menuTag: integer);
var
  FormTemp: TForm;
begin
  Screen.cursor := crHourGlass;
  Application.CreateForm(aForm, FormTemp);
  try
    FormTemp.Tag := menuTag;
    FormTemp.ShowModal;
  finally
    Screen.cursor := crDefault;
    FormTemp.Free;
  end;
end;

(* Cria a Chama um formulario sem a necessidade de referenciar o Formulario
  em nenhum local, tornando possivel a utilzacao do mesmo em outros projetos *)
class function TFuncoes.CriaClientDataSet(pSql: string;
  var pClientDataSet: TClientDataSet): Boolean;
var
  lProvider: TDataSetProvider;
  lQuery: TXQuery;
  lDm: TDataModule;
begin
  try
    try
      lDm := TDataModule.Create(nil);
      pClientDataSet := TClientDataSet.Create(lDm);

      lProvider := TDataSetProvider.Create(lDm);
      lProvider.Name := 'lProvider';
      lQuery := TXQuery.Create(lDm);
      if not Assigned(ConexaoBanco) then
      begin
        GetConexaoBanco;
      end;

      lQuery.SQLConnection := ConexaoBanco.Conexao;
      lQuery.SqlText := pSql;
      lProvider.dataset := lQuery;
      pClientDataSet.ProviderName := lProvider.Name;
      pClientDataSet.Open;

      result := true;
    finally

      // FreeAndNil(lProvider);
      // FreeAndNil(lDm);
    end;
  except
    on E: Exception do
      TFuncoes.Mensagem(E.Message);
  end;
  result := true;
end;

class procedure TFuncoes.CriaFormComNome(strClass: string; menuTag: integer);
var
  obj: TForm;
  frmClass: TFormClass;
begin
  frmClass := TFormClass(FindClass(strClass));
  try
    obj := frmClass.Create(nil);
    obj.Tag := menuTag;
    obj.ShowModal;
  finally
    FreeAndNil(obj);
  end;
end;

(* Similar a anterior so que salva no HINT do form o nome do objeto que o chamou *)
class function TFuncoes.CriaFormPeloNome(strClass: string; MenuItem: string;
  RepositorioPai: TWinControl = nil; MultiplasInstanciasDoForm: Boolean = false;
  AbreForm: Boolean = true): TForm;
var
  obj: TForm;
  frmClass: TFormClass;

  Aba: TRzTabSheet;
  TabExiste: Boolean;

  function CriaAba(): TRzTabSheet;
  var
    iTab: integer;
  begin
    if not MultiplasInstanciasDoForm then
    begin
      For iTab := 0 to (RepositorioPai as TRzPageControl).PageCount - 1 do
      begin
        if (RepositorioPai as TRzPageControl).Pages[iTab].Name = 'Aba' + strClass
        then
        begin
          (RepositorioPai as TRzPageControl).ActivePageIndex := iTab;
          TabExiste := true;
          Break;
        end;
      end;
      if TabExiste then
      begin
        result := (RepositorioPai as TRzPageControl).ActivePage;
        Exit;
      end;
    end;

    Aba := TRzTabSheet.Create(RepositorioPai);
    Aba.PageControl := RepositorioPai as TRzPageControl;
    Aba.Parent := RepositorioPai;
    Aba.color := clWhite;

    if not MultiplasInstanciasDoForm then
    begin
      Aba.Name := 'Aba' + strClass;
    end;

    Aba.Caption := (obj as TForm).Caption + Aba.Caption;
    result := Aba;
  end;

begin
  frmClass := TFormClass(FindClass(strClass));
  TabExiste := false;

  (* inicio - adicionado para atender criacao de forms em abas *)
  if RepositorioPai <> nil then
  begin
    obj := frmClass.Create(RepositorioPai);
    (obj as TForm).BorderStyle := bsNone;
    if RepositorioPai is TRzPageControl then
    begin
      (obj as TForm).Parent := CriaAba();
    end
    else
    begin
      (obj as TForm).Parent := RepositorioPai;
      if RepositorioPai is TRzTabSheet then
        (RepositorioPai as TRzTabSheet).Caption := (obj as TForm).Caption +
          (RepositorioPai as TRzTabSheet).Caption;
    end;
  end
  else
  begin
    obj := frmClass.Create(nil);
  end;

  if TabExiste then
    Exit;
  (* fim - adicionado para atender criacao de forms em abas *)

  obj.Hint := MenuItem;
  if RepositorioPai <> nil then
  begin
    (obj as TForm).Align := alClient;
    result := (obj as TForm);
    if not AbreForm then
    begin
      Exit;
    end;

    (obj as TForm).Show;
    if Assigned((obj as TForm).OnActivate) then
    begin
      (obj as TForm).OnActivate(obj as TForm);
    end;
  end
  else
  begin
    result := (obj as TForm);
    if not AbreForm then
    begin
      Exit;
    end;
    (obj as TForm).ShowModal;
    FreeAndNil(obj);
  end;
end;

class function TFuncoes.CriaQuery(sql: string;
  pOpenDataSet: Boolean = true): TXQuery;
var
  Query: TXQuery;
begin
  try
    Query := TXQuery.Create(nil);
    if not Assigned(ConexaoBanco) then
    begin
      GetConexaoBanco;
    end;
    Query.SQLConnection := ConexaoBanco.Conexao;

    Query.SqlText := sql;

    if pOpenDataSet then
      Query.Open;

    result := Query;

  except
    on E: Exception do
      TFuncoes.Mensagem(E.Message);
  end;
  result := Query;
end;

class function TFuncoes.CriaClientDataSet(pSql: string;
  pOpenDataSet: Boolean = true): TClientDataSet;
var
  lProvider: TDataSetProvider;
  lCds, lCdsRetorno: TClientDataSet;
  lQuery: TXQuery;
  lDm: TDataModule;
begin
  try
    try
      lDm := TDataModule.Create(nil);
      lCds := TClientDataSet.Create(lDm);
      lCdsRetorno := TClientDataSet.Create(nil);
      lProvider := TDataSetProvider.Create(lDm);
      lProvider.Name := 'lProvider';
      lQuery := TXQuery.Create(lDm);
      if not Assigned(ConexaoBanco) then
      begin
        GetConexaoBanco;
      end;

      lQuery.SQLConnection := ConexaoBanco.Conexao;
      lQuery.SqlText := pSql;
      lProvider.dataset := lQuery;
      lCds.ProviderName := lProvider.Name;
      if pOpenDataSet then
        lCds.Open;

      lCdsRetorno.FieldDefs := lCds.FieldDefs;
      lCdsRetorno.Data := lCds.Data;
    finally
      FreeAndNil(lCds);
      FreeAndNil(lProvider);
      FreeAndNil(lDm);
    end;
  except
    on E: Exception do
      TFuncoes.Mensagem(E.Message);
  end;
  result := lCdsRetorno;
end;

// Executa um instrução e retorna a quantidade de linha afetadas;
class function TFuncoes.ExecSql(var msg: String; sql: string;
  pUsaTransacao: Boolean = true): integer;
var
  Query: TXQuery;
begin

  try
    try
      result := 0;
      msg := '';
      Query := TXQuery.Create(nil);
      Query.SqlText := sql;
      if pUsaTransacao then
        ConexaoBanco.IniciaTransacao;
      result := Query.ExecSql(true);
      // if (result = 0) and (LowerCase(sql).IndexOf('select') <> -1) then
      // result := Query.RecordCount;

      if pUsaTransacao then
        ConexaoBanco.ComitaTransacao;
    except
      on E: Exception do
      begin

        if pUsaTransacao then
          ConexaoBanco.DesfazTransacao;
        msg := E.Message;

        result := -1;
      end;
    end;
  finally
    FreeAndNil(Query);
  end;
end;

// Executa um instrução e retorna a quantidade de linha afetadas;
class Function TFuncoes.ExecQuery(Query: TSqlQuery;
  mostraerro: Boolean = true): String;
begin
  try
    result := '';
    if not Assigned(ConexaoBanco) then
    begin
      GetConexaoBanco;
    end;
    Query.SQLConnection := ConexaoBanco.Conexao;
    Query.Open;

  except
    on E: Exception do
    begin
      if mostraerro then
        TFuncoes.Mensagem(E.Message)
      else
        result := E.Message;
    end;
  end;
end;

class function TFuncoes.ExecSql(pSqls: TStringList;
  pUsaTransacao: Boolean = true): Boolean;
var
  Query: TXQuery;
begin
  try
    Query := TXQuery.Create(nil);

    result := Query.ExecMultSql(pSqls, pUsaTransacao);
  finally
    FreeAndNil(Query);
  end;
end;

(* criptografia *)
class Function TFuncoes.Codifica(Const Strl: String): String;
var
  idmd5: TIdHashMessageDigest5;

Begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := idmd5.HashStringAsHex(Strl);
  finally
    FreeAndNil(idmd5);
  end;
End;

class function TFuncoes.ConsultaSqlCampo(InstrucaoSql: string;
  const Prm: array of TVarRec; NumCampo: integer): Variant;
var
  QTemp: TSQLDataSet;
  F: integer;
begin
  try
    QTemp := TSQLDataSet.Create(Nil);
    QTemp.SQLConnection := ConexaoBanco.Conexao;

    QTemp.CommandText := InstrucaoSql;
    if Prm[0].VInteger <> null then
    begin
      for F := 0 to High(Prm) do
      begin
        with Prm[F] do
          case VType of
            vtInteger:
              QTemp.Params[F].AsInteger := VInteger;
            vtBoolean:
              QTemp.Params[F].AsBoolean := VBoolean;
            vtChar:
              QTemp.Params[F].AsString := VChar;
            vtExtended:
              QTemp.Params[F].AsDateTime := VExtended^;
            vtString:
              QTemp.Params[F].AsString := VString^;
            vtPChar:
              QTemp.Params[F].AsString := VPChar;
            vtAnsiString:
              QTemp.Params[F].AsString := string(VAnsiString);
            vtCurrency:
              QTemp.Params[F].AsCurrency := VCurrency^;
          end;
      end;
    end;

    QTemp.Open;
    if QTemp.Fields[NumCampo].Value <> null then
      result := QTemp.Fields[NumCampo].Value
    else
      result := '';

  finally
    QTemp.Close;
    FreeAndNil(QTemp);
  end;
end;

class procedure TFuncoes.BloqueiaAbas(PageControl: TRzPageControl;
  DataSource: TDataSource);
var
  I: integer;
begin
  for I := 0 to PageControl.PageCount - 1 do
  begin
    PageControl.Pages[I].TabEnabled :=
      not(DataSource.State in [dsInsert, dsedit]);
    if PageControl.ActivePageIndex = PageControl.Pages[I].PageIndex then
    begin
      PageControl.Pages[I].TabEnabled := true;
    end;
  end;
end;

{
  Descrição:
  Função para validar CPF e CNPJ.
  Parametro:
  CpfCnpj - String contendo o Cpf ou Cnpj.
  lMsg - True/false exibe ou não a mensagem de cpf/cnpj invalido para o cliente.
}
class function TFuncoes.ValidaCpfOuCnpj(CpfCnpj: string;
  lMsg: Boolean = true): Boolean;
begin

  if CpfCnpj.Trim = '' then
    Exit(true);

  CpfCnpj := TFuncoes.TiraSimbolos(Trim(CpfCnpj));
  if Length(CpfCnpj) = 11 then
  begin
    result := true;
    if not TFuncoes.ValidaCPF(CpfCnpj) then
    begin
      if lMsg then
        TFuncoes.Mensagem('CPF inválido!', mtWarning);
      result := false;
    end;
  end
  else if Length(CpfCnpj) = 14 then
  begin
    result := true;
    if not TFuncoes.ValidaCNPJ(CpfCnpj) then
    begin
      if lMsg then
        TFuncoes.Mensagem('CNPJ inválido!', mtWarning);
      result := false;
    end;
  end
  else
  begin
    if lMsg then
      TFuncoes.Mensagem('Número inválido!', mtWarning);
    result := false;
  end;
end;

class function TFuncoes.AdicionaMascaraCpfOuCnpj(CpfCnpj: string): string;
begin
  CpfCnpj := TFuncoes.TiraSimbolos(Trim(CpfCnpj));
  if Length(CpfCnpj) = 11 then
  begin
    CpfCnpj := Copy(CpfCnpj, 1, 3) + '.' + Copy(CpfCnpj, 4, 3) + '.' +
      Copy(CpfCnpj, 7, 3) + '-' + Copy(CpfCnpj, 10, 2);
  end
  else if Length(CpfCnpj) = 14 then
  begin
    CpfCnpj := Copy(CpfCnpj, 1, 2) + '.' + Copy(CpfCnpj, 3, 3) + '.' +
      Copy(CpfCnpj, 6, 3) + '/' + Copy(CpfCnpj, 9, 4) + '-' +
      Copy(CpfCnpj, 13, 2);
  end;
  result := CpfCnpj;
end;

{ class function TFuncoes.BuscaPorCpfOuCnpj(Cds: TClientDataSet; CpfCnpj: string;
  EdtCpfCnpj: TRzDBButtonEdit): boolean;
  begin
  Result := false;
  CpfCnpj := TFuncoes.TiraSimbolos(Trim(CpfCnpj));

  if Length(CpfCnpj) = 11 then
  begin
  if not TFuncoes.ValidaCPF(CpfCnpj) then
  begin
  TFuncoes.Mensagem('CPF inválido!', mtWarning);
  EdtCpfCnpj.SetFocus;
  abort;
  end
  else
  begin
  // Formata cpf
  CpfCnpj := TFuncoes.AdicionaMascaraCpfOuCnpj(CpfCnpj);
  Result := TPessoa.CarregaPessoa(CpfCnpj, Cds);
  Cds.FieldByName('pessoafisica').Value := 1;

  end;
  end
  else if Length(CpfCnpj) = 14 then
  begin
  if not TFuncoes.ValidaCNPJ(CpfCnpj) then
  begin
  TFuncoes.Mensagem('CNPJ inválido!', mtWarning);
  EdtCpfCnpj.SetFocus;
  abort;
  end
  else
  begin
  // formata cnpj
  CpfCnpj := TFuncoes.AdicionaMascaraCpfOuCnpj(CpfCnpj);
  Result := TPessoa.CarregaPessoa(CpfCnpj, Cds);
  Cds.FieldByName('pessoafisica').Value := 0;
  end;
  end
  else
  begin
  if Trim(EdtCpfCnpj.Text) <> '' then
  begin
  TFuncoes.Mensagem('CPF/ CNPJ inválido!', mtWarning);
  EdtCpfCnpj.SetFocus;
  abort;
  end
  end;
  end; }

class function TFuncoes.CorrigeIn(S: string): string;
begin
  S := StringReplace(S, ',,', ',', [rfReplaceAll]);
  result := S;
  if Copy(S, Length(S), 1) = ',' then
    result := Copy(S, 0, Length(S) - 1);
end;

class procedure TFuncoes.CentralizarComponente(pComponente,
  pParent: TWinControl; pTipoCentralizacao: TTipoCentralizacao;
  pAlturaBorda: integer);
begin
  if pTipoCentralizacao in [CentralizaHorizontal, CentralizaVerticalHorizontal]
  then
  begin
    pComponente.Left := (pParent.Width div 2) - (pComponente.Width div 2);
  end;

  if pTipoCentralizacao in [CentralizaVertical, CentralizaVerticalHorizontal]
  then
  begin
    pComponente.Top := (pParent.Height div 2) - (pComponente.Height div 2) -
      pAlturaBorda;
  end;
end;

class function TFuncoes.CountChar(texto: String; C: char): integer;
var
  I, vTot: integer;
begin

  // conta o numero de vezes em que o caractrer passado no
  // segundo parametro é encontrado no testo passado no
  // primeiro parametro.
  // EX: parametro 1 =  '99.99.99.9999.999'; parametro 2 = '.'
  // retorno = 4

  vTot := 0;
  For I := 1 to Length(texto) do
  begin
    If (texto[I] = C) or (LowerCase(texto[I]) = LowerCase(C)) then
      vTot := vTot + 1;
  end; // For
  result := vTot;
end;

class function TFuncoes.DefineMascaraTelefone(NumTelefone: string;
  PField: TField): integer;
var
  num: string;
begin
  begin
    num := TFuncoes.TiraSimbolos(NumTelefone);
    TWideStringField(PField).EditMask := '(99)99999-9999;1;_';
  end;
end;

{
  Função que retorna a posição do item procurado em uma String que é transformada
  em um Array. A string deve ser delimitada por ','(virgula).
  Se não for encontrado uma correspondencia o retorno é -1
  Parametro:
  vSearch - Variante que será procurada dentro da string.
  sString - String contendo os valores separado por ','(virgula)
}
class function TFuncoes.StrToStringList(separadores: TSysCharSet; texto: String)
  : TStringList;
var
  lista: TStringList;
  iRetorno: integer;
begin
  lista := TStringList.Create;
  ExtractStrings(separadores, [' '], pChar(texto), lista);
  result := lista;
end;

(* Nome: QuoteItensLista *)
(* Autor: Abinoan *)
(* Data: 24-04-2013 *)
(* Objetivo: transforma o texto delimitados por virgula ou ponto-virgula em string *)
(* e devolve em uma unica string os itens com aspas e ' *)
(* separados pelo menos separador *)

class function TFuncoes.QuoteItensLista(texto: string;
  separador: string = ','): string;
var
  lista: TStringList;
  iAuxiliar: integer;
  xAuxiliar: String;
begin
  lista := TStringList.Create;
  lista := TFuncoes.StrToStringList([',', ';', '|'], texto);

  for iAuxiliar := 0 to lista.Count - 1 do
  begin
    xAuxiliar := xAuxiliar + QuotedStr(lista[iAuxiliar]);
    if iAuxiliar < lista.Count - 1 then
    begin
      xAuxiliar := xAuxiliar + separador;
    end;
  end;

  result := xAuxiliar;
  FreeAndNil(lista);
end;

(* Nome: QuoteItensLista *)
(* Autor: Abinoan *)
(* Data: 24-04-2013 *)
(* Objetivo: transforma o texto passado em stringlist *)
(* e devolve em uma unica string os itens com aspas e ' *)
(* separados pelo menos separador *)

class function TFuncoes.QuoteItensLista(lista: TStringList;
  separador: string = ','): string;
var
  iAuxiliar: integer;
  xAuxiliar: String;
begin
  for iAuxiliar := 0 to lista.Count - 1 do
  begin
    xAuxiliar := xAuxiliar + QuotedStr(lista[iAuxiliar]);
    if iAuxiliar < lista.Count - 1 then
    begin
      xAuxiliar := xAuxiliar + separador;
    end;
  end;

  result := xAuxiliar;
  FreeAndNil(lista);
end;

class function TFuncoes.At(texto, subtexto: string): Boolean;
var
  lista: TStringList;
begin
  lista := TStringList.Create;
  lista := StrToStringList([',', ';', '|'], texto);
  result := lista.IndexOf(subtexto) >= 0;
  FreeAndNil(lista);
end;

class function TFuncoes.CompareDateTimeEdit(edTinicio: TxDateTimeEdit;
  edTfim: TxDateTimeEdit): Boolean;
begin
  if (edTinicio.Text <> '') and (edTfim.Text <> '') and
    ((edTinicio.AsDateTime - edTfim.AsDateTime) > 0) then
  begin
    TFuncoes.Mensagem('A ' + edTinicio.Hint + ' deve ser menor que a ' +
      edTfim.Hint + '.');
    result := false;
  end
  else
  begin
    result := true;
  end;
end;

class function TFuncoes.CompareNumericEdit(edTinicio: TxEditNumerico;
  edTfim: TxEditNumerico): Boolean;
begin
  if (edTinicio.Value > 0) and (edTfim.Value > 0) and
    ((edTinicio.Value - edTfim.Value) > 0) then
  begin
    ShowMessage('A ' + edTinicio.Hint + ' deve ser maior que a ' +
      edTfim.Hint + '.');
    result := false;
  end
  else
  begin
    result := true;
  end;
end;

{ TCarregaModulos }

end.
