unit uXDbEdit;

interface

uses
  System.SysUtils, System.Classes, uXComponentesConstantes, Vcl.Controls, RzDBBnEd, RzDBEdit,
  Vcl.Graphics, RzBtnEdt,Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons ;

type
  TxDbEdit = class(TRzDbEdit)
  private
    FNumerico: boolean;
    FPadrao: boolean;
    FCaractereDecimal: AnsiChar;
    FRequired: boolean;
    FRequiredDisplay: String;
    FBtnOlho: TSpeedButton;
    FMostraValor: Boolean;
    procedure SetPadrao(const Value: boolean);
    procedure SetCaractereDecimal(const Value: AnsiChar);
    procedure btnOlhoClick(Sender: TObject);
    procedure SetMostraValor(const Value: Boolean);

  protected
    procedure EditingChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Change; override;
    procedure KeyPress(var Key: Char); override;
    /// <summary> Ativa e desativa simultaneamente o ReadOnly e o TabStop </summary>
    procedure ReadOnlyAndTabStop(pAtiva:boolean);
    function isNull: boolean;
  published
    property Numerico: boolean read FNumerico write FNumerico;
    property CaractereDecimal: AnsiChar read FCaractereDecimal write SetCaractereDecimal;
    property Required: boolean read FRequired write FRequired  default false;
    property RequiredDisplay: String read FRequiredDisplay write FRequiredDisplay;
    property Padrao: boolean read FPadrao write SetPadrao;
    property MostraValor: Boolean read FMostraValor write SetMostraValor default false;
    property CharCase      default ecUpperCase;
    property TabOnEnter default true;
    property ShowHint      ;
    property ReadOnlyColor ;
    property FocusColor    ;
    property Color         default clWhite;
  end;


  TxDbButtonEdit = class(TRzDbButtonEdit)
  private
    FEnterPressF8: boolean;
    FNumerico: boolean;
    FPadrao: boolean;
    FEnterPressConsulta: boolean;
    FCaractereDecimal: AnsiChar;
    FRequired: boolean;
    FRequiredDisplay: String;
    FMultiplaBusca: Boolean;
    FAllowDeleteKey: Boolean;
    procedure SetPadrao(const Value: boolean);
    procedure SetCaractereDecimal(const Value: AnsiChar);
    procedure SetMultiplaBusca(const Value: Boolean);
    procedure SetNumerico(const Value: boolean);
    function CorrigeTexto(s: string): string;
    procedure SetAllowDeleteKey(const Value: Boolean);

  protected

  public
    constructor Create(AOwner: TComponent); override;
    procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
    procedure KeyPress(var Key: Char); override;
    /// <summary> Ativa e desativa simultaneamente o ReadOnly e o TabStop </summary>
    procedure ReadOnlyAndTabStop(pAtiva:boolean);
    function isNull: boolean;
    procedure ButtonClick; override;
    procedure DoExit; override;

  published
    property EnterPressF8: boolean read FEnterPressF8 write FEnterPressF8;
    property EnterPressConsulta: boolean read FEnterPressConsulta write FEnterPressConsulta;
    property Numerico: boolean read FNumerico write SetNumerico;
    property CaractereDecimal: AnsiChar read FCaractereDecimal write SetCaractereDecimal;
    property Required: boolean read FRequired write FRequired   default false;
    property RequiredDisplay: String read FRequiredDisplay write FRequiredDisplay;
    property MultiplaBusca: Boolean read FMultiplaBusca write SetMultiplaBusca;
    property Padrao: boolean read FPadrao write SetPadrao;
    property CharCase      default ecUpperCase;
    property TabOnEnter default true;
    property AllowDeleteKey : Boolean read FAllowDeleteKey write SetAllowDeleteKey;
    property ShowHint        ;
    property ReadOnlyColor   ;
    property FocusColor      ;
    property Color           ;
    property ButtonShortCut  ;
    property ButtonKind      ;
    property ButtonHint      ;
  end;

  //Componentes de data
  TxDBDateTimeEdit=class(TRzDbDateTimeEdit)
  private
    FPadrao: boolean;
    FRequired: boolean;
    FRequiredDisplay: String;
    procedure SetPadrao(const Value: boolean);

  protected

  public
    constructor Create(AOwner: TComponent); override;
    procedure KeyDown( var Key: Word; Shift: TShiftState ); override;
    /// <summary> Ativa e desativa simultaneamente o ReadOnly e o TabStop </summary>
    procedure ReadOnlyAndTabStop(pAtiva:boolean);
    function isNull: boolean;
  published
    property Padrao: boolean read FPadrao write SetPadrao;
    property Required: boolean read FRequired write FRequired   default false;
    property RequiredDisplay: String read FRequiredDisplay write FRequiredDisplay;

    property CharCase   ;
    property TabOnEnter default true;
    property ShowHint   ;
    property Color      ;
  end;


