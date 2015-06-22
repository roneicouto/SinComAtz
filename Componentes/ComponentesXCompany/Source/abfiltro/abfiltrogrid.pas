unit ABFiltroGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, FormABFiltro, Dialogs, DB, DBGrids;

type
  TABFiltroGrid = class(TComponent)
  private
    FFiltro:String;
    FDataSet:TDataSet;
    FDBGrid:TCustomDBGrid;
    FValCampos:Array[0..50] Of String;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Cancel;
    function Execute:Boolean;
    property Filtro:String Read FFiltro Write FFiltro;
  published
    property DBGrid:TCustomDBGrid Read FDBGrid Write FDBGrid;
    property DataSet:TDataSet Read FDataSet Write FDataSet;
    { Published declarations }
  end;

procedure Register;

var
  Form:TFrmABFiltro;

implementation

procedure Register;
begin
  RegisterComponents('xComponentes', [TABFiltroGrid]);
end;

Function TABFiltroGrid.Execute: Boolean;
var
  vFiltro, Operador1, Operador2, nomeCampo:String;
  varFiltro: Array[0..50] Of String;
  I, numCampo:Integer;
  Ret :Boolean;

const
  vOperadores:Array[0..5] Of String = ('=','>', '>=', '<', '<=', '<>');

Begin
  If FDBGrid = nil Then
  Begin
     Result := False;
     raise Exception.Create('Dbgrid não definido!!!');
  end;

  If FDataset = nil Then
  Begin
     Result := False;
     raise Exception.Create('Dataset não definido!');
  end;

  Try
     nomeCampo := FDBGrid.SelectedField.FieldName;
     numCampo  := FDBGrid.SelectedIndex;
     Ret := False;
  Except
    On E:Exception do
    begin
       raise Exception.Create('DbGrid não definido!');
    end;
  End;

  Try
    Form := TFrmABFiltro.Create(Self);
    try
       for i := 0 To High(FValCampos) Do varFiltro[I] := FValCampos[I];

       Form.ShowModal;
       If Form.ModalResult=mrOK Then
       Begin
          Operador1 := vOperadores[ Form.CbOperador1.ItemIndex ];
          vFiltro := '';

          If Form.CbOperador2.ItemIndex > -1 Then Operador2 := vOperadores[Form.CbOperador2.ItemIndex];
          varFiltro[numCampo] := nomeCampo + Operador1 + '''' + Form.Valor1.Text + '''';

          If (Operador2 <> '') And (Form.Valor2.Text <> '') Then
          Begin
             If Form.Rb_E.Checked Then
                varFiltro[numCampo] := varFiltro[numCampo] + ' And '
              Else
                varFiltro[numCampo] := varFiltro[numCampo] + ' OR ';

             varFiltro[NumCampo] := varFiltro[numCampo] + nomeCampo + Operador2 + '''' + Form.Valor2.Text + '''';
          End;

          vFiltro := varFiltro[0];
          For I := 1 To High( varFiltro ) Do
          Begin
              If (varFiltro[I] <> '') And (vFiltro <> '') Then
                 vFiltro := vFiltro + ' And ';
              vFiltro := vFiltro + varFiltro[I];
          End;

          FFiltro := vFiltro;
          For I := 0 To High(varFiltro) Do
              FValCampos[I] := varFiltro[I];
          If FFiltro <> '' Then
            Ret := True;
       End;
    except
      Ret := False;
    end;
  Finally
    Form.Free;
  End;

  Result := Ret;
end;

procedure TABFiltroGrid.Cancel;
var
  I:Integer;
begin
  For I:=0 To High (FValCampos) Do FValCampos[I] := '';
  FFiltro  := '';
  FDataSet.Filter := '';
  FDataSet.Filtered := False;
end;

end.


