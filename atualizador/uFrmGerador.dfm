object frmGerador: TfrmGerador
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerador de atualiza'#231#227'o do BD xCompany ERP - Vers'#227'o 1.01'
  ClientHeight = 236
  ClientWidth = 569
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    569
    236)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 101
    Height = 16
    Caption = 'Arquivo gerado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 473
    Top = 164
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object LbIPServi: TLabel
    Left = 16
    Top = 75
    Width = 82
    Height = 13
    Alignment = taRightJustify
    Caption = 'Local do Servidor'
  end
  object Label2: TLabel
    Left = 15
    Top = 132
    Width = 83
    Height = 13
    Alignment = taRightJustify
    Caption = 'Usuario do Banco'
  end
  object Label3: TLabel
    Left = 21
    Top = 162
    Width = 77
    Height = 13
    Alignment = taRightJustify
    Caption = 'Senha do Banco'
  end
  object Label4: TLabel
    Left = 24
    Top = 103
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Caption = 'Nome do Banco'
  end
  object btnProcessar: TxBtnCoringa
    Left = 315
    Top = 195
    Width = 118
    Height = 36
    Anchors = [akLeft, akBottom]
    Caption = 'Gerar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnProcessarClick
    ImageIndex = 46
    Images = DmImagens.PngImgIcones_20x20
    AparenciaBotao = tpNenhum
    WidthBotaoPequeno = 0
    Padrao = False
  end
  object edtArquivo: TxButtonEdit
    Left = 7
    Top = 35
    Width = 550
    Height = 21
    Text = ''
    Anchors = [akLeft, akTop, akRight, akBottom]
    CharCase = ecNormal
    Color = clWhite
    FocusColor = 13431548
    ParentShowHint = False
    ReadOnlyColor = clBtnFace
    ShowHint = True
    TabOrder = 0
    ButtonHint = 'Consultar <F8>'
    ButtonKind = bkFind
    ButtonShortCut = 119
    AltBtnWidth = 15
    ButtonWidth = 15
    OnButtonClick = edtArquivoButtonClick
    EnterPressF8 = False
    Numerico = False
    CaractereDecimal = #0
    Padrao = False
    MultiplaBusca = False
    AllowDeleteKey = False
  end
  object xBtnCoringa1: TxBtnCoringa
    Left = 439
    Top = 195
    Width = 118
    Height = 36
    Cancel = True
    Anchors = [akLeft, akBottom]
    Caption = 'Sair (Esc)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = xBtnCoringa1Click
    ImageIndex = 11
    Images = DmImagens.PngImgIcones_20x20
    AparenciaBotao = tpNenhum
    WidthBotaoPequeno = 0
    Padrao = False
  end
  object edtSenha: TMaskEdit
    Left = 108
    Top = 157
    Width = 359
    Height = 22
    AutoSize = False
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 4
    Text = ''
  end
  object edtUsuario: TxEdit
    Left = 108
    Top = 126
    Width = 449
    Height = 22
    Text = 'POSTGRES'
    AutoSize = False
    CharCase = ecNormal
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FocusColor = 13431548
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ReadOnlyColor = clBtnFace
    ShowHint = True
    TabOnEnter = True
    TabOrder = 3
    Numerico = False
    CaractereDecimal = #0
    Padrao = False
  end
  object edtBanco: TxEdit
    Left = 108
    Top = 99
    Width = 449
    Height = 21
    Text = 'SINCOM'
    CharCase = ecNormal
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FocusColor = 13431548
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ReadOnlyColor = clBtnFace
    ShowHint = True
    TabOnEnter = True
    TabOrder = 2
    Numerico = False
    CaractereDecimal = #0
    Padrao = False
  end
  object edtHost: TxEdit
    Left = 108
    Top = 70
    Width = 449
    Height = 21
    Hint = 'IP ou Nome do Micro Servidor'
    Text = ''
    CharCase = ecNormal
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    FocusColor = 13431548
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    ReadOnlyColor = clBtnFace
    ShowHint = True
    TabOnEnter = True
    TabOrder = 1
    Numerico = False
    CaractereDecimal = #0
    Padrao = False
  end
  object edtPorta: TSpinEdit
    Left = 505
    Top = 157
    Width = 52
    Height = 22
    MaxValue = 9999
    MinValue = 0
    TabOrder = 5
    Value = 5432
  end
  object BtnTestaConexao: TxBtnCoringa
    Left = 180
    Top = 195
    Width = 129
    Height = 36
    Caption = 'Testar Conex'#227'o (Ctrl+T)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BtnTestaConexaoClick
    ImageIndex = 47
    Images = DmImagens.PngImgIcones_20x20
    AparenciaBotao = tpNenhum
    WidthBotaoPequeno = 0
    Padrao = False
  end
  object XMLProviderObjetos: TXMLTransformProvider
    TransformRead.TransformationFile = 'C:\xcompany\atualizador\objetos.xtr'
    TransformWrite.TransformationFile = 'C:\xcompany\atualizador\objetos.xtr'
    XMLDataFile = 'C:\xcompany\atualizador\objetos2.xml'
    Left = 464
    Top = 40
  end
  object cdsObjetos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'tipo'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nome'
        Attributes = [faUnNamed]
        DataType = ftMemo
      end
      item
        Name = 'definicao'
        Attributes = [faUnNamed]
        DataType = ftWideMemo
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 284
    Top = 8
    object cdsObjetostipo: TStringField
      FieldName = 'tipo'
    end
    object cdsObjetosdefinicao: TWideMemoField
      FieldName = 'definicao'
      BlobType = ftWideMemo
    end
    object cdsObjetosnome: TWideMemoField
      FieldName = 'nome'
      BlobType = ftWideMemo
    end
  end
  object dsObjeto: TDataSource
    DataSet = cdsObjetos
    Left = 144
    Top = 32
  end
  object cdsTabela: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'Tabela'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'Tipo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scopo'
        ParamType = ptInput
      end>
    ProviderName = 'dspTable'
    RemoteServer = dmAtualizador.LocalConnection1
    Left = 321
    Top = 37
    object cdsTabelascript_create: TWideMemoField
      FieldName = 'script_create'
      BlobType = ftWideMemo
    end
  end
  object cdsCatalogo: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCatalogo_database'
    RemoteServer = dmAtualizador.LocalConnection1
    Left = 200
    Top = 152
    object cdsCatalogoid: TIntegerField
      FieldName = 'id'
    end
    object cdsCatalogoschema: TWideStringField
      FieldName = 'schema'
      Size = 63
    end
    object cdsCatalogonome: TWideMemoField
      DisplayWidth = 100
      FieldName = 'nome'
      BlobType = ftWideMemo
    end
    object cdsCatalogotipo: TWideMemoField
      FieldName = 'tipo'
      BlobType = ftWideMemo
    end
    object cdsCatalogotipodesincronismodedados: TIntegerField
      FieldName = 'tipodesincronismodedados'
    end
    object cdsCatalogotamanho: TWideStringField
      FieldName = 'tamanho'
      Size = 15
    end
    object cdsCatalogoscopo: TWideMemoField
      FieldName = 'scopo'
      BlobType = ftWideMemo
    end
  end
  object cdsTabelas: TClientDataSet
    Aggregates = <>
    FileName = 'tabelas.xml'
    FieldDefs = <
      item
        Name = 'tipo'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'nome'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'definicao'
        Attributes = [faUnNamed]
        DataType = ftWideMemo
      end
      item
        Name = 'indices'
        DataType = ftWideMemo
      end
      item
        Name = 'constraints'
        DataType = ftWideMemo
      end
      item
        Name = 'primarykey'
        DataType = ftWideMemo
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 112
    Top = 145
    object cdsTabelastipo: TStringField
      FieldName = 'tipo'
      Size = 6
    end
    object cdsTabelasnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
    object cdsTabelasdefinicao: TWideMemoField
      FieldName = 'definicao'
      BlobType = ftWideMemo
    end
    object cdsTabelasindices: TWideMemoField
      FieldName = 'indices'
      BlobType = ftWideMemo
    end
    object cdsTabelasconstraints: TWideMemoField
      FieldName = 'constraints'
      BlobType = ftWideMemo
    end
    object cdsTabelasprimarykey: TWideMemoField
      FieldName = 'primarykey'
      BlobType = ftWideMemo
    end
  end
  object DataSource1: TDataSource
    Left = 328
    Top = 97
  end
  object cdsConstraints: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 88
    object cdsConstraintstipo: TWideMemoField
      FieldName = 'tipo'
      BlobType = ftWideMemo
    end
    object cdsConstraintsnome: TWideMemoField
      FieldName = 'nome'
      BlobType = ftWideMemo
    end
    object cdsConstraintstabela: TWideMemoField
      FieldName = 'tabela'
      BlobType = ftWideMemo
    end
    object cdsConstraintstabelaestrangeira: TWideMemoField
      FieldName = 'tabelaestrangeira'
      BlobType = ftWideMemo
    end
    object cdsConstraintscoluna: TWideMemoField
      FieldName = 'coluna'
      BlobType = ftWideMemo
    end
    object cdsConstraintscolunaestrangeira: TWideMemoField
      FieldName = 'colunaestrangeira'
      BlobType = ftWideMemo
    end
    object cdsConstraintsacaoupdate: TWideMemoField
      FieldName = 'acaoupdate'
      BlobType = ftWideMemo
    end
    object cdsConstraintsacaodelete: TWideMemoField
      FieldName = 'acaodelete'
      BlobType = ftWideMemo
    end
  end
  object cdsTriggers: TClientDataSet
    Aggregates = <>
    MasterSource = DataSource1
    PacketRecords = 0
    Params = <>
    ProviderName = 'dspTriggers'
    RemoteServer = dmAtualizador.LocalConnection1
    Left = 296
    Top = 144
    object cdsTriggersoid: TIntegerField
      FieldName = 'oid'
    end
    object cdsTriggersschemaname: TWideStringField
      FieldName = 'schemaname'
      Size = 63
    end
    object cdsTriggerstablename: TWideStringField
      FieldName = 'tablename'
      Size = 63
    end
    object cdsTriggerstriggername: TWideStringField
      FieldName = 'triggername'
      Size = 63
    end
    object cdsTriggersfunction_name: TWideStringField
      FieldName = 'function_name'
      Size = 63
    end
    object cdsTriggersResultdatatype: TWideMemoField
      FieldName = 'Result data type'
      BlobType = ftWideMemo
    end
    object cdsTriggersArgumentdatatypes: TWideMemoField
      FieldName = 'Argument data types'
      BlobType = ftWideMemo
    end
    object cdsTriggersType: TWideMemoField
      FieldName = 'Type'
      BlobType = ftWideMemo
    end
    object cdsTriggerstrigger_def: TWideMemoField
      FieldName = 'trigger_def'
      BlobType = ftWideMemo
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 184
  end
  object dsCatalogo: TDataSource
    DataSet = cdsCatalogo
    Left = 24
    Top = 80
  end
end