procedure Register;

implementation
uses uClasseDefinePadrao, Winapi.Windows, uClasseFuncoes;

procedure Register;
begin
  RegisterComponents('xComponentes', [TxDbEdit, TxDbButtonEdit, TxDBDateTimeEdit]);
end;

{ TXDbEdit }

procedure TxDbEdit.btnOlhoClick(Sender: TObject);
begin
  if  PasswordChar = '*' then
  begin
    PasswordChar := #0;
    FBtnOlho.Glyph.Handle := LoadBitmap(hinstance, 'OLHO');
  end
  else
  begin
    PasswordChar := '*';
    FBtnOlho.Glyph.Handle := LoadBitmap(hinstance, 'OLHO_FECHADO');
  end;
end;

procedure TxDbEdit.Change;
begin
  inherited;
  if FMostraValor then
    FBtnOlho.Refresh;
end;

constructor TxDbEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBtnOlho := TSpeedButton.create(self);
  FBtnOlho.SetSubComponent(true);
  FBtnOlho.Parent := self;
  FBtnOlho.Cursor := crHandPoint;
  FBtnOlho.Align := alRight;
  FBtnOlho.OnClick := btnOlhoClick;
  FBtnOlho.Glyph.Handle := LoadBitmap(hinstance, 'OLHO_FECHADO');
  MostraValor := False;
//  if (csDesigning in ComponentState) then
    TDefinePadrao.SetaPadrao(self, True);
end;

procedure TxDbEdit.EditingChanged;
begin
  inherited;
  if MostraValor and Enabled and (PasswordChar <> '*') then
  begin
    btnOlhoClick(self);
  end;
end;

function TxDbEdit.isNull: boolean;
begin
  Exit(Trim(Text)='');
end;

