object dmAtualizador: TdmAtualizador
  OldCreateOrder = False
  Height = 311
  Width = 543
  object DbConexao: TSQLConnection
    ConnectionName = 'XCOMPANY'
    DriverName = 'DEVARTPOSTGRESQL'
    LoginPrompt = False
    Params.Strings = (
      
        'MetaDataPackageLoader=TDBXDevartPostgreSQLMetaDataCommandFactory' +
        ',DbxDevartPostgreSQLDriver180.bpl'
      'UseQuoteChar=False'
      'VendorLib=dbexppgsql40.dll'
      'SchemaName='
      'EnableBCD=True'
      'DriverUnit=DBXDevartPostgreSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver120.' +
        'bpl'
      
        'DriverAssemblyLoader=Devart.DbxPgsql.DriverLoader.TCRDynalinkDri' +
        'verLoader,Devart.DbxPgsql.DriverLoader,Version=1.0.0.1,Culture=n' +
        'eutral,PublicKeyToken=09af7300eec23701'
      'ProductName=PostgreSQL'
      'GetDriverFunc=getSQLDriverPostgreSQL'
      'LibraryName=dbexppgsql40.dll'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'MaxBlobSize=-1'
      'FetchAll=True'
      'UseUnicode=True'
      'drivername=DEVARTPOSTGRESQL'
      'blobsize=-1'
      'HostName=10.86.254.5:5433'
      'Database=xcompany'
      'User_Name=xcompany'
      'Password=xcompany'
      'port=5433')
    Left = 48
    Top = 32
  end
  object LocalConnection1: TLocalConnection
    Left = 479
    Top = 86
  end
  object dspCatalogo_database: TDataSetProvider
    DataSet = qrycatalogo_database
    Options = [poAllowCommandText]
    Left = 467
    Top = 32
  end
  object qrycatalogo_database: TSQLDataSet
    CommandText = 'select'#13#10'*'#13#10'from'#13#10'vs_catalogo'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DbConexao
    Left = 337
    Top = 31
    object qrycatalogo_databaseid: TIntegerField
      FieldName = 'id'
    end
    object qrycatalogo_databaseschema: TWideStringField
      FieldName = 'schema'
      Size = 63
    end
    object qrycatalogo_databasenome: TWideMemoField
      FieldName = 'nome'
      BlobType = ftWideMemo
      Size = -1
    end
    object qrycatalogo_databasetipo: TWideMemoField
      FieldName = 'tipo'
      BlobType = ftWideMemo
      Size = -1
    end
    object qrycatalogo_databasetipodesincronismodedados: TIntegerField
      FieldName = 'tipodesincronismodedados'
    end
    object qrycatalogo_databasetamanho: TWideStringField
      FieldName = 'tamanho'
      Size = 15
    end
    object qrycatalogo_databasescopo: TWideMemoField
      FieldName = 'scopo'
      BlobType = ftWideMemo
      Size = -1
    end
  end
  object QryTriggers: TSQLDataSet
    CommandText = 'Select * from vs_trigger_definicao where schemaname=:schema'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'schema'
        ParamType = ptInput
      end>
    SQLConnection = DbConexao
    Left = 257
    Top = 119
    object QryTriggersoid: TIntegerField
      FieldName = 'oid'
    end
    object QryTriggersschemaname: TWideStringField
      FieldName = 'schemaname'
      Size = 63
    end
    object QryTriggerstablename: TWideStringField
      FieldName = 'tablename'
      Size = 63
    end
    object QryTriggerstriggername: TWideStringField
      FieldName = 'triggername'
      Size = 63
    end
    object QryTriggersfunction_name: TWideStringField
      FieldName = 'function_name'
      Size = 63
    end
    object QryTriggersResultdatatype: TWideMemoField
      FieldName = 'Result data type'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryTriggersArgumentdatatypes: TWideMemoField
      FieldName = 'Argument data types'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryTriggersType: TWideMemoField
      FieldName = 'Type'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryTriggerstrigger_def: TWideMemoField
      FieldName = 'trigger_def'
      BlobType = ftWideMemo
      Size = -1
    end
  end
  object dspTriggers: TDataSetProvider
    DataSet = QryTriggers
    Options = [poAllowCommandText]
    Left = 251
    Top = 208
  end
  object QryConstraints: TSQLDataSet
    CommandText = 'Select * from vs_constraint  where table_name=:tabela'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'tabela'
        ParamType = ptInput
      end>
    SQLConnection = DbConexao
    Left = 49
    Top = 111
    object QryConstraintstipo: TWideStringField
      FieldName = 'tipo'
      Size = 12
    end
    object QryConstraintsconstraint_name: TWideMemoField
      FieldName = 'constraint_name'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryConstraintstable_name: TWideMemoField
      FieldName = 'table_name'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryConstraintscolumn_name: TWideMemoField
      FieldName = 'column_name'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryConstraintsforeign_table_name: TWideMemoField
      FieldName = 'foreign_table_name'
      BlobType = ftWideMemo
      Size = -1
    end
    object QryConstraintsforeign_column_name: TWideMemoField
      FieldName = 'foreign_column_name'
      BlobType = ftWideMemo
      Size = -1
    end
  end
  object dspConstraint: TDataSetProvider
    DataSet = QryConstraints
    Options = [poAllowCommandText]
    Left = 123
    Top = 112
  end
  object QryIndexes: TSQLDataSet
    CommandText = 
      'Select * from vs_indexes  where table_name=:tabela and schema=:s' +
      'chema'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'tabela'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schema'
        ParamType = ptInput
      end>
    SQLConnection = DbConexao
    Left = 425
    Top = 231
    object QryIndexestable_name: TWideStringField
      FieldName = 'table_name'
      Size = 63
    end
    object QryIndexesindex_name: TWideStringField
      FieldName = 'index_name'
      Size = 63
    end
    object QryIndexescolumn_name: TWideStringField
      FieldName = 'column_name'
      Size = 63
    end
    object QryIndexesschema: TWideStringField
      FieldName = 'schema'
      Size = 63
    end
    object QryIndexestotal_index_size: TWideStringField
      FieldName = 'total_index_size'
      Size = 15
    end
  end
  object dspIndexes: TDataSetProvider
    DataSet = QryIndexes
    Options = [poAllowCommandText]
    Left = 467
    Top = 168
  end
  object dspTable: TDataSetProvider
    DataSet = QryTable
    Options = [poAllowCommandText]
    Left = 323
    Top = 248
  end
  object QryTable: TSQLDataSet
    CommandText = 'Select  script_create(:Tabela,:Tipo,'#39'public'#39', true,:scopo  )'
    MaxBlobSize = -1
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
    SQLConnection = DbConexao
    Left = 377
    Top = 191
    object QryTablescript_create: TWideMemoField
      FieldName = 'script_create'
      BlobType = ftWideMemo
      Size = -1
    end
  end
  object QryConteudo: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DbConexao
    Left = 129
    Top = 39
  end
  object dspConteudo: TDataSetProvider
    DataSet = QryConteudo
    Options = [poAllowCommandText]
    Left = 211
    Top = 16
  end
end
