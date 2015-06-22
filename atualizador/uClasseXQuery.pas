unit uClasseXQuery;

interface

uses Classes, UConexaobanco, Data.DBXCommon,Data.SqlExpr, System.SysUtils;

type
  TXQuery = class(TSqlQuery)
  private
    FConexao: TConexaoDb;
    FAtiva: Boolean;
    FSqlText: string;
    procedure SetAtiva(const Value: Boolean);
    procedure SetSqlText(const Value: string);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor create(pOwner:TComponent=nil);
    property Conexao:TConexaoDb read FConexao write FConexao;
    property SqlText:string read FSqlText write SetSqlText;
    function AsWideStr(pFieldName: string): string;
    function AsStr(pFieldName: string)     : string;
    function AsStrQuoted(pFieldName: string): string;
    function AsInt(pFieldName: string)     : Integer;
    function AsFloat(pFieldName: string)   : Double;
    function AsDateTime(pFieldName: string): TDateTime;
    function AsBool(pFieldName: string)    : Boolean;
    function AsChar(pFieldName: string)    : Char;

    function ExecMultSql(pListaSql: TStringList; pUsaTransacao:Boolean=True):boolean;
  published
    { published declarations }
    property Ativo:Boolean read FAtiva write SetAtiva;
  end;

implementation

{ TXQuery }

uses uDmAtualizador;

function TXQuery.AsBool(pFieldName: string): Boolean;
begin
  Result := self.FieldByName(pFieldName).AsBoolean;
end;

function TXQuery.AsChar(pFieldName: string): Char;
begin
  if self.FieldByName(pFieldName).AsString.Trim = '' then
  begin
    Result := ' ';
  end
  else
    Result := self.FieldByName(pFieldName).AsString[1];
end;

function TXQuery.AsDateTime(pFieldName: string): TDateTime;
begin
  Result := self.FieldByName(pFieldName).AsDateTime;
end;

function TXQuery.AsFloat(pFieldName: string): Double;
begin
  Result := StrToFloatDef(self.FieldByName(pFieldName).AsString,0);
end;

function TXQuery.AsInt(pFieldName: string): Integer;
begin
  Result := StrToIntDef(self.FieldByName(pFieldName).AsString,0);
end;

function TXQuery.AsStr(pFieldName: string): string;
begin
  Result := self.FieldByName(pFieldName).AsString
end;

function TXQuery.AsWideStr(pFieldName: string): string;
begin
  Result := self.FieldByName(pFieldName).AsWideString;
end;

function TXQuery.AsStrQuoted(pFieldName: string): string;
begin
  Result := self.FieldByName(pFieldName).AsString.QuotedString;
end;

constructor TXQuery.create(pOwner:TComponent=nil);
begin
if not Assigned(ConexaoBanco) then
   ConexaoBanco :=  TConexaoDb.Create(dmAtualizador.DbConexao);

  inherited create(pOwner);
  if Self.SqlConnection=nil then
  begin
    Self.SqlConnection := ConexaoBanco.Conexao;
  end;
end;

function TXQuery.ExecMultSql(pListaSql: TStringList; pUsaTransacao:Boolean=True): boolean;
var
  lSql: string;
  lCont: SmallInt;
begin
  try
    lCont:=0;
    if pUsaTransacao then
      ConexaoBanco.IniciaTransacao;
    for lSql in pListaSql do
    begin
      Self.SqlText := lSql;
      lCont:= lCont + Self.ExecSQL(True);
    end;
    Result := true;
    if pUsaTransacao then
      ConexaoBanco.ComitaTransacao;
  except on E: Exception do
    begin
      if pUsaTransacao then
        ConexaoBanco.DesfazTransacao;

      Result:=False;
    end;
  end;
end;

procedure TXQuery.SetAtiva(const Value: Boolean);
begin
  Self.Active := FAtiva;
end;

procedure TXQuery.SetSqlText(const Value: string);
begin
  FSqlText := Value;
  SQL.Text := FSqlText;
end;

end.
