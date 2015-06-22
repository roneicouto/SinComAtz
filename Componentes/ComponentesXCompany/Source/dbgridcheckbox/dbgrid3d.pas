{===========================================================}
{= DB Grid3D-Full featured Data aware Grid (32 bit version)=}
{=                                                         =}
{= Walter Campelo                                          =}
{= WEA Sistemas de Informatica                             =}
{=                                                         =}
{= This Grid can display Cells in a 3d fashion, and can    =}
{= show Boolean values as CheckBoxes, while keep all       =}
{= facilities introduced in Delphi's DBGrid.               =}
{= The CheckBoxes will only be avaible when Grid is in 3D  =}
{= mode.                                                   =}
{= The default drawing will be disable for 3D mode in order=}
{= to prevent double drawing of the Grid.                  =}
{= Properties:                                             =}
{=   - Grid3D = Turn 3D mode on or off                     =}
{=   - BoolAsCheck = Turn CheckBoxes on or off             =}
{=                                                         =}
{= Hints:                                                  =}
{=   - Try to use a True Type Font (like Arial), with a    =}
{=     size of at less 9 points, for better results.       =}
{=   - This code will NOT work in Delphi 16 bits.          =}
{=                                                         =}
{= Code:                                                   =}
{=   - Portions of Code came from the 3DGrid component of  =}
{=     Saverio Pieri. saveriop@centrohl.it, many thanks.   =}
{=                                                         =}
{= There is no guaranties implicit or explicit for use     =}
{= this component. I will NOT be responsible for any       =}
{= damage or loss that could happen using this code.       =}
{= Feel free to make any changes to the code, but if you   =}
{= find any bug or made any improvement, please, let me    =}
{= know about.                                             =}
{= Please be gentle, this is my first component!!!         =}
{=                                                         =}
{=          Enjoy it!                                      =}
{=                                                         =}
{= My e-mail adress is: weasistemas@netsite.com.br         =}
{=                                                         =}
{=                THIS CODE IS FREEWARE                    =}
{=                                                         =}
{===========================================================}

unit DBGrid3D;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Types, DBGrids;

type
  TDB3DGrid = class(TCustomDBGrid)
  private
    FGrid3D : boolean;
    FBoolAsCheck : boolean;
    procedure SetGrid3D(Value : Boolean);
    procedure SetBoolAsCheck(Value : Boolean);
  protected
    procedure DrawCell(ACol, ARow: Longint;ARect: TRect; AState: TGridDrawState); override;
    function  CanEditShow: Boolean; override;
    function  IsBoolCheck: Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner : TComponent); override;
    property Canvas;
    property SelectedRows;
  published
    property Align;
    property BoolAsCheck : boolean read FBoolAsCheck write SetBoolAsCheck default True;
    property BorderStyle;
    property Columns stored StoreColumns;
    property Color default clBtnFace;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing default False;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property Grid3D : boolean read FGrid3D write SetGrid3D default True;
    property Options;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

uses
  ExtCtrls, DB;


function Max( Frst,Sec : LongInt ): LongInt;
begin
  if Frst >= Sec then
    Result := Frst
  else
    Result := Sec
end;

procedure DrawCheck( ACanvas: TCanvas; const ARect: TRect; Checked:Boolean );
var
  TempRect   : TRect;
  OrigRect   : TRect;
  Dimension  : Integer;
  OldColor   : TColor;
  OldPenWidth: Integer;
  OldPenColor: TColor;
  B          : TRect;
  DrawBitmap : TBitmap;
