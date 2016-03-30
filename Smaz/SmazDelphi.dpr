program SmazDelphi;

uses
  Vcl.Forms,
  uSmaz in 'src\Main\uSmaz.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
