unit uXComboBox;

interface

uses RzDBCmbo, RzCmboBx, uXComponentesConstantes, WinApi.Windows, System.Classes, Vcl.Graphics
   ,Vcl.ExtCtrls, Vcl.StdCtrls, uXCompanyBotoes;

type
  TxDbComboBox = class(TRzDBComboBox)
  private
    FPadrao: Boolean;
    FRequired: boolean;
    FRequiredDisplay: String;
    procedure SetPadrao(const Value: Boolean);
  published
    property Padrao: Boolean read FPadrao write SetPadrao;
    property Required: boolean read FRequired write FRequired  default false;
    property RequiredDisplay: String read FRequiredDisplay write FRequiredDisplay;

    property CharCase     ;
    property AllowEdit    stored True default False;
    property AutoDropDown ;
    property TabOnEnter   ;
    property ShowHint     ;
    property ReadOnlyColor;
    property FocusColor   ;
    property Color        ;

  public
    function isNull: boolean;
    constructor Create(AOwner: TComponent); override;
  end;

  TxComboBox = class(TRzComboBox)
  private
    FPadrao: Boolean;
    FRequired: boolean;
    FRequiredDisplay: String;
    procedure SetPadrao(const Value: Boolean);

  published
    property AllowEdit     stored True default False;
    property Padrao: Boolean read FPadrao write SetPadrao;
    property Required: boolean read FRequired write FRequired  default false;
    property RequiredDisplay: String read FRequiredDisplay write FRequiredDisplay;
    property CharCase      ;
    property AutoDropDown  ;
    property TabOnEnter    ;
    property ShowHint      ;
    property ReadOnlyColor ;
    property FocusColor    ;
    property Color         ;
  public
    function isNull: boolean;
    constructor Create(AOwner: TComponent); override;
  end;

procedure Register;

implementation
uses uClasseDefinePadrao, System.SysUtils;

procedure Register;
begin
  RegisterComponents('xComponentes', [TxDbComboBox, TxComboBox]);
end;


{ TxDbComboBox }
constructor TxDbComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TDefinePadrao.SetaPadrao(self, True);
end;

function TxDbComboBox.isNull: boolean;
begin
  Exit(Trim(Value)='');
end;

procedure TxDbComboBox.SetPadrao(const Value: Boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self, Value);
end;

{ TxComboBox }
constructor TxComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
    TDefinePadrao.SetaPadrao(self, True);
end;

function TxComboBox.isNull: boolean;
begin
  Exit(Trim(Value)='');
end;

procedure TxComboBox.SetPadrao(const Value: Boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self, FPadrao);
end;

end.
