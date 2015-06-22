unit uDmAtualizador;

interface

uses
  System.SysUtils, System.Classes, DBXDevartPostgreSQL, Data.DB, Data.SqlExpr,
  Datasnap.DBClient, Data.FMTBcd, Datasnap.Provider, Datasnap.Win.TConnect;

type
  TdmAtualizador = class(TDataModule)
    DbConexao: TSQLConnection;
    LocalConnection1: TLocalConnection;
    dspCatalogo_database: TDataSetProvider;
    qrycatalogo_database: TSQLDataSet;
    QryTriggers: TSQLDataSet;
    dspTriggers: TDataSetProvider;
    QryConstraints: TSQLDataSet;
    QryConstraintstipo: TWideStringField;
    QryConstraintsconstraint_name: TWideMemoField;
    QryConstraintstable_name: TWideMemoField;
    QryConstraintscolumn_name: TWideMemoField;
    QryConstraintsforeign_table_name: TWideMemoField;
    QryConstraintsforeign_column_name: TWideMemoField;
    dspConstraint: TDataSetProvider;
    QryIndexes: TSQLDataSet;
    QryIndexestable_name: TWideStringField;
    QryIndexesindex_name: TWideStringField;
    QryIndexescolumn_name: TWideStringField;
    QryIndexesschema: TWideStringField;
    QryIndexestotal_index_size: TWideStringField;
    dspIndexes: TDataSetProvider;
    dspTable: TDataSetProvider;
    QryTable: TSQLDataSet;
    QryTablescript_create: TWideMemoField;
    qrycatalogo_databaseid: TIntegerField;
    qrycatalogo_databaseschema: TWideStringField;
    qrycatalogo_databasenome: TWideMemoField;
    qrycatalogo_databasetipo: TWideMemoField;
    qrycatalogo_databasetipodesincronismodedados: TIntegerField;
    qrycatalogo_databasetamanho: TWideStringField;
    qrycatalogo_databasescopo: TWideMemoField;
    QryTriggersoid: TIntegerField;
    QryTriggersschemaname: TWideStringField;
    QryTriggerstablename: TWideStringField;
    QryTriggerstriggername: TWideStringField;
    QryTriggersfunction_name: TWideStringField;
    QryTriggersResultdatatype: TWideMemoField;
    QryTriggersArgumentdatatypes: TWideMemoField;
    QryTriggersType: TWideMemoField;
    QryTriggerstrigger_def: TWideMemoField;
    QryConteudo: TSQLDataSet;
    dspConteudo: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmAtualizador: TdmAtualizador;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
