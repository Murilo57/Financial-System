unit UCadMovimentacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask;

type
  TFrmMovimento = class(TForm)
    PnlTopo: TPanel;
    PnlRodape: TPanel;
    BtnAtualizar: TBitBtn;
    BtnCancelar: TBitBtn;
    BtnGravar: TBitBtn;
    BtnDeletar: TBitBtn;
    BtnEditar: TBitBtn;
    BtnNovo: TBitBtn;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBTipo: TDBComboBox;
    BtnSair: TBitBtn;
    BtnPesquisar: TBitBtn;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure tratabotao();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMovimento: TFrmMovimento;

implementation

uses UDM, UMenu, UMovimentacao;

{$R *.dfm}

procedure TFrmMovimento.BtnAtualizarClick(Sender: TObject);
begin
  Tratabotao();
  DM.cdsMovimento.Refresh;
  MessageDlg('Atualizado com sucesso!', MTINFORMATION, [MBOK],0);
end;

procedure TFrmMovimento.BtnCancelarClick(Sender: TObject);
begin
  Tratabotao();
  DM.cdsMovimento.Cancel;
  dm.cdsMovimento.CancelUpdates;
  MessageDlg('A��o cancelada com sucesso', MTINFORMATION, [MBOK], 0);
end;

procedure TFrmMovimento.BtnDeletarClick(Sender: TObject);
begin
  Tratabotao();
  if MessageDlg('Deseja deletar esse registro?', MtConfirmation, [mbOk,MbNo], 0) =mrOk then
    begin
      dm.cdsMovimento.delete;
      Tratabotao();
    end
    else
     Tratabotao();
     abort;
end;

procedure TFrmMovimento.BtnEditarClick(Sender: TObject);
begin
  Tratabotao();
  if MessageDlg('Deseja alterar esse registro?', MtConfirmation, [mbOk,MbNo], 0) =mrOk then
   begin
     dm.cdsMovimento.Edit;
   end
   else
    Tratabotao();
    abort;
end;

procedure TFrmMovimento.BtnGravarClick(Sender: TObject);
begin
  Tratabotao();
  dm.cdsMovimento.Post;
  MessageDlg('Registro salvo com sucesso!', MtInformation, [mbOk], 0);
  dm.cdsMovimento.ApplyUpdates(0);
end;

procedure TFrmMovimento.BtnNovoClick(Sender: TObject);
var proximo: Integer;
begin

  Tratabotao();
  dm.cdsMovimento.Open;   //Abre a tabela
  dm.cdsMovimento.Last;   // Vai para o ultimo registro da tabela
  proximo:= dm.cdsMovimentoIDMOVIMENTO.AsInteger + 1;   //Recebe o valor do ultimo registro e vai para o proximo '+1'
  dm.cdsMovimento.Append;  //Adiciona mais uma coluna em branco para adionar um novo registro
  dm.cdsMovimentoIDMOVIMENTO.AsInteger := proximo;   //O campo ID recebe o valor da variavel proximo
  DBEdit3.SetFocus;   //Leva o foco para o DBEdit3
  dm.cdsMovimentoCADASTRO.AsDateTime:=Date;  //O campo CADASTRO recebe a data atualizada
  dm.cdsMovimentoUSUARIO.AsString := dm.Usuario;
end;

procedure TFrmMovimento.BtnPesquisarClick(Sender: TObject);
begin
  FrmPesquisaMovimento:= TFrmPesquisaMovimento.Create(self);
  FrmPesquisaMovimento.showModal;
  try
    //Recebe os dados da consulta
    if FrmPesquisaMovimento.Codigo > 0 then
    begin
      dm.cdsMovimento.Open();
      dm.cdsMovimento.Locate('IDMOVIMENTO', FrmPesquisaMovimento.Codigo,[]);
    end;

  finally    // vai executar dando erro ou n�o
  FrmPesquisaMovimento:=nil;
  FrmPesquisaMovimento.free;
  end;
end;

procedure TFrmMovimento.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMovimento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TFrmMovimento.tratabotao;
begin
// Ativa e desativa bot�es
  BtnNovo.Enabled:= Not BtnNovo.Enabled;
  BtnEditar.Enabled := Not BtnEditar.Enabled;
  BtnDeletar.Enabled:= Not BtnDeletar.Enabled;
  BtnGravar.Enabled := Not BtnGravar.Enabled;
  BtnAtualizar.Enabled := Not BtnAtualizar.Enabled;
end;

end.
