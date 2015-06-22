unit xClientDataSet;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TPermissaoCampo = (cfgEditar, cfgMaximo, cfgMinimo, cfgValorPadrao, cfgExibirConteudo);
  TPermissoesCampo = set of TPermissaoCampo;

  TXField = class helper for TField
  private
    function GetCfgEdicao: Boolean;
    procedure SetCfgEdicao(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property CfgEdicao:Boolean read GetCfgEdicao write SetCfgEdicao;
  end;

  TXClientDataSet = class(TClientDataSet)
  private
    FConfigurarSomenteLeitura: Boolean;
    FPermiteConfigurar: TPermissoesCampo;
    procedure SetConfigurarSomenteLeitura(const Value: Boolean);
    function GetConfiguraSomenteLeitura: Boolean;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property PermiteConfigurar:TPermissoesCampo read FPermiteConfigurar write FPermiteConfigurar;
  end;

procedure Register;

implementation

{ TXField }

procedure Register;
begin
  RegisterComponents('xComponentes', [TxClientDataSet]);
end;


{ TXField }


{ TXField }


{ TXField }

function TXField.GetCfgEdicao: Boolean;
begin
  Result :=
end;

procedure TXField.SetCfgEdicao(const Value: Boolean);
begin

end;

{ TXClientDataSet }

function TXClientDataSet.GetConfiguraSomenteLeitura: Boolean;
begin
  result := FConfigurarSomenteLeitura;
end;

procedure TXClientDataSet.SetConfigurarSomenteLeitura(const Value: Boolean);
begin
  FConfigurarSomenteLeitura := Value;
end;

end.
