program ChatClient;

uses
  Vcl.Forms,
  login in 'login.pas' {loginForm},
  chatWindow in 'chatWindow.pas' {chatForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TloginForm, loginForm);
  Application.CreateForm(TchatForm, chatForm);
  Application.Run;
end.