begin
  OrigRect := ARect;
  DrawBitmap := TBitmap.Create;
  try
    DrawBitmap.Canvas.Brush.Color := ACanvas.Brush.Color;
    with DrawBitmap, OrigRect do
    begin
      Height := Max(Height, Bottom - Top);
      Width := Max(Width, Right - Left);
      B := Rect(0, 0, Right - Left, Bottom - Top);
    end;
    with DrawBitmap, OrigRect do ACanvas.CopyRect(OrigRect, Canvas, B);
    TempRect := OrigRect;
    TempRect.Top:=TempRect.Top+1;
    TempRect.Bottom:=TempRect.Bottom+1;
    with TempRect do
    begin
      Dimension := ACanvas.TextHeight('W')-3;
      Top    := ((Bottom+Top)-Dimension) shr 1;
      Bottom := Top+Dimension;
      Left   := ((Left+Right)-Dimension) shr 1;
      Right  := Left+Dimension;
    end;
    Frame3d(ACanvas,TempRect,clBtnShadow,clBtnHighLight,1);
    Frame3d(ACanvas,TempRect,clBlack,clBlack,1);
    with ACanvas do
    begin
      OldColor    := Brush.Color;
      OldPenWidth := Pen.Width;
      OldPenColor := Pen.Color;
      Brush.Color := clWindow;
      FillRect(TempRect);
    end;
    if Checked then
    begin
      with ACanvas,TempRect do
      begin
        Pen.Color := clBlack;
        Pen.Width := 1;
        MoveTo( Left+1,Top+2 );
        LineTo( Right-2,Bottom-1);
        MoveTo( Left+1,Top+1);
        LineTo( Right-1,Bottom-1);
        MoveTo( Left+2,Top+1);
        LineTo( Right-1,Bottom-2);

        MoveTo( Left+1,Bottom-3);
        LineTo( Right-2,Top);
        MoveTo( Left+1,Bottom-2);
        LineTo( Right-1,Top);
        MoveTo( Left+2,Bottom-2);
        LineTo( Right-1,Top+1);
      end;
    end;
    ACanvas.Pen.Color  := OldPenColor;
    ACanvas.Pen.Width  := OldPenWidth;
    ACanvas.Brush.Color:= OldColor;
  finally
    DrawBitmap.Free;
  end;
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
var
  B, R: TRect;
  I, Left: Integer;
  DrawBitmap : TBitmap;
  OrigRect: TRect;
begin
  OrigRect := ARect;
  DrawBitmap := TBitmap.Create;
  try
    I := ColorToRGB(ACanvas.Brush.Color);
    if GetNearestColor(ACanvas.Handle, I) = I then
    begin
      case Alignment of
        taLeftJustify:
          Left := OrigRect.Left + DX;
        taRightJustify:
          Left := OrigRect.Right - ACanvas.TextWidth(Text) - 3;
      else
        Left := OrigRect.Left + (OrigRect.Right - OrigRect.Left) shr 1
          - (ACanvas.TextWidth(Text) shr 1);
      end;
      ExtTextOut(ACanvas.Handle, Left, OrigRect.Top + DY, ETO_OPAQUE or
        ETO_CLIPPED, @OrigRect, PChar(Text), Length(Text), nil);
    end
    else begin
      with DrawBitmap, OrigRect do
      begin
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        DrawText(Handle, PChar(Text), Length(Text), R, AlignFlags[Alignment]);
      end;
      ACanvas.CopyRect(OrigRect, DrawBitmap.Canvas, B);
    end;
  finally
    DrawBitmap.Free;
  end;
end;

{ DB3DGrid }

constructor TDB3DGrid.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Color := clBtnFace;
  Grid3d:= True;
  FBoolAsCheck:= True;
  DefaultDrawing:=False;
end;

procedure TDB3DGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  DrawColumn : TColumn;
  OldActive  : Integer;
  Value      : Boolean;
  ValueStr   : String;
begin
  if FGrid3D then DefaultDrawing := False;
  Canvas.FillRect( ARect );
  inherited DrawCell(ACol, ARow,ARect,AState);
  if FGrid3D and ([dgRowLines, dgColLines] * Options =
      [dgRowLines, dgColLines]) then
  begin
    if not (gdFixed in AState) then
    begin
      if (ACol <= Columns.Count) and assigned(Columns[ACol-1].Field) then
      begin
        DrawColumn := Columns[ACol-1];
        if (Columns[ACol-1].Field.DataType = ftBoolean) and FBoolAsCheck then
        begin
          OldActive := DataLink.ActiveRecord;
          try
            DataLink.ActiveRecord := ARow-1;
            if Assigned(DrawColumn.Field) then
            begin
              Value := DrawColumn.Field.AsBoolean;
              DrawCheck(Canvas, ARect, Value );
            end;
          finally
            DataLink.ActiveRecord := OldActive;
          end;
        end
        else begin
          OldActive := DataLink.ActiveRecord;
          try
            DataLink.ActiveRecord := ARow-1;
            if Assigned(DrawColumn.Field) then
            begin
              ValueStr := DrawColumn.Field.AsString;
              WriteText(Canvas, ARect, 2, 2, ValueStr, Columns[ACol-1].Alignment);
            end;
          finally
            DataLink.ActiveRecord := OldActive;
          end;
        end;
      end;
    end;
    with ARect,Canvas do
    begin
      if (gdFixed in AState) then
        Frame3d(Canvas,ARect,clBtnHighLight,clBtnShadow,2)
      else begin
        Pen.Color := clBtnHighLight;
        PolyLine([Point(Left,Bottom-1), Point(Left,Top), Point(Right,Top)]);
        Pen.Color := clBtnShadow;
        PolyLine([Point(Left,Bottom),Point(Right,Bottom),Point(Right,Top-1)]);
      end;
    end;
  end;
