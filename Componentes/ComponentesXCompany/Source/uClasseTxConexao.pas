unit uClasseTxConexao;

interface

uses
  System.SysUtils, System.Classes, DBXDevartPostgreSQL, Data.DBXCommon, Data.DB, Data.SqlExpr;

type
  TxConexao = class(TSQLConnection)
  private
    FConected: Boolean;
    procedure SetConnected(const Value: Boolean);
  public
  published
    property Connected: Boolean read FConected  write SetConnected stored False;
    procedure Open;
  end;

procedure register;

implementation

{$R Icones16.res }

uses uClasseDefinePadrao, Vcl.Dialogs;

procedure register;
begin
  RegisterComponents('xComponentes', [TxConexao]);
end;

{ TxPanel }

{ TxConexao }

procedure TxConexao.Open;
begin
try
 inherited Open
except on e:exception  do
   ShowMessage('Problema na conexao com o banco local');
end;

end;

procedure TxConexao.SetConnected(const Value: Boolean);
begin
try
  inherited Connected := Value;
  FConected := Value;
except on e:exception  do
   showmessage('Problema na conexão com o banco de dados');
end;
 
end;

end.
