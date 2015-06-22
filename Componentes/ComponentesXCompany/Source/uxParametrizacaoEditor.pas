unit uxParametrizacaoEditor;

interface
uses DesignIntf, DesignEditors, uxParametrizacao;
type
TComponentEdit = class(TComponentEditor)
public
function GetVerbCount: Integer; override;
function GetVerb(Index: Integer): String; override;
procedure ExecuteVerb(Index: Integer); override;
procedure Edit; override;
end;

procedure register;
implementation

uses
  Vcl.Dialogs;

{ TComponentEdit }

procedure Register;
begin
RegisterComponentEditor(TXParametrizacao, TComponentEdit);
end;


procedure TComponentEdit.Edit;
begin

  inherited;

    ExecuteVerb(1);
end;

procedure TComponentEdit.ExecuteVerb(Index: Integer);
begin

  inherited;
  if Index = 1 then
  begin

 with Component as TXParametrizacao do
     Execute;

  end;

end;

function TComponentEdit.GetVerb(Index: Integer): String;
begin
   case Index of
0: Result:= 'Sobre';
1: Result:= 'Editar Parametros';

end;

end;

function TComponentEdit.GetVerbCount: Integer;
begin
  Result := 2;
end;

end.
