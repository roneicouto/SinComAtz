unit uxShape;

interface

uses AdvShape, Vcl.ImgList, System.Classes,System.Actions, Vcl.ActnList;

type
  TxShape = class(TAdvShape)
  private
    FIndexImage: TImageIndex;
    FAction: TAction;
    FActionList: TCustomActionList;
    FTabStop: Boolean;
    FTabOrder: Integer;
    procedure SetIndexImage(const Value: TImageIndex);
    procedure SetAction(const Value: TAction);
    procedure SetActionList(const Value: TCustomActionList);
    procedure SetTabOrder(const Value: Integer);
    procedure SetTabStop(const Value: Boolean);
    { private declarations }
  protected
    { protected declarations }

  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
   property IndexImage: TImageIndex read FIndexImage write SetIndexImage;
    property Action: TAction read FAction write SetAction;
    property ActionList: TCustomActionList read FActionList write SetActionList;
    property TabStop: Boolean read FTabStop write SetTabStop;
    Property TabOrder: Integer read FTabOrder write SetTabOrder;

    { published declarations }
  end;
procedure register;
implementation

uses
  Vcl.Graphics, System.SysUtils;

{ TxShape }

procedure register;
begin
  RegisterComponents('xComponentes', [TxShape]);
end;
constructor TxShape.Create(AOwner: TComponent);
var
  img: TPicture;
  bit: TBitmap;
begin

  try
    inherited Create(AOwner);
    With Self do
    begin
      Left := 368;
      Top := 248;
      Height := 130;
      Width := 130;
      ShapeHeight := 120;
      ShapeWidth := 120;
      Appearance.Brush.Style := bsClear;
      Appearance.Color := clWhite;
      Appearance.ColorTo := clBtnFace;
      Appearance.Direction := gdHorizontal;
      Appearance.URLColor := clBlue;
      Appearance.Color := clHotLight;
      Appearance.ColorTo := clHotLight;
      Font.Color := clWhite;
      bit := TBitmap.Create;
      img := TPicture.Create;
      // Images.GetBitmap(1, img.Bitmap);
      // BackGround.Picture := img;
      BackGround.Position := bpCenter;
      TextOffsetX := 10;
      TextOffsetY := 70;
      Version := '1.2.0.0';


    end;
    fAction := TAction.Create(AOwner);
  finally
    freeandnil(img);
    freeandnil(bit)

  end;

end;

destructor TxShape.Destroy;

begin

  inherited;
end;

procedure TxShape.SetAction(const Value: TAction);
var
  img: TPicture;
  bit: TBitmap;
begin
  FAction := Value;


  try
     img := TPicture.Create;
     bit := TBitmap.Create;
    if (FAction.ActionList <> nil) and
        (FAction.ActionList.Images <> nil) and (FAction.ImageIndex >= 0)   then
        begin
          FAction.ActionList.Images.GetBitmap(FAction.ImageIndex, img.Bitmap);
          BackGround.Picture := img;
//        CopyImageFromImageList(FPngImage, ActionList.Images, ImageIndex);
//        FImageFromAction := True;

        end;


  finally
    freeandnil(img);
    freeandnil(bit)
  end;




end;

procedure TxShape.SetActionList(const Value: TCustomActionList);
begin
  FActionList := Value;
end;

procedure TxShape.SetIndexImage(const Value: TImageIndex);
begin
  FIndexImage := Value;
end;

procedure TxShape.SetTabOrder(const Value: Integer);
begin
  FTabOrder := Value;
end;

procedure TxShape.SetTabStop(const Value: Boolean);
begin
  FTabStop := Value;
end;

end.
