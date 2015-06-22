unit uXCompanyBotoes;

interface

uses
  Forms, Vcl.Graphics, WinApi.Windows, uXComponentesConstantes, System.Classes, System.SysUtils, Vcl.Controls, RzButton;

Type
  TTipoBotao = (tpNenhum, tpBtnNovo, tpBtnGravar, tpBtnDesfazer, tpBtnEditar,
    tpBtnExcluir, tpBtnImprimir, tpBtnSair, tpBtnConsultar, tpBtnCancelar,
    tpBtnAbrir, tpBtnOK);

  TxBtnBase = class(TRzBitBtn)
  private

  protected

  public
    constructor Create(AOwner: TComponent); override;

  published

  end;

  { xBtnCoringa }
  TxBtnCoringa = class(TxBtnBase)
  private
    FAparenciaPadrao: Boolean;
    FTipoBotao: TTipoBotao;
    FPadrao: boolean;
    FWidthBotaoPequeno: Integer;
    procedure SetAparenciaPadrao(const Value: Boolean);
    procedure SetTipoBotao(const Value: TTipoBotao);
    procedure SetPadrao(const Value: boolean);
    procedure SetWidthBotaoPequeno(const Value: Integer);

  protected

  public
    constructor Create(AOwner: TComponent); override;

  published

    property AparenciaBotao: TTipoBotao read FTipoBotao write SetTipoBotao;
    Property WidthBotaoPequeno: Integer read FWidthBotaoPequeno write SetWidthBotaoPequeno;

    property AparenciaPadrao:Boolean read FAparenciaPadrao write SetAparenciaPadrao default false;
    property Padrao: boolean read FPadrao write SetPadrao default True;
    property Width ;
    property Height ;
    property ShowHint;
  end;

procedure Register;

implementation

{$R Icones16.res }

uses uClasseDefinePadrao, Vcl.Dialogs;

procedure Register;
begin
  RegisterComponents('xComponentes', [TxBtnCoringa]);
end;

{ TxBtnBase }

constructor TxBtnBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

(* xBtnCoringa *)
constructor TxBtnCoringa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if (csDesigning in ComponentState) then
  begin
    TDefinePadrao.SetaPadrao(self, True);
  end;
end;

procedure TxBtnCoringa.SetAparenciaPadrao(const Value: Boolean);
begin
  FAparenciaPadrao := Value;
  if Value then
  begin
    SetTipoBotao(FTipoBotao);
  end;
end;

procedure TxBtnCoringa.SetPadrao(const Value: boolean);
begin
  FPadrao := Value;
  TDefinePadrao.SetaPadrao(self, Value);
end;

procedure TxBtnCoringa.SetTipoBotao(const Value: TTipoBotao);
begin
  if (csLoading in ComponentState) then
  begin
    exit;
  end;

  FTipoBotao := Value;
  if FAparenciaPadrao then
  begin
    case FTipoBotao of

      tpNenhum:
        begin
          Glyph.FreeImage;
          Hint := '';
        end;

      tpBtnNovo:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'NOVO');
          Caption := CaptionBotaoNovo;
          Hint := HintBotaoNovo;
        end;

      tpBtnEditar:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'EDITAR');
          Caption := CaptionBotaoEditar;
          Hint := HintBotaoEditar;
        end;

      tpBtnGravar:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'SALVAR');
          Caption := CaptionBotaoGravar;
          Hint := HintBotaoGravar;
        end;

      tpBtnDesfazer:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'DESFAZER');
          Caption := CaptionBotaoDesfazer;
          Hint := HintBotaoDesfazer;
        end;

      tpBtnExcluir:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'EXCLUIR');
          Caption := CaptionBotaoExcluir;
          Hint := HintBotaoExcluir;
        end;

      tpBtnImprimir:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'IMPRESSORA');
          Caption := CaptionBotaoImprimir;
          Hint := HintBotaoImprimir;
        end;

      tpBtnConsultar:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'CONSULTAR');
          Caption := CaptionBotaoConsultar;
        end;

      tpBtnCancelar:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'CANCELAR');
          Caption := CaptionBotaoCancelar;
        end;

      tpBtnAbrir:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'ABRIR');
          Caption := 'Abrir';
        end;

      tpBtnOK:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'OK');
          Caption := 'OK';
        end;

      tpBtnSair:
        begin
          Glyph.Handle := LoadBitmap(hinstance, 'SAIR');
          Caption := CaptionBotaoSair;
        end;
    end;
  end;
end;

procedure TxBtnCoringa.SetWidthBotaoPequeno(const Value: Integer);
begin
  FWidthBotaoPequeno := Value;
end;


end.
