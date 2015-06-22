unit uClasseExportar;

interface

uses DB, System.SysUtils;

procedure ExpHTML(DataSet: TDataSet; Arq: string);
procedure ExpTXT(DataSet: TDataSet; Arq: string; Header: Boolean = false);
procedure ExpXLS(DataSet: TDataSet; Arq: string);
procedure ExpDOC(DataSet: TDataSet; Arq: string);
procedure ExpXML(DataSet: TDataSet; Arq: string);

implementation

uses
  dbWeb, Classes, ComObj, XMLDoc, XMLIntf, Variants;

{ O código abaixo usa a tecnologia WebBroker, criada no Delphi3, para converter um DataSet para HTML. Isso é feito através do objeto DataSetTableProducer. Apesar de ser uma tecnologia antiga e usada para criar CGIs e ISAPIs para Web, é muito simples utilizar suas classes em aplicações Desktop }

procedure ExpHTML(DataSet: TDataSet; Arq: string);
var
  sl: TStringList;
  dp: TDataSetTableProducer;
begin
  sl := TStringList.Create;
  try
    dp := TDataSetTableProducer.Create(nil);
    try
      DataSet.First;
      dp.DataSet := DataSet;
      dp.TableAttributes.Border := 1;
      sl.Text := dp.Content;
      sl.SaveToFile(Arq);
    finally
      dp.free;
    end;
  finally
    sl.free;
  end;
end;

{ O código abaixo usa Delphi puro, montando um TXT no braço, basicamente varremos o dataSet e vamos montando o arquivo texto separando campos por ponto e vírgula }

procedure ExpTXT(DataSet: TDataSet; Arq: string; Header: Boolean = false);
var
  i: integer;
  sl: TStringList;
  st: string;
  ct: integer;
  c: string;
begin
  DataSet.First;
  sl := TStringList.Create;
  try
    st := '';
//    if Header then
//    begin
//      for i := 0 to DataSet.Fields.Count - 1 do
//      begin
//        if ct = 1 then
//          st := st + ';' + DataSet.Fields[i].DisplayLabel
//        else
//          st := st + DataSet.Fields[i].DisplayLabel;
//        ct := 1;
//      end;
//
//      sl.Add(st);
//    end;
    ct := 0;
    DataSet.First;
    while not DataSet.Eof do
    begin
      st := '';
      for i := 0 to DataSet.Fields.Count - 1 do
      begin
        if ct = 1 then
          st := st + ';' + DataSet.Fields[i].asstring.Replace(',','.')
        else
          st := st + DataSet.Fields[i].asstring.Replace(',','.');
        ct := 1;

      end;
      ct := 0;

      sl.Add(stringreplace(st, #10, '', [rfIgnoreCase]));

      DataSet.Next;
    end;
    sl.SaveToFile(Arq);
  finally
    sl.free;
  end;
end;

{ O código abaixo usa a tecnologia OLE para criar uma planilha do Excel e enviar os dados do DataSet . OLE é uma tecnologia que pode ser usada desde o Delphi 2 e permite manipular aplicações automaticamente, o que chamamos de Automation, usando interface COM }

procedure ExpXLS(DataSet: TDataSet; Arq: string);
var
  ExcApp: OleVariant;
  i, l: integer;
begin
  ExcApp := CreateOleObject('Excel.Application');
  ExcApp.Visible := True;
  ExcApp.WorkBooks.Add;
  DataSet.First;
  l := 1;
  DataSet.First;
  while not DataSet.Eof do
  begin
    for i := 0 to DataSet.Fields.Count - 1 do
      ExcApp.WorkBooks[1].Sheets[1].Cells[l, i + 1] := DataSet.Fields[i]
        .DisplayText;
    DataSet.Next;
    l := l + 1;
  end;
  ExcApp.WorkBooks[1].SaveAs(Arq);
end;

{ O código abaixo usa a tecnologia OLE para criar uma tabela no WORD e enviar os dados do DataSet }

procedure ExpDOC(DataSet: TDataSet; Arq: string);
var
  WordApp, WordDoc, WordTable, WordRange: Variant;
  Row, Column: integer;
begin
  WordApp := CreateOleObject('Word.basic');
  WordApp.Appshow;
  WordDoc := CreateOleObject('Word.Document');
  WordRange := WordDoc.Range;
  WordTable := WordDoc.tables.Add(WordDoc.Range, 1, DataSet.FieldCount);
  for Column := 0 to DataSet.FieldCount - 1 do
    WordTable.cell(1, Column + 1).Range.Text := DataSet.Fields.Fields[Column]
      .FieldName;
  Row := 2;
  DataSet.First;
  while not DataSet.Eof do
  begin
    WordTable.Rows.Add;
    for Column := 0 to DataSet.FieldCount - 1 do
      WordTable.cell(Row, Column + 1).Range.Text := DataSet.Fields.Fields
        [Column].DisplayText;
    DataSet.Next;
    Row := Row + 1;
  end;
  WordDoc.SaveAs(Arq);
  WordDoc := unAssigned;
end;

{ O código abaixo usa DOM, ou seja, o objeto XMLDocumento do Delphi para criar uma estrutura XML em memória, que posteriormente é salva em disco }

procedure ExpXML(DataSet: TDataSet; Arq: string);
var
  i: integer;
  xml: TXMLDocument;
  reg, campo: IXMLNode;
begin
  xml := TXMLDocument.Create(nil);
  try
    xml.Active := True;
    DataSet.First;
    xml.DocumentElement := xml.CreateElement('DataSet', '');
    DataSet.First;
    while not DataSet.Eof do
    begin
      reg := xml.DocumentElement.AddChild('row');
      for i := 0 to DataSet.Fields.Count - 1 do
      begin
        campo := reg.AddChild(DataSet.Fields[i].DisplayLabel);
        campo.Text := DataSet.Fields[i].DisplayText;
      end;
      DataSet.Next;
    end;
    xml.SaveToFile(Arq);
  finally
    xml.free;
  end;
end;

end.

  Leia mais em: Exportar DataSets para xml, HTML, TXT, DOC, EXCEL http:
// www.devmedia.com.br/exportar-datasets-para-xmlhtmltxtdocexcel/13629#ixzz3M5wc0OFo
