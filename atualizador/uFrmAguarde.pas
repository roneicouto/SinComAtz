unit uFrmAguarde;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AeroLabel, AdvCircularProgress,
  Vcl.StdCtrls, RzLabel, Vcl.ExtCtrls, RzPanel;

type
  TfrmAguarde = class(TForm)
    panelInfo: TRzPanel;
    panelProcesso: TRzPanel;
    progress: TAdvCircularProgress;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    WindowList: Pointer;
    FForm: TForm;
    function GetInformacao: String;
    procedure SetInformacao(const Value: String);
  public
    /// <summary>Instancia e abre o formulário</summary>
    /// <param name="pInfo"> Informação que será exibida no formulário. Ex.: Aguarde...</param>
    procedure Abrir(pInfo: String = 'Aguarde...'; pForm: TForm = nil;
      tamanho: Integer = 0; largura: Integer = 0);
    /// <summary>Fecha e destroy o formulário, deve ser chamador no bloco TRY FINALLY </summary>
    procedure Fechar;
    property Informacao: String read GetInformacao write SetInformacao;
  end;

var
  frmAguarde: TfrmAguarde;

implementation

{$R *.dfm}
{ TfrmAguarde }

procedure TfrmAguarde.Abrir(pInfo: String; pForm: TForm; tamanho: Integer;
  largura: Integer);
begin
  if not Assigned(frmAguarde) then
  begin
    frmAguarde := TfrmAguarde.Create(Screen.ActiveForm);
    if tamanho > 0 then
      frmAguarde.Height := tamanho;
    if largura > 0 then
      frmAguarde.Width := largura;

    // Desabilita todos os formulários com exceção de frmAguarde
    frmAguarde.FForm := pForm;
    if frmAguarde.FForm <> nil then
    begin
       frmAguarde.Color := pForm.Color;
      // frmAguarde.FForm.AlphaBlend := True;
      // frmAguarde.FForm.AlphaBlendValue := 0;
      // frmAguarde.TransparentColor := True;
      // frmAguarde.TransparentColorValue := clGradientInactiveCaption;
    end;
    frmAguarde.WindowList := DisableTaskWindows(frmAguarde.Handle);
    frmAguarde.panelInfo.Caption := pInfo;
    frmAguarde.Show;
    frmAguarde.Refresh;
    Application.ProcessMessages;
  end;
end;

procedure TfrmAguarde.Fechar;
begin
  if Assigned(frmAguarde) then
  begin
    // Reabilita todos os formulários
    if frmAguarde.FForm <> nil then
    begin
      frmAguarde.FForm.AlphaBlend := False;
    end;

    EnableTaskWindows(frmAguarde.WindowList);
    frmAguarde.Close;
    FreeAndNil(frmAguarde);
  end;
end;

procedure TfrmAguarde.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and (Shift = [ssAlt]) then
  begin
    Key := 0;
  end;
end;

function TfrmAguarde.GetInformacao: String;
begin
  Result := frmAguarde.panelInfo.Caption;
end;

procedure TfrmAguarde.SetInformacao(const Value: String);
begin
  frmAguarde.panelInfo.Caption := Value;
  frmAguarde.Refresh;
  Application.ProcessMessages;
end;

end.
