unit uClasseDefinePadrao;

interface

uses System.Classes, Vcl.Graphics, Winapi.Windows;

type

  TDefinePadrao  = class
    /// <summary> Metodo utilizado para setar os padrões do componentes </summary>
    ///  <param name="pComponete"> Componente que implenta o padrão</param>
    ///  <param name="pAtiva"> Se True ativa o padrão do componente</param>
    class procedure SetaPadrao(pComponente: TComponent; pAtiva: Boolean);
  end;


implementation

uses uXComboBox, uXDbEdit, uXDBGridZebrado, uXEdit,uXComponentesConstantes, RzBtnEdt, 
  Vcl.DBGrids, Vcl.Grids, uXPageControl, RzTabs, RzCommon, uXPanel, uXDBText,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls, uXCompanyBotoes, Vcl.Dialogs,
  System.SysUtils;

{ TDefinePadrao }

class procedure TDefinePadrao.SetaPadrao(pComponente: TComponent;  pAtiva: Boolean);
begin
  if (pComponente is TxBtnCoringa) then
  begin
    with (pComponente as TxBtnCoringa) do
    begin
      if pAtiva then
      begin
        Width    := TamanhoBotoes;
        Height   := AlturaBotoes;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
        Hint     := '';
        ShowHint := True;
      end;
   end;
  end
  else if (pComponente is TxDbComboBox) then
  begin
    with (pComponente as TxDbComboBox) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        AllowEdit     := False;
        AutoDropDown  := True;
        TabOnEnter    := True;
        ShowHint      := True;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;    
  end
  else if (pComponente is TxComboBox) then
  begin
    with (pComponente as TxComboBox) do 
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        AllowEdit     := False;
        AutoDropDown  := True;
        TabOnEnter    := True;
        ShowHint      := True;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end; 
  end
  else if (pComponente is TxDBEdit) then
  begin
    with (pComponente as TxDBEdit) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        TabOnEnter    := True;
        ShowHint      := True;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;  
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR; 
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;
  end
  else if (pComponente is TxDbButtonEdit) then
  begin
    with (pComponente as TxDbButtonEdit) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        TabOnEnter    := True;
        ShowHint      := True;
        Color         := clInfoBk;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;
        ButtonHint    := 'Pressione (F8) para consultar.';
        ButtonShortCut:= VK_F8;
        ButtonKind    := bkFind;
        Font.Size     := FONT_TAM;
        Font.Color    := FONT_COLOR;
        Font.Style    := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;
  end
  else if (pComponente is TxDbDateTimeEdit) then
  begin
    with (pComponente as TxDbDateTimeEdit) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        TabOnEnter    := True;
        ShowHint      := True;
        CaptionTodayBtn := 'Hoje';
        CaptionAM       := 'Manhã';
        CaptionPM       := 'Tarde';
        CaptionSet      := 'Escolher';
        CaptionClearBtn := 'Limpar';
        Color           := clWhite;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;
  end
  else if (pComponente is TxEdit) then
  begin
    with (pComponente as TxEdit) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        TabOnEnter    := True;
        ShowHint      := True;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;    
  end
  else if (pComponente is TxButtonEdit) then
  begin
    with (pComponente as TxButtonEdit) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        TabOnEnter    := True;
        ShowHint      := True;
//        Width         := TamanhoEdit;
//        Height        := AlturaEdit;
        Color         := clInfoBk;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;
        ButtonHint    := 'Consultar <F8>';
        ButtonShortCut:= VK_F8;
        ButtonKind    := bkFind;  
        Font.Size     := FONT_TAM;
        Font.Color    := FONT_COLOR;        
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;
  end
  else if (pComponente is TxDateTimeEdit) then
  begin  
    with (pComponente as TxDateTimeEdit) do
    begin
      if pAtiva then
      begin
        CharCase      := ecUpperCase;
        TabOnEnter    := True;
        ShowHint      := True;
        CaptionTodayBtn := 'Hoje';
        CaptionAM       := 'Manhã';
        CaptionPM       := 'Tarde';
        CaptionSet      := 'Escolher';
        CaptionClearBtn := 'Limpar';
        Color           := clWhite;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;
  end
  else if (pComponente is TxEditNumerico) then
  begin  
    with (pComponente as TxEditNumerico) do
    begin
      if pAtiva then
      begin
        TabOnEnter    := True;
        ShowHint      := True;
        IntegersOnly  := False;
