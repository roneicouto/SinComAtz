unit FormAbFiltroSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TFrmABFiltroSQl = class(TForm)
    cbOperador1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Rb_Ou: TRadioButton;
    Rb_E: TRadioButton;
    CbOperador2: TComboBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Valor1: TEdit;
    Valor2: TEdit;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label1: TLabel;
    Label7: TLabel;
    BtnOK: TBitBtn;
    BtnCancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure Valor1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmABFiltroSQl: TFrmABFiltroSQL;

implementation

{$R *.DFM}

procedure TFrmABFiltroSQl.FormShow(Sender: TObject);
begin
   cbOperador1.ItemIndex := 0;
end;

procedure TFrmABFiltroSQl.Valor1Change(Sender: TObject);
begin
   BtnOk.Enabled := Valor1.Text <> '';
end;

end.
