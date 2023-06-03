program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  Unit1,
  Unit2,
  Unit3;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainScreen, MainScreen);
  Application.CreateForm(TRulesScreen, RulesScreen);
  Application.CreateForm(TGameScreen, GameScreen);
  Application.Run;
end.