//        Width         := TamanhoEdit;
//        Height        := AlturaEdit;
        ReadOnlyColor := CorReadOnly;
        FocusColor    := CorFoco;
        Color         := clWhite;
        DisplayFormat := MascaraQuantidade;
        Font.Size     := FONT_TAM;
        Font.Name     := FONT_NOME;
        Font.Color    := FONT_COLOR;
      end;
    end;
  end
  else if (pComponente is TxDbTextValor) then
  begin
    with (pComponente as TxDbTextValor) do
    begin
      if pAtiva then
      begin
        Transparent := False;
        Alignment   := taRightJustify;
        BorderColor := clBtnFace;
        BorderInner := fsFlat;
        BorderOuter := fsNone;
        Color       := clInfoBk;
        Font.Name   := FONT_NOME;
        Font.Color  := FONT_COLOR;
        Font.Size   := 12;
        Font.Style  := Font.Style - [fsUnderline,fsItalic, fsStrikeOut];
        Font.Style  := Font.Style + [fsBold];
        Width       := 90;
        Height      := 25;
        Layout      := tlCenter;
        TextMargin  := 2;
      end;
    end;
  end
  else if (pComponente is TxTextValor) then
  begin
    with (pComponente as TxTextValor) do
    begin
      if pAtiva then
      begin
        Transparent := False;
        Alignment   := taRightJustify;
        BorderColor := clBtnFace;
        BorderInner := fsFlat;
        BorderOuter := fsNone;
        Color       := clInfoBk;
        Font.Name   := FONT_NOME;
        Font.Color  := FONT_COLOR;
        Font.Size   := 12;
        Font.Style  := Font.Style - [fsUnderline,fsItalic, fsStrikeOut];
        Font.Style  := Font.Style + [fsBold];
        Width       := 90;
        Height      := 25;
        Layout      := tlCenter;
        Mascara     := ',0.00';
        TextMargin  := 2;
      end;
    end;
  end
  else if (pComponente is TxDBGridZebrado) then
  begin  
    with (pComponente as TxDBGridZebrado) do
    begin
      if pAtiva then
      begin
        AtivaReadOnlyColor := False;
        AlternateColor := True;
        Options := [dgTitles, dgColumnResize, dgColLines, dgRowSelect,
                    dgRowLines, dgTitleClick, dgTitleHotTrack];
        DrawingStyle      := gdsGradient;
        TitleFont.Style   := TitleFont.Style + [fsBold];
        TitleFont.Color   := clWindowText;
        Color             := clWhite;
        ColorLow          := clWindow;
        ColorHigh         := cl3DLight;
        GradientEndColor   := clBtnFace;
        GradientStartColor := clActiveCaption;
        FixedColor         := GradientStartColor;
        Font.Style  := Font.Style - [fsBold,fsUnderline,fsItalic, fsStrikeOut];
      end;
    end;
  end   
  else if (pComponente is TXPageControl) then
  begin
    with (pComponente as TXPageControl) do
    begin
      if pAtiva then
      begin
        BoldCurrentTab := True;
        ParentBackgroundColor := False;
        ParentColor    := False;
        ParentFont     := False;
        ParentShowHint := False;
        ShowShadow     := False;
        Transparent     := True;
        UseColoredTabs  := False;
        FlatColor       := clBlue;
        Color           := clWhite;
        TabColors.HighlightBar := clWhite;
        TabColors.Shadow       := clSilver;
        TabColors.Unselected   := clWhite;
        TextColors.Disabled    := clGrayText;
        TextColors.Selected    := clHotLight;
        TextColors.Unselected  := clBtnText;
        TabStyle               := tsSingleSlant;
        TextOrientation        := orHorizontal;
      end;
    end;
  end
  else if (pComponente is TxPanel) then
  begin
    with (pComponente as TxPanel) do
    begin
      if pAtiva then
      begin
        Color := clWhite;
        BevelInner := bvNone;
        BevelOuter := bvNone;
        with Titulo do
        begin
          AutoSize    := false;
          Align       := alTop;
          Alignment   := taCenter;
          Layout      := tlCenter;
          Height      := 25;
          Color       := clActiveCaption;
          ParentFont  := false;
          AutoSize    := false;
          Caption     := '';
          Font.Size   := 12;
        end;

        ImgMinMax.AutoSize       := True;
        ImgMinMax.Transparent    := true;
        ImgMinMax.Picture.Bitmap.Handle := LoadBitmap(hinstance, 'MINIMIZA');
        ImgMinMax.Visible        := True;
        ImgMinMax.OnClick        := MaximizaMinimiza;
        ImgMinMax.Anchors        := [akRight, akTop];
        ImgMinMax.ShowHint       := True;
        ImgMinMax.Hint           := 'Minimizar';
      end;
    end;
  end
  else if (pComponente is TImage) then
  begin
    with (pComponente as TImage) do
    begin
      Cursor := crHandPoint;
      Height := 25;
      Width  := 25;
      Proportional := True;
      Transparent  := True;
      Picture.Bitmap.Handle := LoadBitmap(hinstance, 'AJUDA');
    end;
  end
end;

end.
