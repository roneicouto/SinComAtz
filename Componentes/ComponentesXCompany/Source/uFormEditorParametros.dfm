object frmEditorParametros: TfrmEditorParametros
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Editor de Par'#226'metros do Sistema'
  ClientHeight = 380
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object btnAdd: TSpeedButton
    Left = 87
    Top = 342
    Width = 66
    Height = 33
    Hint = 'Adiciona um sub grupo de par'#226'metros'
    Caption = 'Add Itens'
    OnClick = btnAddClick
  end
  object btnRemove: TSpeedButton
    Left = 231
    Top = 342
    Width = 66
    Height = 33
    Caption = 'Remove'
    Enabled = False
    OnClick = btnRemoveClick
  end
  object SpeedButton1: TSpeedButton
    Left = 8
    Top = 342
    Width = 73
    Height = 33
    Hint = 'Adiciona um novo grupo de par'#226'metro'
    Caption = 'Add Grupo'
    OnClick = SpeedButton1Click
  end
  object Label6: TLabel
    Left = 392
    Top = 51
    Width = 73
    Height = 13
    Caption = 'Nome do grupo'
  end
  object btnConfirma: TButton
    Left = 159
    Top = 342
    Width = 66
    Height = 33
    Caption = 'Confirma'
    Enabled = False
    TabOrder = 4
    OnClick = btnConfirmaClick
  end
  object TreeView1: TTreeView
    Left = 8
    Top = 10
    Width = 377
    Height = 326
    AutoExpand = True
    Indent = 19
    TabOrder = 0
    OnChange = TreeView1Change
    OnClick = TreeView1Click
  end
  object xBtnCoringa1: TxBtnCoringa
    Left = 304
    Top = 342
    Width = 82
    Height = 33
    Hint = 'Sair'
    Cancel = True
    Caption = 'Sair <Esc>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = xBtnCoringa1Click
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00F0FBFF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00F0FBFF00F0FBFF00C0C0C000F0FBFF00F0FBFF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F0FB
      FF00F0FBFF00C0C0C000C0A0A0008060600080606000C0C0C000C0C0C000F0FB
      FF00F0FBFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F0FBFF00C0A0
      A00080606000C0A0A000C0A0A000FFFFFF0080606000A4A0A000A4A0A000C0C0
      C000F0FBFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080606000C0A0
      A000F0CAA600F0CAA600F0CAA600FFFFFF00806060004060A0004060A0004060
      A000F0FBFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080606000F0CA
      A600F0CAA600F0CAA600F0CAA600FFFFFF008060600080C0C00080C0C00000A0
      C000FFFFFF00F0CAA600FF00FF00FF00FF00FF00FF00FF00FF0080606000F0CA
      A600F0CAA600F0CAA600F0CAA600FFFFFF008060600080C0C00080C0E00040A0
      C000F0CAA600C0600000FF00FF00FF00FF00FF00FF00FF00FF0080606000F0CA
      A600C0A0A000C0A06000F0CAA600FFFFFF008060600080C0C00080C0E000C0C0
      C000C0600000C0600000FF00FF00FF00FF00FF00FF00FF00FF0080606000F0CA
      A60080606000FFFFFF00F0CAA600FFFFFF008060600080C0C000C0C0C000C060
      0000C0600000C0600000C0600000C0600000C0600000FF00FF0080606000F0CA
      A600C0A0A00080606000F0CAA600FFFFFF0080606000FF00FF00C0600000C060
      0000C0600000C0600000C0600000C0600000C0600000FF00FF0080606000F0CA
      A600F0CAA600F0CAA600F0CAA600FFFFFF0080606000FF00FF00C0A0A000C060
      0000C0600000C0600000C0600000C0600000C0600000FF00FF0080606000F0CA
      A600F0CAA600F0CAA600F0CAA600FFFFFF0080606000C0C0C000F0FBFF00C0A0
      A000C0600000C0600000FF00FF00FF00FF00FF00FF00FF00FF0080606000F0CA
      A600F0CAA600F0CAA600F0CAA600FFFFFF008060600080C0C000FF00FF0080C0
      C000F0CAA600C0600000FF00FF00FF00FF00FF00FF00FF00FF0080606000C0A0
      A000F0CAA600F0CAA600F0CAA600FFFFFF0080606000C0C0C000FF00FF0040A0
      C000FF00FF00F0CAA600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00C0C0
      C000C0A06000C0A0A000C0C0A000FFFFFF008060600000A0C00000A0C00000A0
      C000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00C0C0C000C0A0A0008060600080606000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    AparenciaBotao = tpNenhum
    WidthBotaoPequeno = 0
    Padrao = False
  end
  object rdGrupo: TRzRadioGroup
    Left = 392
    Top = 4
    Width = 321
    Height = 39
    Caption = 'Par'#226'metros agrupados por'
    Columns = 3
    Items.Strings = (
      'Geral'
      'Loja'
      'Esta'#231#227'o de Trabalho')
    TabOrder = 1
    Visible = False
    OnExit = rdGrupoExit
  end
  object painel1: TRzPanel
    Left = 391
    Top = 8
    Width = 321
    Height = 330
    BorderOuter = fsBump
    BorderColor = clNone
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 7
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label2: TLabel
      Left = 11
      Top = 94
      Width = 35
      Height = 13
      Caption = 'Valores'
    end
    object Label3: TLabel
      Left = 12
      Top = 138
      Width = 34
      Height = 13
      Caption = 'Padr'#227'o'
    end
    object Label4: TLabel
      Left = 12
      Top = 50
      Width = 20
      Height = 13
      Caption = 'Tipo'
    end
    object Label5: TLabel
      Left = 14
      Top = 180
      Width = 19
      Height = 13
      Caption = 'Hint'
    end
    object edtNome: TxEdit
      Left = 87
      Top = 22
      Width = 226
      Height = 21
      Hint = 'Informar o Titulo do par'#226'metro Ex. Parametro 1'
      Text = 'EDTNOME'
      CharCase = ecNormal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FocusColor = 13431548
      ParentFont = False
      ParentShowHint = False
      ReadOnlyColor = clBtnFace
      ShowHint = True
      TabOnEnter = True
      TabOrder = 0
      Numerico = False
      Padrao = False
    end
    object edtValores: TxEdit
      Left = 11
      Top = 108
      Width = 302
      Height = 21
      Hint = 'Informar os valor poss'#237'veis Ex. 1,2,3,N'
      Text = 'EDTNOME'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FocusColor = 13431548
      ParentFont = False
      ParentShowHint = False
      ReadOnlyColor = clBtnFace
      ShowHint = True
      TabOnEnter = True
      TabOrder = 1
      OnExit = edtValoresExit
      Numerico = False
      Padrao = False
    end
    object edtPadrao: TxEdit
      Left = 11
      Top = 151
      Width = 302
      Height = 21
      Hint = 
        'Informar o valor padr'#227'o Assumido caso o mesmo n'#227'o seja definido ' +
        'nas configura'#231#245'es'
      Text = 'EDTNOME'
      CharCase = ecNormal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FocusColor = 13431548
      ParentFont = False
      ParentShowHint = False
      ReadOnlyColor = clBtnFace
      ShowHint = True
      TabOnEnter = True
      TabOrder = 2
      OnExit = edtPadraoExit
      Numerico = False
      Padrao = False
    end
    object edtHint: TMemo
      Left = 11
      Top = 195
      Width = 304
      Height = 121
      Hint = 'Informa'#231#245'es pra ajudar o usu'#225'rio a configurar o par'#226'metro'
      Lines.Strings = (
        'edtHint')
      TabOrder = 3
    end
    object edtTipo: TxComboBox
      Left = 11
      Top = 65
      Width = 302
      Height = 21
      Hint = 'Tipo de informa'#231#227'o'
      AutoDropDown = True
      CharCase = ecUpperCase
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FocusColor = 13431548
      ParentFont = False
      ParentShowHint = False
      ReadOnlyColor = clBtnFace
      ShowHint = True
      TabOnEnter = True
      TabOrder = 4
      OnChange = edtTipoChange
      Items.Strings = (
        'VALOR'
        'LISTA'
        'INTERVALO'
        'CHECK')
      Values.Strings = (
        'V'
        'L'
        'I'
        'C')
      Padrao = False
    end
    object edtId: TxEdit
      Left = 7
      Top = 22
      Width = 74
      Height = 21
      Hint = 'Informar o Titulo do par'#226'metro Ex. Parametro 1'
      TabStop = False
      Text = 'EDTNOME'
      CharCase = ecNormal
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      FocusColor = 13431548
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ReadOnlyColor = clBtnFace
      ShowHint = True
      TabOnEnter = True
      TabOrder = 5
      Numerico = False
      Padrao = False
    end
  end
  object edtNomeGrupo: TxEdit
    Left = 392
    Top = 66
    Width = 321
    Height = 21
    Hint = 'Informar o Titulo do par'#226'metro Ex. Parametro 1'
    Text = 'EDTNOME'
    CharCase = ecNormal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FocusColor = 13431548
    ParentFont = False
    ParentShowHint = False
    ReadOnlyColor = clBtnFace
    ShowHint = True
    TabOnEnter = True
    TabOrder = 2
    Visible = False
    Numerico = False
    Padrao = False
  end
end
