unit uXPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, RzLabel;

type
  TxPanel = class(TPanel)
  private
    FAlturaPanelAntesMinimizar: Integer;
    FAlturaPanelMaximado: Integer;
    FMaximizado: Boolean;
    FBotaoMinimizaRestaura: Boolean;
    FOnMaximize: TNotifyEvent;
    FOnMinimize: TNotifyEvent;
    FTitulo: TRzLabel;
    FPadrao: Boolean;
    FImgMinMax: TImage;
    FMostraTitulo: Boolean;
    FAlturaMaximizado: Integer;
    procedure DoMaximize(sender: TObject); virtual;
    procedure DoMinimize(sender: TObject); virtual;
    procedure SetBotaoMinimizaRestaura(const Value: Boolean);
    procedure SetMaximizado(const Value: Boolean);
    procedure Maximiza();
    procedure Minimiza();
    procedure SetPadrao(const Value: Boolean);
    procedure SetMostraTitulo(const Value: Boolean);
    procedure SetAlturaMaximizado(const Value: Integer);
    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
    procedure ImgMinMaxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //
  public
    property ImgMinMax: TImage read FImgMinMax;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MaximizaMinimiza(sender: TObject);
  published
    property Maximizado: Boolean read FMaximizado write SetMaximizado stored true default true;
    property BotaoMinimizaRestaura: Boolean read FBotaoMinimizaRestaura write SetBotaoMinimizaRestaura;
    property Titulo: TRzLabel read FTitulo write FTitulo stored True;
    property OnMaximize: TNotifyEvent read FOnMaximize write FOnMaximize;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property Padrao: Boolean read FPadrao write SetPadrao;
    property MostraTitulo: Boolean read FMostraTitulo write SetMostraTitulo;
    property AlturaMaximizado:Integer read FAlturaMaximizado write SetAlturaMaximizado stored true;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Color default clWhite;
    property BevelInner default bvNone;
    property BevelOuter default bvNone;
  end;

procedure register;

implementation

{$R Icones16.res }

uses uClasseDefinePadrao;

procedure register;
begin
  RegisterComponents('xComponentes', [TxPanel]);
end;

{ TxPanel }

procedure TxPanel.ImgMinMaxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  PointImg, PointMouse: TPoint;

begin
  PointImg := FImgMinMax.ClientOrigin;
  if ( (X>=PointImg.X) and (X<=(PointImg.X+12)) ) or ((Y>=PointImg.Y) and (Y<=PointImg.Y+12)) then
  begin
    MaximizaMinimiza(Sender);
  end;
//  ShowMessage('x: '+X.ToString()+'   --  Y: '+Y.ToStrin());
end;

constructor TxPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := 60;
  FMaximizado := true;
  FMostraTitulo := False;
  FBotaoMinimizaRestaura := False;

  Titulo := TRzLabel.Create(self);
  Titulo.SetSubComponent(true);
  Titulo.Parent := self;

  FImgMinMax := TImage.Create(self);
  FImgMinMax.Parent := self;
  FImgMinMax.SetSubComponent(true);
  FImgMinMax.Left := Width-18;
  FImgMinMax.Top  := -ImgMinMax.Height;

  TDefinePadrao.SetaPadrao(self, true);
  Titulo.Align   := alNone;
  Titulo.Top     := -Titulo.Height;
  Titulo.SendToBack;
//  Titulo.OnMouseUp := ImgMinMaxMouseUp;
end;

destructor TxPanel.Destroy;
begin
  inherited;
end;

procedure TxPanel.Maximiza;
begin
  if FAlturaPanelMaximado<=Titulo.Height then
  begin
     FAlturaPanelMaximado := FAlturaMaximizado;
  end;

  Self.Height := FAlturaPanelMaximado;
  ImgMinMax.Picture.Bitmap.Handle := LoadBitmap(hinstance, 'MINIMIZA');
  ImgMinMax.Hint := 'Minimizar';
  DoMaximize(self);
  FMaximizado := True;
end;

procedure TxPanel.Minimiza;
begin
  if FAlturaPanelMaximado <= self.Height then
  begin
    FAlturaPanelMaximado := self.Height;
  end;
  ImgMinMax.Picture.Bitmap.Handle := LoadBitmap(hinstance, 'RESTAURA');
  Self.Height := Titulo.Height;
  ImgMinMax.Hint := 'Maximizar';
  DoMinimize(self);
  FMaximizado := False;
end;

procedure TxPanel.DoMaximize(sender: TObject);
begin
  if Assigned(FOnMaximize) then
    OnMaximize(sender);
end;

procedure TxPanel.DoMinimize(sender: TObject);
begin
  if Assigned(FOnMinimize) then
    OnMinimize(sender);
end;

function TxPanel.GetEnabled: Boolean;
begin
  Result := inherited Enabled;
end;

procedure TxPanel.MaximizaMinimiza(sender: TObject);
begin
  if self.Height > Titulo.Height then
  begin
    Minimiza();
  end
  else
  begin
    Maximiza();
  end;
end;

procedure TxPanel.SetAlturaMaximizado(const Value: Integer);
begin
  FAlturaMaximizado := Value;
end;

procedure TxPanel.SetBotaoMinimizaRestaura(const Value: Boolean);
begin
  FBotaoMinimizaRestaura := Value;
  ImgMinMax.Visible := Value;
  if not FBotaoMinimizaRestaura then
    ImgMinMax.Top := -ImgMinMax.Height
  else
  begin
    ImgMinMax.Top := 2;
    ImgMinMax.Left := Width-18;
  end;
  self.Repaint;
end;

procedure TxPanel.SetEnabled(const Value: Boolean);
begin
  inherited Enabled := Value;
  FImgMinMax.Enabled := True;
end;

procedure TxPanel.SetPadrao(const Value: Boolean);
begin
  if (csDesigning in ComponentState) then
  begin
    FPadrao := Value;
    TDefinePadrao.SetaPadrao(self, Value);
  end;
end;

procedure TxPanel.SetMaximizado(const Value: Boolean);
begin
  if (FMaximizado and Value) then
  begin
    exit;
  end;

  FMaximizado := Value;
  if FMaximizado then
  begin
    Maximiza();
  end
  else
  begin
    Minimiza();
  end;
end;

procedure TxPanel.SetMostraTitulo(const Value: Boolean);
begin
  FMostraTitulo := Value;
  Titulo.Visible := Value;

  if not FMostraTitulo then
  begin
    Titulo.Align := alNone;
    Titulo.Top := -Titulo.Height;
    Titulo.SendToBack;
  end
  else
  begin
    Titulo.Align := alTop;
    Titulo.Top := 0;
  end;

  self.Repaint;
end;

end.