procedure TxDbEdit.KeyPress(var Key: Char);
begin
  inherited;
  if FNumerico then
   if not(Key in ['0' .. '9', '-',FCaractereDecimal, #8, #3, #$16, #$D]) then
    begin
      Key := #0;
    end;
end;

procedure TxDbEdit.ReadOnlyAndTabStop(pAtiva: boolean);
begin
  self.ReadOnly := pAtiva;
  Self.TabStop  := not pAtiva;
end;

procedure TxDbEdit.SetCaractereDecimal(const Value: AnsiChar);
begin
  FCaractereDecimal := Value;
end;

procedure TxDbEdit.SetMostraValor(const Value: Boolean);
begin
  FMostraValor     := Value;
  FBtnOlho.Visible := Value;
  if not FMostraValor then
  begin
    FBtnOlho.Align := alNone;
    FBtnOlho.Top := -Self.Height;
    FBtnOlho.SendToBack;
  end
  else
  begin
    FBtnOlho.Align := alRight;
  end;
  if Value then
    PasswordChar := '*'
  else
    PasswordChar := #0;
  self.Repaint;
end;

procedure TxDbEdit.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self, value);
end;

{ TXDbButtonEdit }
procedure TxDbButtonEdit.ButtonClick;
begin
  inherited ButtonClick;
  if FMultiplaBusca then
  begin
    Text := CorrigeTexto(Text);
  end;
  if Trim(Text) <> '' then
    SelStart := Length(Text);
end;

constructor TxDbButtonEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  if (csDesigning in ComponentState) then
    TDefinePadrao.SetaPadrao(self, True);
end;

Function TxDbButtonEdit.CorrigeTexto(s: string): string;
begin
  s:= StringReplace(s.Trim,',,',',', [rfReplaceAll]);
  Result := s;
  if Copy(s,Length(s),1) = ',' then
     Result :=  Copy(s,0, Length(s)-1);
end;

procedure TxDbButtonEdit.DoExit;
begin
  inherited DoExit;
  if FMultiplaBusca then
  begin
    Text := CorrigeTexto(Text);
  end;
end;

function TxDbButtonEdit.isNull: boolean;
begin
  Exit(Trim(Text)='');
end;

procedure TxDbButtonEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (FEnterPressF8 or FEnterPressConsulta) and (Key = VK_Return) then
  begin
    if Trim(TFuncoes.TiraSimbolos(Text)) = '' then
    begin
      try
        Button.Click;
      finally
        if Trim(Text) = '' then
        if CanFocus then
          SetFocus
      end;
    end;
  end;
  if (AllowDeleteKey) and ((Key = VK_BACK) or (Key = VK_DELETE) or (Key = 0)) then
  begin
    DataSource.DataSet.FieldByName(DataField).Clear;
  end;
end;

procedure TxDbButtonEdit.KeyPress(var Key: Char);
begin
  inherited;
  if FNumerico then
  begin
    if not(Key in ['0' .. '9', '-',FCaractereDecimal, #8, #3, #$16, #$D]) then
    begin
      Key := #0;
    end;
  end
  else if FMultiplaBusca then
  begin
    if not(Key in ['0' .. '9', #8, #3, #$16, ',', #$D]) then
    begin
      Key := #0;
    end;
    if (Key = ',') then
    begin
      if Trim(Text) = '' then
      begin
        Key := #0;
      end
      else if (Text[1] in ['0' .. '9']) and (SelStart = 0) then
      begin
        Key := #0;
      end
      else
      begin
        if Text[Length(Text)] = ',' then
        begin
          Key := #0;
        end;
      end;
    end
  end;
end;

procedure TxDbButtonEdit.ReadOnlyAndTabStop(pAtiva: boolean);
begin
  self.ReadOnly := pAtiva;
  Self.TabStop  := not pAtiva;
  self.ButtonVisible := not pAtiva;
end;

procedure TxDbButtonEdit.SetAllowDeleteKey(const Value: Boolean);
begin
  FAllowDeleteKey := Value;
end;

procedure TxDbButtonEdit.SetCaractereDecimal(const Value: AnsiChar);
begin
  FCaractereDecimal := Value;
end;

procedure TxDbButtonEdit.SetMultiplaBusca(const Value: Boolean);
begin
  FMultiplaBusca := Value;
  if FMultiplaBusca then
  begin
    FNumerico := False;
  end;
end;

procedure TxDbButtonEdit.SetNumerico(const Value: boolean);
begin
  FNumerico := Value;
  if FNumerico then
  begin
    FMultiplaBusca := False;
  end
end;

procedure TxDbButtonEdit.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self,value);
end;

{ TxDBDateTimeEdit }

constructor TxDBDateTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  if (csDesigning in ComponentState) then
    TDefinePadrao.SetaPadrao(self, True);
end;

function TxDBDateTimeEdit.isNull: boolean;
begin
  Exit(Trim(Text)='');
end;

procedure TxDBDateTimeEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_SPACE then
  begin
    keybd_event(VK_MENU, 0, 0, 0);
    keybd_event(VK_DOWN, 0, 0, 0);
    keybd_event(VK_DOWN, 0, KEYEVENTF_KEYUP, 0);
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0);
  end;
end;

procedure TxDBDateTimeEdit.ReadOnlyAndTabStop(pAtiva: boolean);
begin
  self.ReadOnly := pAtiva;
  Self.TabStop  := not pAtiva;
end;

procedure TxDBDateTimeEdit.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self,value);
end;

end.

