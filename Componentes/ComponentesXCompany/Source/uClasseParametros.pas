unit uClasseParametros;

interface
uses
Vcl.ComCtrls, System.Classes, Vcl.Dialogs,
  System.SysUtils,system.generics.collections;
type
 TipoDados = (tpValor,tpLista,tpIntervalo,tpCheck);
  TParametro = class;
  TParametro = class(TComponent)
  private
    FValor: string;
    FPadrao: string;
    FNome: string;
    FValores: String;
    FHint: WideString;
    FTipo: TipoDados;
    fTipoGrupo: string;

 { private declarations }
protected
  { protected declarations }
  public
     constructor  Create(AOwner: TComponent); override;
  published

  { public declarations }

  property Nome:   string read FNome write fNome;
  property Valores: String read FValores write fValores;
  property Padrao: string read FPadrao write fPadrao;
  property Valor:  string read FValor write fValor;
  property Tipo: TipoDados read FTipo write fTipo;
  property Hint: WideString read FHint write fHint;
  property TipoGrupo: string  read fTipoGrupo Write fTipoGrupo;




    { published declarations }
  end;

Funcoes = class
private
  { private declarations }
protected
  { protected declarations }
public
 Class function PegaParent(Node: TTreeNode): String;
 class function PegaPai(Node: TTreeNode): TTreeNode;
 Class function PegaDescricaoCompleta(Node: TTreeNode): String;
 class function LocalizaNO(Tree:  TTreeView; Nome: String): TList<TTreeNode>;
  { public declarations }

published
  { published declarations }
end;
implementation

{ TFuncoes }



class function Funcoes.LocalizaNO(Tree: TTreeView; Nome: String): TList<TTreeNode>;
var
     Node: TTreeNode;
     Re: TList<TTreeNode>;
begin
   Result := nil;
   Re :=    TList<TTreeNode>.Create;
   if Tree.Items.Count = 0 then Exit;
   Node := Tree.Items[0];
   while Node <> nil do
   begin
     if UpperCase(Node.Text).IndexOf( UpperCase(Nome) ) <> -1 then
     begin
         Re.Add( Node);

     end;
     Node := Node.GetNext;
   end;
   Result := Re;
end;
class function Funcoes.PegaDescricaoCompleta(Node: TTreeNode): String;
var
 FVRTreeNode: TTreenode;
 begin
   FVRTreeNode := Node;
   Result := '';
   while Assigned(FVRTreeNode) do begin
       if FVRTreeNode.Level = 0 then Result := FVRTreeNode.Text.Trim + Result else
         Result := '.' + FVRTreeNode.Text + Result;
       FVRTreeNode := FVRTreeNode.Parent;
   end;

 end;
{ TParametro }

class function Funcoes.PegaPai(Node: TTreeNode): TTreeNode;
var
 FVRTreeNode: TTreenode;
 begin
   FVRTreeNode := Node;
   while Assigned(FVRTreeNode) do begin

       if FVRTreeNode.Level = 0 then Result := FVRTreeNode else
         Result :=  FVRTreeNode;
       FVRTreeNode := FVRTreeNode.Parent;
   end;

 end;

class function Funcoes.PegaParent(Node: TTreeNode): String;
var
 FVRTreeNode: TTreenode;
 begin
   FVRTreeNode := Node;
   while Assigned(FVRTreeNode) do begin

       if FVRTreeNode.Level = 0 then Result := FVRTreeNode.Index.ToString + Result else
         Result := '.' + FVRTreeNode.Index.ToString + Result;
       FVRTreeNode := FVRTreeNode.Parent;
   end;

 end;
{ TParametro }

constructor TParametro.Create(AOwner: TComponent);
begin
  inherited;
//  Items := TList<TParametro>.Create;

end;

end.

