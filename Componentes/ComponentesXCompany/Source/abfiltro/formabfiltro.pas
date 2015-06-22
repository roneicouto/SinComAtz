unit FormABFiltro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TFrmABFiltro = class(TForm)
    Rb_Ou: TRadioButton;
    Rb_E: TRadioButton;
    Label6: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BtnOk: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    gbxCriterio2: TGroupBox;
    cbOperador2: TComboBox;
    gbxCriterio1: TGroupBox;
    cbOperador1: TComboBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Valor1: TEdit;
    GroupBox5: TGroupBox;
    Valor2: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Valor1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmABFiltro: TFrmABFiltro;

implementation

{$R *.DFM}

procedure TFrmABFiltro.FormShow(Sender: TObject);
begin
   cbOperador1.ItemIndex := 0;
end;

procedure TFrmABFiltro.Valor1Change(Sender: TObject);
begin
   BtnOk.Enabled := Valor1.Text <> '';
end;

end.
