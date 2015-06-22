unit uXEditNumerico;

interface

uses
  WinApi.Windows, System.SysUtils, System.Classes, Vcl.Controls, RzEdit, RzBtnEdt;

type
  //XEit
  TxEdit = class(TRzEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }

  published
    { Published declarations }
  end;

  //ButtonEdit
  TxButtonEdit = class(TRzButtonEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }

  published
    { Published declarations }
  end;

  //xEditQuantidade
  TxEditQuantidade = class(TRzNumericEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }

  published
    { Published declarations }
  end;

procedure Register;

implementation
uses uDmIcones, uXComponentesConstantes, Vcl.StdCtrls;

procedure Register;
begin
  RegisterComponents('xComponentes', [TxEdit, TxButtonEdit, TxEditQuantidade]);
end;

{ TXCompanyBitBtn }

constructor TxEdit.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width     := TamanhoEdit;
  Self.Height    := AlturaEdit;
  Self.TabOnEnter:= True;
  Self.ShowHint  := True;
  Self.ReadOnlyColor := CorReadOnly;
  Self.FocusColor := CorFocoEdit;
end;

{ TxButtonEdit }

constructor TxButtonEdit.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width     := TamanhoEdit;
  Self.Height    := AlturaEdit;
  Self.TabOnEnter:= True;
  Self.ShowHint  := True;
  Self.ReadOnlyColor := CorReadOnly;
  Self.FocusColor := CorFocoEdit;
  Self.ButtonShortCut := VK_F8;
end;

{ xEditQuantidade }
constructor TxEditQuantidade.Create(AOwner: TComponent);
begin
  inherited;
  Self.Width         := TamanhoEdit;
  Self.Height        := AlturaEdit;
  Self.TabOnEnter    := True;
  Self.ShowHint      := True;
  Self.ReadOnlyColor := CorReadOnly;
  Self.FocusColor    := CorFocoEdit;
  Self.DisplayFormat := MascaraQuantidade;
  Self.IntegersOnly  := False;
end;


end.
