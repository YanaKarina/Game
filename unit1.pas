unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TMainScreen }

  TMainScreen = class(TForm)
    Title: TLabel;
    PlayButton: TButton;
    RulesButton: TButton;
    ExitButton: TButton;

    procedure PlayButtonClick(Sender: TObject);

    procedure RulesButtonClick(Sender: TObject);

    procedure ExitButtonClick(Sender: TObject);
  private

  public

  end;

var
  MainScreen: TMainScreen;

implementation
{$R *.lfm}

uses
  unit2, unit3;

{ TMainScreen }

procedure TMainScreen.PlayButtonClick(Sender: TObject);
begin
  GameScreen.Show;
  MainScreen.Hide;
end;

procedure TMainScreen.RulesButtonClick(Sender: TObject);
begin 
  MainScreen.Hide;
  RulesScreen.Show;
end;

procedure TMainScreen.ExitButtonClick(Sender: TObject);
begin
  MainScreen.Close;
end;


end.

