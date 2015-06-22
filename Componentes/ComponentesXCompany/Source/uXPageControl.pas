unit uXPageControl;

interface

uses System.Classes, Vcl.Controls, RzCommon, RzTabs, Vcl.Graphics;

type
  TXPageControl = class(TRzPageControl)
  private
    FPadrao: boolean;
    procedure SetPadrao(const Value: boolean);

  public
    constructor Create(AOwner: TComponent); override;
  published
    property Padrao: boolean read FPadrao write SetPadrao;
    property BoldCurrentTab default True;
    property ParentBackgroundColor default False;
    property ParentColor    ;
    property ParentFont     ;
    property ParentShowHint ;
    property ShowShadow     ;
    property Transparent     ;
    property UseColoredTabs  ;
    property Color           ;
    property TabStyle        ;
    property TextOrientation ;

  end;

procedure Register;

implementation
uses uClasseDefinePadrao;

procedure Register;
begin
  RegisterComponents('xComponentes', [TXPageControl]);
end;

constructor TXPageControl.Create(AOwner: TComponent);
begin
  inherited Create(Aowner);
  TDefinePadrao.SetaPadrao(self, True);
end;

procedure TXPageControl.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self,Value);
end;

end.