end;

procedure TDB3DGrid.SetGrid3D(Value : Boolean);
begin
  if FGrid3D<>Value then
  begin
    FGrid3D:=Value;
    DefaultDrawing := not FGrid3d;
    FBoolAsCheck := FGrid3d;
    Invalidate;
  end;
end;

procedure TDB3DGrid.SetBoolAsCheck(Value : Boolean);
begin
  if not FGrid3D then
  begin
    if FBoolAsCheck then
    begin
      FBoolAsCheck := False;
      Invalidate;
    end;
    Exit;
  end;
  if FBoolAsCheck<>Value then
  begin
    FBoolAsCheck:= Value;
    Invalidate;
  end;
end;

function TDB3DGrid.IsBoolCheck: Boolean;
begin
  Result := False;
  if (FGrid3D=true) and ([dgRowLines, dgColLines] * Options =
      [dgRowLines, dgColLines]) then
  begin
    if assigned(Columns[Col-1].Field) then
    begin
      if (Columns[Col-1].Field.DataType = ftBoolean) and FBoolAsCheck then
        Result := True;
    end;
  end;
end;

function TDB3DGrid.CanEditShow: Boolean;
begin
  Result := not IsBoolCheck and inherited CanEditShow;
end;

procedure TDB3DGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Cell  : TGridCoord;
  OldCol: Integer;
  OldRow: Integer;
  State : Boolean;
  Rect  : TRect;
  OldBrush: TBrush;
  OldPen  : TPen;
begin
  OldCol := Col;
  OldRow := Row;
  inherited MouseDown(Button, Shift, X, Y);
  Cell := MouseCoord(X, Y);
  if IsBoolCheck then
  begin
    if DataLink.Active and (Cell.X=OldCol) and (Cell.Y=OldRow) then
    begin
      if DataLink.DataSet.State = dsBrowse then
        DataLink.DataSet.Edit;
      if (DataLink.DataSet.State = dsEdit) or (DataLink.DataSet.State = dsInsert) then
      begin
        Columns[Col-1].Field.AsBoolean := not Columns[Col-1].Field.AsBoolean;
        State := (Columns[Col-1].Field.AsBoolean);

        Rect := BoxRect( Col,Row,Col,Row );
        with Canvas, Rect do
        begin
          OldBrush := Brush;
          OldPen   := Pen;
          Brush.Color := clHighLight;
          DrawCheck(Canvas, Rect, State);
          Pen.Color := clBtnHighLight;
          PolyLine([Point(Left,Bottom-1), Point(Left,Top), Point(Right,Top)]);
          Pen.Color := clBtnShadow;
          PolyLine([Point(Left,Bottom),Point(Right,Bottom),Point(Right,Top-1)]);
          Brush := OldBrush;
          Pen   := OldPen;
        end;
      end;
    end;
  end;
end;

procedure TDB3DGrid.KeyPress(var Key: Char);
var
  OldBrush : TBrush;
  OldPen   : TPen;
  State    : Boolean;
  Rect     : TRect;
begin
//  if not (dgAlwaysShowEditor in Options) and ( (Key = #13) Or (Key = char(vk_space)) ) and IsBoolCheck then
  if not (dgAlwaysShowEditor in Options) and (Key = #13) and IsBoolCheck then
  begin
    if DataLink.Active then
    begin
      if DataLink.DataSet.State = dsBrowse then
        DataLink.DataSet.Edit;
      if (DataLink.DataSet.State = dsEdit) or (DataLink.DataSet.State = dsInsert) then
      begin
        Columns[Col-1].Field.AsBoolean := (not Columns[Col-1].Field.AsBoolean);
        State := (Columns[Col-1].Field.AsBoolean);

        Rect := BoxRect( Col,Row,Col,Row );
        with Canvas, Rect do
        begin
          OldBrush := Brush;
          OldPen   := Pen;
          Brush.Color := clHighLight;
          DrawCheck(Canvas, Rect, State);
          Pen.Color := clBtnHighLight;
          PolyLine([Point(Left,Bottom-1), Point(Left,Top), Point(Right,Top)]);
          Pen.Color := clBtnShadow;
          PolyLine([Point(Left,Bottom),Point(Right,Bottom),Point(Right,Top-1)]);
          Brush := OldBrush;
          Pen   := OldPen;
        end;
      end;
    end;
  end;
  inherited KeyPress(Key);
end;

procedure Register;
begin
  RegisterComponents('xComponentes', [TDB3DGrid]);
end;

end.
