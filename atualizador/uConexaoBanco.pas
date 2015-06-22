unit uConexaoBanco;

interface

uses
  WinApi.Windows, DB, DBClient, variants, Vcl.Dialogs, SqlExpr, Vcl.Forms,
  Data.DBXCommon, System.Classes, uDmAtualizador, uFrmConfiguraAcessoBD;

type
  TConexaoDb = class(TObject)
  private
    FarquivoIniConfig: String;
    FTransacao: TDBXTransaction;
  protected
    Fconexao: TSqlConnection;
    function ConexaoAtiva: boolean;
  published
    (* metodos published *)
  public
    constructor Create(bancoDeDados:TSQLConnection; ParamArquivoIniConfig:string=''); virtual;
    destructor Destroy; virtual;
    procedure ComitaTransacao;
    procedure DesfazTransacao;
    procedure IniciaTransacao;
    function ProximaSequencia(NomeSequencia: string): integer;

    (* Lista de Propriedades *)
    property Conexao: TSQLConnection read Fconexao write Fconexao;
    property Conectado: Boolean read ConexaoAtiva;
    property Transacao: TDBXTransaction read FTransacao;
    property ArquivoDeConfiguracao:string read FarquivoIniConfig write FarquivoIniConfig;

    (* Lista de Métodos *)
    function Conectar: boolean;
    function TesteConexao(host, banco, usuario, senha: string;
      porta: integer = 5432): boolean;
    procedure Desconectar;
    function ExecSQLMultiplos(SQL: TStringList): Boolean;
    function ExecSQL(SQL: String; Const Prm: Array of Const ): boolean;
    function ConsultaSqlCds(InstrucaoSql: String;
      var Tabela: TclientDataset): boolean;
    function ConsultaSqlCampo(InstrucaoSql: string; const Prm: array of TVarRec;
      NumCampo: integer): Variant;Overload;
    function GerarMd5(Texto: String):string;
    procedure ConfiguraConexao;
  end;

function GetConexaoBanco:TConexaoDb;


var
  ConexaoBanco:TConexaoDb;

implementation

uses SysUtils, IniFiles, uClasseFuncoes, uClasseXQuery;

{ TConexaoDb }

procedure TConexaoDb.IniciaTransacao;
begin
  if not ConexaoBanco.Conexao.InTransaction then
  begin
    FTransacao := ConexaoBanco.Conexao.BeginTransaction;
  end;
end;

procedure TConexaoDb.DesfazTransacao;
begin
  if ConexaoBanco.Conexao.InTransaction then
  begin
    ConexaoBanco.Conexao.RollbackIncompleteFreeAndNil(FTransacao);
  end;
end;

procedure TConexaoDb.ComitaTransacao;
begin
  if ConexaoBanco.Conexao.InTransaction then
  begin
    ConexaoBanco.Conexao.CommitFreeAndNil(FTransacao);
  end;
end;

function GetConexaoBanco:TConexaoDb;

begin
  if not Assigned(ConexaoBanco) then
  begin
    if not Assigned(dmAtualizador) then
    begin
      dmAtualizador := TdmAtualizador.Create(nil);
      dmAtualizador.DbConexao.Open;
    end;

    ConexaoBanco := TConexaoDb.Create(dmAtualizador.DbConexao);
    ConexaoBanco.Conectar;


  end;

  result := ConexaoBanco;
end;

constructor TConexaoDb.create(bancoDeDados:TSQLConnection; ParamArquivoIniConfig:string='');
begin
  if bancoDeDados=nil then
  begin
     raise Exception.Create('Informe a conexão com o Banco!');
  end;
  if ParamArquivoIniConfig = '' then
  begin
    ParamArquivoIniConfig := ExtractFilePath( Application.ExeName )+'atualizador.ini';
  end;
  FarquivoIniConfig := ParamArquivoIniConfig;
  Conexao           := BancoDeDados;
end;

(* Coneta ao Banco Informado *)
function TConexaoDb.Conectar: boolean;
var
  iniConfig:Tinifile;
  EnderecoServidor, NomeDoBanco, NomeUsuarioBanco, SenhaUsuarioBanco, PortaServidor:String;
