unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Types;

type

  { TGameScreen }

  TGameScreen = class(TForm)
    Ball: TShape;
    CompScoreText: TStaticText;
    UserScoreText: TStaticText;
    UserRacket: TShape;
    CompRacket: TShape;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure ResetForm();
    procedure FormCreate();
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer();
    procedure Timer2Timer();
    procedure UpdateScores();
  private
  procedure shar();

  public

  end;

var
  GameScreen: TGameScreen;
  PosX, PosY, VelX, VelY: single;
  ScoreComp, ScoreUser: Integer;
  MaxScore: Integer;

implementation

{$R *.lfm}

uses
  unit1;

{ TGameScreen }

procedure TGameScreen.ResetForm;
begin
  randomize;
  PosX:=301;   // координаты положения шарика на игровой области
  PosY:=161;
  VelX:=2;  //скорость шарика
  VelY:=3;
  ScoreComp:=0; // Счет компьютера
  ScoreUser:=0; // Счет пользователя
  MaxScore:=5; // Максимальный счет

  UpdateScores;
end;

procedure TGameScreen.FormCreate;
begin
  ResetForm;
  Timer1.Enabled:=True;
  Timer2.Enabled:=True;
end;

procedure TGameScreen.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  UserRacket.Top:=Mouse.CursorPos.Y -GameScreen.ClientOrigin.Y; // присвоили координаты мышки по оси Y
end;

procedure TGameScreen.Timer1Timer;
var UserRect, CompRect: TRect;
begin
     shar;

     if (VelX > 0) and IntersectRect(UserRect, Ball.BoundsRect, UserRacket.BoundsRect) then
     begin
          VelX:=Integer(random(4)-6); // Случайная скорость шарика по оси X в диапазоне от -6 до -2
          VelY:=Integer(random(4)-6); // Случайная скорость шарика по оси Y в диапазоне от -6 до -2
     end;

     if (VelX < 0) and IntersectRect(CompRect, Ball.BoundsRect, CompRacket.BoundsRect) then
     begin
          VelX:=Integer(random(5)+2); // Случайная скорость шарика по оси X в диапазоне от 2 до 6
          VelY:=Integer(random(5)+2); // Случайная скорость шарика по оси Y в диапазоне от 2 до 6
     end;
end;

procedure TGameScreen.Timer2Timer;
begin
  if CompRacket.Top > ClientHeight - CompRacket.Height - 40 then      // чтобы игрок не улетал за границы
     CompRacket.Top:=CompRacket.Top
  else
    begin
      if Ball.Top > CompRacket.Top then            // если шарик ниже чем комп.игрок то мы отпускаем компьютерного игрока вниз
      CompRacket.Top:= Ball.Top+CompRacket.Width;
    end;

  if Ball.Top < CompRacket.Top then             // если шарик выше чем сам игрок, то мы начинаем поднимать игрока вверх
     CompRacket.Top:=Ball.Top - CompRacket.Width;

end;

procedure TGameScreen.UpdateScores;
begin
     UserScoreText.Caption:='Счет игрока: ' + IntToStr(ScoreUser);
     CompScoreText.Caption:='Счет компьютера: ' + IntToStr(ScoreComp);
end;

procedure TGameScreen.shar;
begin
  if ((ScoreComp >= MaxScore) or (ScoreUser >= MaxScore)) then begin
     Timer1.Enabled:=False;
     Timer2.Enabled:=False;

     with TTaskDialog.Create(self) do
          try
            Title:='Игра окончена';
            Caption:='Игра окончена';
            Text:='Повторить попытку?';
            CommonButtons:=[];
            MainIcon:=tdiQuestion;

          with TTaskDialogButtonItem(Buttons.Add) do
               begin
                 Caption:='Повторить';
                 ModalResult:=mrYes;
               end;

          with TTaskDialogButtonItem(Buttons.Add) do
               begin
                 Caption:='Выйти';
                 ModalResult:=mrNo;
               end;

          if Execute then
             begin
               if ModalResult = mrYes then begin
                  FormCreate;
               end;

               if ModalResult = mrNo then begin
                  ResetForm;
                  GameScreen.Hide;
                  MainScreen.Show;

                  exit;
               end;
             end;

          finally
            Free;
          end;
  end;

  PosX:=PosX+VelX;
  PosY:=PosY+VelY;

  if PosX> ClientWidth -Ball.Width then begin    // шарик отпрыгивает от правой стенки
     VelX:=-VelX;
     ScoreComp:=ScoreComp+1;
  end;

  if PosX< 0 then begin // как только шарик координатой стает меньше 0 то он отпрыгивает от левой стенки
     VelX:=-VelX;
     ScoreUser:=ScoreUser+1;
  end;

  UpdateScores;

  if PosY> ClientHeight -Ball.Width then    // шарик отпрыгивает от потолка
     VelY:=-VelY;

  if PosY< 0 then //
     VelY:=-VelY;

  Ball.Left:=round(PosX);
  Ball.Top:=round(PosY);
end;

end.

