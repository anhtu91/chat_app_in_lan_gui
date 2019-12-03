unit Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    edtPort: TEdit;
    btnOpenPort: TButton;
    listOnlineUser: TListBox;
    Label2: TLabel;
    mmChat: TMemo;
    btnSend: TButton;
    mmChatBox: TMemo;
    ServerSocket1: TServerSocket;
    Label3: TLabel;
    mmStatus: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnOpenPortClick(Sender: TObject);
    procedure ServerSocketAccept(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnSendClick(Sender: TObject);
    procedure ServerSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnOpenPortClick(Sender: TObject);
var
  port : Integer;
begin
  ServerSocket1.Active := False;
  port := StrToInt(edtPort.Text);
  ServerSocket1.Port := port;
  ServerSocket1.Active := True;
  ShowMessage('Listening...');
end;

procedure TForm1.btnSendClick(Sender: TObject);
var
  I: Integer;
begin
   for I := 0 to ServerSocket1.Socket.ActiveConnections-1 do
   begin
      ServerSocket1.Socket.Connections[I].SendText(mmChat.Text);
   end;

   mmChatBox.Lines.Add('Me: '+mmChat.Text);
   mmChat.Text := '';
end;

procedure TForm1.ServerSocketAccept(Sender: TObject; Socket: TCustomWinSocket);
begin
  mmStatus.Lines.Add('New user login '+Socket.LocalHost+' in IP address '+Socket.LocalAddress+' using port '+IntToStr(Socket.LocalPort));
  mmStatus.Lines.Add('');
end;

procedure TForm1.ServerSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  mmChatBox.Lines.Add(Socket.RemoteHost+ ' : '+Socket.ReceiveText);
end;

end.
