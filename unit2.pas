unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TRulesScreen }

  TRulesScreen = class(TForm)
    Rules: TStaticText;
    Title: TLabel;
    BackButton: TButton;

    procedure BackButtonClick(Sender: TObject);
  private

  public

  end;

var
  RulesScreen: TRulesScreen;

implementation
{$R *.lfm}

uses
  unit1;

{ TRulesScreen }

procedure TRulesScreen.BackButtonClick(Sender: TObject);
begin
  RulesScreen.Hide;
  MainScreen.Show;
end;

end.

