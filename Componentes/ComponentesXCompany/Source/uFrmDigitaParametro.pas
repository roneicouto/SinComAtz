unit uFrmDigitaParametro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, RzEdit, uXEdit,
  RzButton, uXCompanyBotoes, Vcl.ExtCtrls, RzPanel, RzCmboBx, uXComboBox,
  uClasseParametros;

type
  TfrmDigitaParametro = class(TForm)
    Label1: TLabel;
    btnOk: TxBtnCoringa;
    btnSair: TxBtnCoringa;
    lstValor: TxComboBox;
    edtValor: TxEdit;
    checkValor: TCheckBox;
    edtHint: TMemo;
    edtPadrao: TxEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtDescricao: TMemo;
    procedure btnSairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    fParametro: TParametro;
    { Private declarations }
  public
    property Parametro: TParametro read fParametro write fParametro;
    { Public declarations }
  end;

var
  frmDigitaParametro: TfrmDigitaParametro;

implementation

{$R *.dfm}

procedure TfrmDigitaParametro.btnOkClick(Sender: TObject);
var
  aRet: TArray<String>;
  r: Boolean;
  i: Integer;
begin
  r := False;
  if Parametro.Tipo = tpLista then
    edtValor.Text := lstValor.Text
  else if Parametro.Tipo = tpCheck then
  begin
    if checkValor.Checked then
      edtValor.Text := 'V'
    else
      edtValor.Text := 'F';

  end;
  aRet := Parametro.Valores.Split([',']);
  if Length(aRet) = 0 then
    r := True
  else if Parametro.Tipo = tpIntervalo then

  begin

    if (strtointdef(edtValor.Text,0) >= StrToIntDef(aRet[0],0)) and (StrToIntDef(edtValor.Text,0) <= StrToIntDef(aRet[1],0)) then
    begin
      r := True;
    end;

  end
  else
  begin
    for i := 0 to Length(aRet) - 1 do
    begin
      if edtValor.Text = aRet[i] then
        r := True;

    end;

  end;

  if not r then
  begin
    ShowMessage('Valor do parâmetro inválido !');
    edtValor.SetFocus;
    Self.Tag := 0;
  end
  else
  begin
    Self.Tag := 1;
    Parametro.Valor := edtValor.Text;
    Close;
  end;

end;

procedure TfrmDigitaParametro.btnSairClick(Sender: TObject);
begin
  Self.Tag := 0;
  Close;
end;

end.
