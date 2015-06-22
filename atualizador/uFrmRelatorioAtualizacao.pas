unit uFrmRelatorioAtualizacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, RzEdit;

type
  TfrmRelatorioAtualizacao = class(TForm)
    mensagem: TRzMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioAtualizacao: TfrmRelatorioAtualizacao;

implementation

{$R *.dfm}

end.
