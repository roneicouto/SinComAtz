unit uXDBText;

interface

uses System.Classes, RzDBLbl, Winapi.Windows,Vcl.DBGrids, RzCommon, Vcl.Graphics,
  RzLabel;

type
  TxDbTextValor = class(TRzDbLabel)
  private
    FPadrao: boolean;
    procedure SetPadrao(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Padrao: boolean read FPadrao write SetPadrao default true;
    property Transparent default False;
    property BorderColor default clBtnFace;
    property BorderInner default fsFlat;
    property BorderOuter default fsNone;
    property Color default clInfoBk;
    property Width default 90;
    property Height default 25;
    property Alignment default taRightJustify;
  end;

  TxTextValor = class(TRzLabel)
  private
    FPadrao: boolean;
    FValor: Double;
    FMascara: string;
    procedure SetPadrao(const Value: boolean);
    procedure SetMascara(const Value: string);
    procedure SetValor(const Value: Double);
    function GetValor: Double;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Padrao: boolean read FPadrao write SetPadrao default true;
    property Mascara: string read FMascara write SetMascara;
    property Valor : Double read GetValor write SetValor;
    property Transparent default False;
    property BorderColor default clBtnFace;
    property BorderInner default fsFlat;
    property BorderOuter default fsNone;
    property Color default clInfoBk;
    property Width default 90;
    property Height default 25;
    property Alignment default taRightJustify;
  end;

procedure Register;

implementation

uses uXComponentesConstantes, uClasseDefinePadrao,  Vcl.Dialogs,
  System.SysUtils;

 procedure Register;
begin
  RegisterComponents('xComponentes', [TxDbTextValor,TxTextValor]);
end;
{ TxDbTextValor }

constructor TxDbTextValor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  if (csDesigning in ComponentState) then
    TDefinePadrao.SetaPadrao(self, True);
end;

procedure TxDbTextValor.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self,Value);
end;

{ TxTextValor }

constructor TxTextValor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TDefinePadrao.SetaPadrao(self, True);
end;

function TxTextValor.GetValor: Double;
begin
  FValor := StrToFloatDef(Trim(Caption).Replace('.',''),0);
  Result := FValor;
end;

procedure TxTextValor.SetMascara(const Value: string);
begin
  FMascara := Value;
end;

procedure TxTextValor.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self,Value);
end;

procedure TxTextValor.SetValor(const Value: Double);
begin
  FValor := Value;
  if FMascara.Trim <> '' then
    Caption := FormatFloat(FMascara, FValor)
  else
    Caption := FloatToStr(FValor);
end;

end.
