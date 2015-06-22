unit uFrmLocalizarParametro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, uXCompanyBotoes, Vcl.StdCtrls,
  Vcl.Mask, RzEdit, uXEdit;

type
  TfrmLocalizaParametro = class(TForm)
    edtTextoLocalizar: TxEdit;
    xBtnCoringa1: TxBtnCoringa;
    procedure xBtnCoringa1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocalizaParametro: TfrmLocalizaParametro;

implementation

{$R *.dfm}

procedure TfrmLocalizaParametro.FormActivate(Sender: TObject);
begin
edtTextoLocalizar.SelStart := Length( edtTextoLocalizar.Text) ;
end;

procedure TfrmLocalizaParametro.xBtnCoringa1Click(Sender: TObject);
begin
Close;
end;

end.
