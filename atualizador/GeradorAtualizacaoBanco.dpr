program GeradorAtualizacaoBanco;

uses
  Vcl.Forms,
  uFrmGerador in 'uFrmGerador.pas' {frmGerador},
  uFrmAguarde in 'uFrmAguarde.pas' {frmAguarde},
  uDmAtualizador in 'uDmAtualizador.pas' {dmAtualizador: TDataModule},
  uConexaoBanco in 'uConexaoBanco.pas',
  uFrmConfiguraAcessoBD in '..\Forms\uFrmConfiguraAcessoBD.pas' {FrmConfigAcessoBD},
  uDmImagens in '..\Modules\uDmImagens.pas' {DmImagens: TDataModule},
  uClasseFuncoes in 'uClasseFuncoes.pas',
  uFrmMensagensMultiplas in '..\Forms\uFrmMensagensMultiplas.pas' {frmMensagensMultiplas},
  uFrmMensagem in '..\Forms\uFrmMensagem.pas' {FrmMensagem},
  uFrmMensagemPersonalizada in '..\Forms\uFrmMensagemPersonalizada.pas' {FrmMensagemPersonalizada},
  uFrmPerguntaBotoesConf in '..\Forms\uFrmPerguntaBotoesConf.pas' {FrmPerguntaBotoesConf},
  uClasseXQuery in 'uClasseXQuery.pas',
  uClasseExportar in 'uClasseExportar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
   Application.CreateForm(TDmImagens, DmImagens);
  Application.CreateForm(TdmAtualizador, dmAtualizador);
  Application.CreateForm(TfrmGerador, frmGerador);
  Application.CreateForm(TFrmMensagem, FrmMensagem);
  Application.CreateForm(TFrmMensagemPersonalizada, FrmMensagemPersonalizada);
  Application.CreateForm(TFrmPerguntaBotoesConf, FrmPerguntaBotoesConf);
  Application.Run;
end.
