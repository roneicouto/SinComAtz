unit uXAjuda;

interface

uses
  System.Classes, Vcl.ExtCtrls, Vcl.Controls;


type
  TxAjuda = class(TImage)
  private
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

procedure Register;

implementation

uses uClasseDefinePadrao;

{ TxBtnAjuda }

constructor TxAjuda.Create(AOwner: TComponent);
begin
  inherited;
  TDefinePadrao.SetaPadrao(self, True);
end;

procedure Register;
begin
  RegisterComponents('xComponentes', [TxAjuda]);
end;


end.