begin
  iniConfig := Tinifile.Create(FarquivoIniConfig);
    Try
    (* Parametros para conexao com o Banco de Dados do Retaguarda *)

    EnderecoServidor := iniConfig.ReadString ('Conexao', 'IP Servidor'   , '10.86.254.165');
    NomeDoBanco      := iniConfig.ReadString ('Conexao', 'Nome Banco'    , 'xcompany_teste');
    NomeUsuarioBanco := iniConfig.ReadString ('Conexao', 'Usuario Banco' , 'icomp' );
    SenhaUsuarioBanco:= iniConfig.ReadString ('Conexao', 'Senha Banco'   , 'icompdbpw');
    PortaServidor    := iniConfig.ReadString ('Conexao', 'Porta Servidor', '5432'     );

    Fconexao.Close;
    Fconexao.Params.Values['hostname'] := EnderecoServidor+':'+PortaServidor;
    Fconexao.Params.Values['Database'] := NomeDoBanco;
    Fconexao.Params.Values['User_Name']:= NomeUsuarioBanco;
    Fconexao.Params.Values['Password'] := SenhaUsuarioBanco;
    Fconexao.Params.Values['Port']     := PortaServidor;

    try
      if not Fconexao.Connected then
         Fconexao.Connected := true;

        Result := conexao.Connected;
    Except
      On E: Exception do
      begin
        Result := false;
        showmessage('Erro ao conectar ao banco de dados.' + #13#13 + E.Message);
        Self.ConfiguraConexao;
      end;
    end;
  Finally
    iniConfig.Free;
  End;
end;

function TConexaoDb.testeConexao(host, banco, usuario, senha:string;porta:integer=5432): boolean;
var
  aux: string;
  conexaoTeste: TSQLConnection;
begin
  conexaoTeste := TSQLConnection.Create(nil);
  try
    with conexaoTeste do
    begin
      ConnectionName := 'conexaoteste';
      DriverName     := 'DevartPostgreSQL';
      GetDriverFunc  := 'getSQLDriverPostgreSQL';
      LibraryName    := 'dbexppgsql40.dll';
      LoginPrompt    := False;
      VendorLib      := 'dbexppgsql40.dll';

      conexaoTeste.Params.Values['hostname'] := host+':'+IntToStr(porta);
      conexaoTeste.Params.Values['Database'] := banco;
      conexaoTeste.Params.Values['User_Name']:= usuario;
      conexaoTeste.Params.Values['Password'] := senha;
      conexaoTeste.Params.Values['Port']     := IntToStr(porta);
    end;

    try
      conexaoTeste.Connected := true;
      result := conexaoTeste.Connected;
    Except
      on e: exception do
      begin
         result := false;
         raise Exception.Create('Não foi possivel se Conectar ao Banco de Dados!' + #13 +
                                'Ocorreu o seguinte erro.' + #13#13 +
                                '['+ E.Message + ']');
      end;
    end;
  finally
    FreeAndNil(conexaoTeste);
  end;
end;

procedure TConexaoDb.Desconectar;
begin
  FConexao.Connected:=false;
end;

function TConexaoDb.conexaoAtiva: boolean;
begin
  result := FConexao.Connected;
end;

procedure TConexaoDb.ConfiguraConexao;
begin
  TFrmConfigAcessoBD.Executa;
end;

destructor TConexaoDb.destroy;
begin
  FConexao.Free;
end;

(* executa a instrucao sql passada pelo parametro cSQL e retorna por referencia um clientdataset *)
function TConexaoDb.ConsultaSqlCds(InstrucaoSql: String; var Tabela:TclientDataset): Boolean;
var
   ZQuery1:TXQuery;
begin
   if Tabela=nil then
      Tabela := TClientDataSet.Create(nil);

   try
      ZQuery1 := TXQuery( TFuncoes.CriaQuery(InstrucaoSQL) );

      tabela.close;
      tabela.FieldDefs := zQuery1.FieldDefs;
      tabela.CreateDataSet;

      if not zQuery1.IsEmpty then
      begin
         try
            while not zquery1.eof do
            begin
               Tabela.Append;
               Tabela.CopyFields(ZQuery1);
               Tabela.Post;
               zquery1.Next;
            end;
         except
            //
         end;
      end;
   finally
      Result := not ZQuery1.IsEmpty;
      FreeAndNil(ZQuery1);
   end;
end;

(* Executa instrucoes SQL diversas e retorna um cliente dataset paassado por parametro*)
function TConexaoDb.ConsultaSqlCampo(InstrucaoSql: string; const Prm: array of TVarRec;
                                     NumCampo: Integer):Variant;
var
  QTemp:TSQLDataSet;
  F:Integer;
begin
  QTemp:=TSQlDataSet.Create(Nil);
  QTemp.SQLConnection := FConexao;

  QTemp.CommandText := InstrucaoSql;
  if Prm[0].VInteger<>Null then
  begin
    for f:=0 to High(Prm) do
    begin
      with Prm[F] do
        case VType of
           vtInteger   : QTemp.Params[F].asInteger  := VInteger;
           vtBoolean   : QTemp.Params[F].asBoolean  := VBoolean;
           vtChar      : QTemp.Params[F].asString   := VChar;
           vtExtended  : QTemp.Params[F].asDateTime := VExtended^;
           vtString    : QTemp.Params[F].asString   := VString^;
           vtPChar     : QTemp.Params[F].asString   := VPChar;
           vtAnsiString: QTemp.Params[F].asString   := string(VAnsiString);
           vtCurrency  : QTemp.Params[F].asCurrency := VCurrency^;
        end;
    end;
  end;

  QTemp.Open;
  if QTemp.Fields[NumCampo].Value<>Null then
     Result:=QTemp.Fields[NumCampo].Value
  else
     Result:='';

  QTemp.Close;
  FreeAndNil( QTemp );
end;

(* executa uma instrucao SQL passada por como parametro *)
function TConexaoDb.ExecSQL(SQL: String; const Prm: array of Const): Boolean;
var
  QTemp:TxQuery;
  F:integer;
  res:Boolean;
  transac:TDBXTransaction;

begin
  Res:=False;

  QTemp:=TxQuery.Create(Nil);
  QTemp.SQLConnection := FConexao;
  QTemp.CommandText := SQL;

    for f:=0 to High(Prm) do
    with Prm[F] do begin
       QTemp.Params[F].DataType;
       case VType of
          vtInteger   : QTemp.Params[F].asInteger  := VInteger;
          vtBoolean   : QTemp.Params[F].asBoolean  := VBoolean;
          vtChar      : QTemp.Params[F].asString   := VChar;
          vtExtended  : QTemp.Params[F].asDateTime := VExtended^;
          vtString    : QTemp.Params[F].asString   := VString^;
          vtPChar     : QTemp.Params[F].asString   := VPChar;
          vtAnsiString: QTemp.Params[F].asString   := String(VAnsiString);
          vtCurrency  : QTemp.Params[F].asCurrency := VCurrency^;
       end;
    end;

  if not QTemp.SQLConnection.InTransaction then
     transac := ConexaoBanco.Conexao.BeginTransaction;

  try
    QTemp.ExecSQL(true);
    QTemp.SQLConnection.CommitFreeAndNil(transac);
    Res:=True;
  except On E:Exception do
    begin
      QTemp.SQLConnection.RollbackFreeAndNil(transac  );
      raise Exception.Create('Erro Funcao EXECSQL(): ' +  E.Message + #13+ 'SQL: ' + QTemp.CommandText);
    end;
  end;

  Result:=Res;
  QTemp.Free;
End;

(* executa uma instrucao SQL passada por como parametro *)
function TConexaoDb.ExecSqlMultiplos(SQL:TStringList): Boolean;
var
  QTemp:TxQuery;
  F:integer;
  Res:Boolean;
  Transac:TTransactionDesc;
  LinhaExecutada:String;
begin
  Res:=False;

  QTemp:=TxQuery.Create(Nil);
  QTemp.SQLConnection := FConexao;

  if not QTemp.SQLConnection.InTransaction then
     QTemp.SQLConnection.StartTransaction(Transac);

  try
    for f:=0 to Sql.count-1 do
    begin
      LinhaExecutada:=SQL[f];
      QTemp.CommandText := LinhaExecutada;
      QTemp.ExecSQL;
      Res:=True;
    end;

    QTemp.SQLConnection.Commit(Transac);
  except On E:Exception do
    begin
      Res:=False;
      QTemp.SQLConnection.Rollback(Transac);
      raise Exception.Create('ExecSQLMultiplos(): ' + LinhaExecutada + #13 + E.Message);
    end;
  end;

  Result:=Res;
  QTemp.Free;
End;


(* Retorna uma String com o MD5 do parametro gerado *)
function TConexaoDb.GerarMd5(texto:string):String;
var
   sqlTemp:TSqlDataSet;
begin
   sqlTemp:=TSqlDataSet.Create(nil);
   try
      sqlTemp.SQLConnection := FConexao;
      sqlTemp.Commandtext := 'SELECT MD5(' + quotedStr(texto) + ') as resultado';
      sqlTemp.open;
   finally
      Result := Trim(sqlTemp.FieldValues['resultado']);
      FreeAndNil(sqlTemp);
   end;
end;

Function TConexaoDb.ProximaSequencia(NomeSequencia:string):integer;
var
  QrTemp:TSQLDataSet;
begin
  QrTemp := TSQLDataSet.create(nil);
  QrTemp.SQLConnection := ConexaoBanco.Conexao;
  QrTemp.CommandText :=' SELECT NEXTVAL('+quotedStr(NomeSequencia)+') as proximo';
  Try
     QrTemp.Open;
     Result := QrTemp.FieldByName('proximo').AsInteger;
  Except
    on E:Exception do
    begin
       Result := 0;
       raise Exception.Create('Erro: ' + E.Message);
    end;
  End;
end;

end.
