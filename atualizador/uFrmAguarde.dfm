object frmAguarde: TfrmAguarde
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmAguarde'
  ClientHeight = 65
  ClientWidth = 271
  Color = clGradientInactiveCaption
  TransparentColorValue = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object panelInfo: TRzPanel
    AlignWithMargins = True
    Left = 67
    Top = 3
    Width = 201
    Height = 59
    Align = alClient
    AutoSize = True
    BorderOuter = fsNone
    Caption = 'Aguarde...'
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentColor = True
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
  end
  object panelProcesso: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 58
    Height = 59
    Align = alLeft
    BorderOuter = fsNone
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentColor = True
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    DesignSize = (
      58
      59)
    object progress: TAdvCircularProgress
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 46
      Height = 44
      Anchors = [akLeft]
      Appearance.BackGroundColor = clNone
      Appearance.BorderColor = clNone
      Appearance.ActiveSegmentColor = 16752543
      Appearance.InActiveSegmentColor = clSilver
      Appearance.TransitionSegmentColor = 10485760
      Appearance.ProgressSegmentColor = 4194432
      Interval = 100
    end
  end
end
