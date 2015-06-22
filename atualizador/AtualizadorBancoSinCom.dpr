program AtualizadorBancoSinCom;

uses
  Vcl.Forms,
  uFrmAguarde in 'uFrmAguarde.pas' {frmAguarde},
  uFrmAtualizador in 'uFrmAtualizador.pas' {frmAtualizador},
  uClasseFuncoes in 'uClasseFuncoes.pas',
  uClasseXQuery in 'uClasseXQuery.pas',
  uConexaoBanco in 'uConexaoBanco.pas',
  uFrmConfiguraAcessoBD in '..\Forms\uFrmConfiguraAcessoBD.pas' {FrmConfigAcessoBD},
  uDmImagens in '..\Modules\uDmImagens.pas' {DmImagens: TDataModule},
  uDmAtualizador in 'uDmAtualizador.pas' {dmAtualizador: TDataModule},
  uFrmMensagensMultiplas in '..\Forms\uFrmMensagensMultiplas.pas' {frmMensagensMultiplas},
  uFrmMensagem in '..\Forms\uFrmMensagem.pas' {FrmMensagem},
  uFrmMensagemPersonalizada in '..\Forms\uFrmMensagemPersonalizada.pas' {FrmMensagemPersonalizada},
  uFrmPerguntaBotoesConf in '..\Forms\uFrmPerguntaBotoesConf.pas' {FrmPerguntaBotoesConf},
  uFrmRelatorioAtualizacao in 'uFrmRelatorioAtualizacao.pas' {frmRelatorioAtualizacao},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TfrmAtualizador, frmAtualizador);
  Application.CreateForm(TDmImagens, DmImagens);
  Application.CreateForm(TFrmMensagem, FrmMensagem);
  Application.CreateForm(TdmAtualizador, dmAtualizador);
  Application.CreateForm(TfrmRelatorioAtualizacao, frmRelatorioAtualizacao);
  Application.Run;

end.
