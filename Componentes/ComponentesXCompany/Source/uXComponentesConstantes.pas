unit uXComponentesConstantes;

interface

uses Graphics;

const
  TamanhoBotoes=118;
  AlturaBotoes=30;
//  TamanhoEdit=100;
//  AlturaEdit=21;
  CorFoco=$00CCF2FC;
  CorReadOnly=clBtnFace;
  FONT_TAM   = 8;
  FONT_COLOR = clWindowText;
  FONT_NOME  = 'Tahoma';

  (* Caption dos Botões *)
  CaptionBotaoNovo='Novo <Ins>';
  CaptionBotaoExcluir='Excluir <Del>';
  CaptionBotaoEditar='Alterar <Enter>';
  CaptionBotaoDesfazer='Desfaz <Esc>';
  CaptionBotaoGravar='Gravar <Ctrl+S>';
  CaptionBotaoCancelar='Cancelar';
  CaptionBotaoConsultar='Consultar';
  CaptionBotaoSair='Sair <Esc>';
  CaptionBotaoImprimir='Imprimir <Ctrl+P>';

  (* HINT dos Botões *)
  HintBotaoNovo='Incluir registro <INS>';
  HintBotaoExcluir='Apagar registro atual <Del>';
  HintBotaoEditar='Alterar registro atual <Enter>';
  HintBotaoDesfazer='Desfaz edição/inclusão do registro atual <Esc>';
  HintBotaoGravar='Gravar edição/inclusão do registro atual <Ctrl+S>';
  HintBotaoImprimir='Imprimir <Ctrl+P>';

  (* Máscacas *)
  MascaraQuantidade='0.000';
  MascaraValores=',0.000';

implementation


end.
