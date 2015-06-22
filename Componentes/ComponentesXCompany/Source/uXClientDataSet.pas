unit uXField;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TPermissaoCampo = (cfgEditar, cfgMaximo, cfgMinimo, cfgValorPadrao, cfgExibirConteudo);
  TPermissoesCampo = set of TPermissaoCampo;

  TXField = class helper for TField
  private
    FPermiteConfigurar: TPermissoesCampo;
    procedure SetPermiteConfigurar(const Value: TPermissoesCampo);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property PermiteConfigurar:TPermissoesCampo read FPermiteConfigurar write SetPermiteConfigurar;

  end;

implementation

{ TXField }

procedure TXField.SetPermiteConfigurar(const Value: TPermissoesCampo);
begin
  FPermiteConfigurar := Value;
end;

end.
