unit ABFiltroGridSQL;

interface

uses
  DB, Windows, Graphics, Messages, Grids, SysUtils, DBGrids, Classes, Controls,
  Forms, FormABFiltroSQL, DBTables, Dialogs;

type
  TABFiltroGridSQL = class(TComponent)
  private
    FFiltro:String;
    FDBGrid:TCustomDBGrid;
    FValCampos:Array[0..50] Of String;
    FCoringa:String;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    procedure Cancel;
    function Execute:Boolean;
    property Filtro:String Read FFiltro Write FFiltro;
  published
    property DBGrid:TCustomDBGrid Read FDBGrid Write FDBGrid;
    property Coringa:String Read FCoringa Write FCoringa;
    { Published declarations }
  end;

procedure Register;

var
  Form:TFrmABFiltroSQL;

implementation

constructor TABFiltroGridSQL.Create(Owner: TComponent);
begin
  inherited Create(Owner);  // Initialize inherited parts
  Coringa := '*';
end;

procedure Register;
begin
  RegisterComponents('xComponentes', [TABFiltroGridSQL]);
end;

Function TABFiltroGridSQL.Execute: Boolean;
var
  vFiltro, Operador1, Operador2, nomeCampo:String;
  varFiltro: Array[0..50] Of String;
  I, numCampo:Integer;
  Ret :Boolean;

const
  vOperadores:Array[0..5] Of String = ('=','>', '>=', '<', '<=', '<>');

Begin
  if FCoringa='' then
     FCoringa:='*';

  If FDBGrid = nil Then
  Begin
     Result := False;
     raise Exception.Create('Dbgrid não definido!!!');
  end;

  Try
     nomeCampo := FDBGrid.SelectedField.FieldName;
     numCampo  := FDBGrid.SelectedIndex;
     Ret := False;
  Except
    On E:Exception do
    begin
       raise Exception.Create('Erro: ' + E.Message);
    end;
  End;

  Try
    Form := TFrmABFiltroSQL.Create(Self);
    try
       for i := 0 To High(FValCampos) Do //busca os filtros de ate 50 campos para concatenar
           varFiltro[I] := FValCampos[I];

       Form.caption:=Form.caption + ': campo "' + nomecampo +'"';
       Form.ShowModal;
       If Form.ModalResult=mrOK Then
       Begin
          if Form.CbOperador1.ItemIndex<=5 then
             Operador1 := vOperadores[ Form.CbOperador1.ItemIndex ]
          else
             Operador1 := ' Like ';

          if Form.CbOperador1.ItemIndex<=5 then
             varFiltro[numCampo] := nomeCampo + Operador1 + '''' + Form.Valor1.Text + ''''
          else
          begin
             case Form.CbOperador1.ItemIndex of
                6:varFiltro[numCampo] := nomeCampo + Operador1 + quotedStr(Form.Valor1.Text + FCoringa);
                7:varFiltro[numCampo] := nomeCampo + Operador1 + quotedStr(FCoringa + Form.Valor1.Text);
                8:varFiltro[numCampo] := nomeCampo + Operador1 + quotedStr(FCoringa + Form.Valor1.Text + FCoringa);
                9:varFiltro[numCampo] := 'not ' + nomeCampo + Operador1 + quotedStr(FCoringa + Form.Valor1.Text + FCoringa);
             end;
          end;

          vFiltro := '';
          If Form.CbOperador2.ItemIndex > -1 Then
          Begin
             if Form.CbOperador2.ItemIndex<=5 then
               Operador2 := vOperadores[ Form.CbOperador2.ItemIndex ]
             else
                Operador2 := ' Like ';
          End;

          If (Operador2 <> '') And (Form.Valor2.Text <> '') Then
          Begin
             If Form.Rb_E.Checked Then
                varFiltro[numCampo] := varFiltro[numCampo] + ' And '
             Else
                varFiltro[numCampo] := varFiltro[numCampo] + ' OR ';

             If Form.CbOperador2.ItemIndex<=5 then
                varFiltro[NumCampo] := varFiltro[numCampo] + nomeCampo + Operador2 + '''' + Form.Valor2.Text + ''''
             Else
             begin
                case Form.CbOperador2.ItemIndex of
                   6:varFiltro[numCampo] := varFiltro[numCampo] + nomeCampo + Operador2 + quotedStr(      Form.Valor2.Text + FCoringa);
                   7:varFiltro[numCampo] := varFiltro[numCampo] + nomeCampo + Operador2 + quotedStr(FCoringa + Form.Valor2.Text      );
                   8:varFiltro[numCampo] := varFiltro[numCampo] +  nomeCampo + Operador2 + quotedStr(FCoringa + Form.Valor2.Text + FCoringa);
                   9:varFiltro[numCampo] := varFiltro[numCampo] + 'not ' + nomeCampo + Operador2 + quotedStr(FCoringa + Form.Valor2.Text + FCoringa);
                end;
             End;
          End;

          vFiltro := varFiltro[0];
          For I := 1 To High( varFiltro ) Do
          Begin
              If (varFiltro[I] <> '') And (vFiltro <> '') Then
                 vFiltro := vFiltro + ' And ';
              vFiltro := vFiltro + varFiltro[I];
          End;

          FFiltro := vFiltro;
          For I := 0 To
              High(varFiltro) Do FValCampos[I] := varFiltro[I];

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

procedure TABFiltroGridSQL.Cancel;
var
  I:Integer;
begin
  For I:=0 To High (FValCampos) Do FValCampos[I] := '';
  FFiltro  := '';

  FDBGrid.DataSource.DataSet.Filter := '';
  FDBGrid.DataSource.DataSet.Filtered:=false;
end;

end.




