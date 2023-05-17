unit UUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TFrmPesquisaUsuario = class(TForm)
    PnlTopo: TPanel;
    LblChave: TLabel;
    LblDescricao: TLabel;
    LblInicio: TLabel;
    LblFim: TLabel;
    BtnTransferir: TBitBtn;
    BtnPesquisa: TBitBtn;
    BtnImprimir: TBitBtn;
    EdtDescricao: TEdit;
    MKInicio: TMaskEdit;
    MKFim: TMaskEdit;
    CBChave: TComboBox;
    PnlRodape: TPanel;
    LblQtde: TLabel;
    BtnSair: TBitBtn;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtnTransferirClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure CBChaveChange(Sender: TObject);
    procedure BtnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
  { Public declarations }
  Codigo:Integer;
  end;

var
  FrmPesquisaUsuario: TFrmPesquisaUsuario;

implementation

uses UDM;

{$R *.dfm}

procedure TFrmPesquisaUsuario.BtnPesquisaClick(Sender: TObject);
begin
  //Fechando e abrindo o SELECT no DBGrid
  dm.cdsUsuario.Close;
  dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO';
  dm.cdsUsuario.Open;

  //Op��o de pesquisa por c�digo
  case CBChave.ItemIndex of
    0:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO WHERE IDUSUARIO = '''+EdtDescricao.Text+'''';
      dm.cdsUsuario.Open;
    end;

    //Op��o de pesquisa por nome
    1:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO WHERE NOME = '''+EdtDescricao.Text+'''';
      dm.cdsUsuario.Open;
    end;

    //Op��o  de pesquisa por senha
    2:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO WHERE SENHA ='''+EdtDescricao.Text+'''';
      dm.cdsUsuario.Open;
    end;

    //Op��o de pesquisa por tipo
    3:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO WHERE TIPO ='''+EdtDescricao.Text+'''';
      dm.cdsUsuario.Open;
    end;

    //Op��o de pesquisa por cadastro
    4:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO WHERE CADASTRO = '''+MKInicio.Text+'''';
      dm.cdsUsuario.Open;
    end;

    //Op��o de pesquisa por periodo
    5:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO WHERE CADASTRO BETWEEN '''+MKInicio.Text+''' AND '''+MKFim.Text+'''';
      dm.cdsUsuario.Open;
    end;

    //Op��o de pesquisar todos os usuarios
    6:
    begin
      dm.cdsUsuario.Close;
      dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO';
      dm.cdsUsuario.Open;
    end;
  end;

  LblQtde.Caption := 'Usuarios: '+#13+InttoStr(dm.cdsUsuario.RecordCount);

  if (EdtDescricao.Text = '') or (MKInicio.Text = '') or (MKFim.Text = '') then
  begin
    Application.MessageBox('Campo est� em branco!', 'Erro', MB_ICONINFORMATION+MB_OK);
    Exit;
    dm.sqlUsuario.CommandText := 'SELECT * FROM USUARIO ORDER BY IDUSUARIO';
    dm.cdsUsuario.Open;
  end;

//  '+CboxConsulta.Text+' = '''+EdtConsulta.Text+'''';

end;

procedure TFrmPesquisaUsuario.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPesquisaUsuario.BtnTransferirClick(Sender: TObject);
begin
  //Faz a variavel receber o registro selecionado
  if dm.cdsUsuario.RecordCount > 0 then
  begin
    Codigo:= dm.cdsUsuarioIDUSUARIO.AsInteger;
  end;


end;

procedure TFrmPesquisaUsuario.CBChaveChange(Sender: TObject);
begin
  //Habilita e desabilita componentes
  case CBChave.ItemIndex of
  0:Begin
    //Pesquisa por c�digo
    EdtDescricao.Visible:= true;
    LblDescricao.Caption := 'Digite o c�digo';
    LblDescricao.Visible := true;
    LblInicio.Visible := false;
    MKInicio.Visible := false;
    LblFim.Visible := False;
    MKFim.Visible := False;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
  end;

    1:begin
    //Pesquisa Por Nome
    EdtDescricao.Visible := True;
    LblDescricao.Caption := 'Digite o nome';
    LblDescricao.Visible := True;
    LblInicio.Visible := false;
    LblFim.Visible := false;
    MKInicio.Visible := false;
    MKFIM.Visible := false;
    EdtDescricao.SetFocus;
    end;


    2:Begin
    //Pesquisa por SENHA
    EdtDescricao.Visible := True;
    LblDescricao.Visible := True;
    LblDescricao.Caption := 'Digite a Senha:';
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;

    3:Begin
    //Pesquisa por TIPO
    EdtDescricao.Visible:= true;
    LblDescricao.Caption := 'Digite o tipo:';
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;

   4:Begin
    //Pesquisa por data de cadastro
    EdtDescricao.Visible:= false;
    LblDescricao.Visible := false;
    LblInicio.Caption := 'Digite a data';
    LblInicio.Visible := true;
    MKinicio.Visible := true;
    LblFim.Visible := false;
    MkFim.Visible := false;
    MKInicio.SetFocus;
    MKInicio.Clear;
   end;

    5:begin
    //Pesquisa por periodo, entre inicio e fim
    EdtDescricao.Visible := false;
    LblDescricao.Visible := true;
    LblDescricao.Caption := 'DIGITE O PERIODO';
    LblInicio.Visible := true;
    LblInicio.Caption := 'Inicio:';
    MKInicio.Visible := true;
    LblFim.Visible := true;
    LblFim.Caption := 'Fim:';
    MkFim.Visible := true;
    MkInicio.SetFocus;
    MKinicio.Clear;
    MKfim.Clear;
    end;


    6: Begin
    //Pesquisa por todos os campos
    EdtDescricao.Visible := false;
    LblDescricao.Visible := true;
    LblDescricao.Caption := 'MOSTRANDO TODOS OS USUARIOS';
    LblInicio.Visible := false;
    MkInicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    DM.sqlMovimento.CommandText := 'SELECT * FROM MOVIMENTO';
    DM.cdsMovimento.Open;
    end;
  end;
end;

procedure TFrmPesquisaUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.
