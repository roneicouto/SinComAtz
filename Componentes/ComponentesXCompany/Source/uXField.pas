unit uXField;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
//  TPermissaoCampo = (cfgEditar, cfgMaximo, cfgMinimo, cfgValorPadrao, cfgExibirConteudo);
//  TPermissoesCampo = set of TPermissaoCampo;

  TXField = class helper for TField
  private
    FPermiteConfigurar: boolean;
    procedure SetPermiteConfigurar(const Value: boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
//    property PermiteConfigurar:TPermissoesCampo read FPermiteConfigurar write SetPermiteConfigurar;
    property ConfigurarEdicao:boolean read FPermiteConfigurar write SetPermiteConfigurar;

  end;

implementation

{ TXField }


{ TXField }

procedure TXField.SetPermiteConfigurar(const Value: boolean);
begin
  FPermiteConfigurar := Value;
end;

end.
