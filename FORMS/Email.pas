unit Email;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxpngimage, ExtCtrls, StdCtrls, Buttons, IdMessage, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent,IniFiles, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase,  IdSMTP, IdHTTP,
   IdAttachmentFile,IdText ;

type
  TfrmEmail = class(TForm)
    pnlCentro: TPanel;
    edAnexo: TEdit;
    edAssunto: TEdit;
    edDestinatario: TEdit;
    memoMsg: TMemo;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    Panel1: TPanel;
    lblDestinatario: TLabel;
    lblAssunto: TLabel;
    lblMensagem: TLabel;
    lblAnexo: TLabel;
    btnEnviar: TBitBtn;
    btnCancelar: TBitBtn;
    imgEmail: TImage;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmail: TfrmEmail;

implementation
uses UMensagem;
{$R *.dfm}

procedure TfrmEmail.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEmail.btnEnviarClick(Sender: TObject);
var
 LSMTP: TIdSMTP;
 LMessage: TIdMessage;
 LSocketSSL: TIdSSLIOHandlerSocketOpenSSL;
 LArquivoAnexo: String;
begin
  LSMTP    := TIdSMTP.Create(nil);
  LMessage := TIdMessage.Create(nil);
  LSocketSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  //Seguranša
  with LSocketSSL do
  begin
    with SSLOptions do
    begin
      Mode   := sslmClient;
      Method := sslvTLSv1;
    end;
  end;

  //SMTP
  with LSMTP do
  begin
    IOHandler := LSocketSSL;
    Host := 'smtp.gmail.com';
    Port := 587;
    AuthType := atDefault;
    UserName := 'usuar@gmail.com';
    Password := 'senha';
    UseTLS := utUseExplicitTLS;
  end;

  //Mensagem
  with LMessage do
  begin
    From.Address := edDestinatario.Text;
    From.Name := edDestinatario.Text;
    Recipients.Add;
    Recipients.Items[0].Address := edDestinatario.Text;
    Subject := edAssunto.Text;
    Body.Add(memoMsg.Lines.Text);
  end;

  //Arquivos em anexo
  LArquivoAnexo := Trim(edAnexo.Text);
  if LArquivoAnexo <> EmptyStr then
    TIdAttachmentFile.Create( LMessage.MessageParts, LArquivoAnexo);


  try
    LSMTP.Connect;

  if not LSMTP.Connected then
  begin
    ShowMessage('Ocorreu um erro ao tentar se conectar ao servidor SMTP.');
    Exit;
  end;

    LSMTP.Authenticate;
    LSMTP.Send(LMessage);

    msg.Correto('Email enviado','Email enviado com sucesso');
  Except
    on E: Exception do
      msg.Erro('Mensagem de erro','Ocorreu um erro ao enviar o email');
  end;
end;

end.
