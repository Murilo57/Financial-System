unit UCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TFrmPesquisaCliente = class(TForm)
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
    gridClientes: TDBGrid;
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
  FrmPesquisaCliente: TFrmPesquisaCliente;

implementation

uses UDM;

{$R *.dfm}

procedure TFrmPesquisaCliente.BtnPesquisaClick(Sender: TObject);
begin
  //Fechando e abrindo o SELECT no DBGrid
  dm.cdsClientes.Close;
  dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE';
  dm.cdsClientes.Open;

  //Op��o de pesquisa por c�digo
  case CBChave.ItemIndex of
    0:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE ID = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisa por nome
    1:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE NOME = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o  de pesquisa por Endereco
    2:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE ENDERECO ='''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisa por CNPJ
    3:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE CNPJ ='''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisa por TELEFONE
    4:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE TELEFONE = '''+MKInicio.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisa por Data de cadastro
    5:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE DATA_CAD = '''+MKInicio.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisar todos os CIDADE
    6:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE CIDADE = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisar por Estado
    7:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE ESTADO = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisar por Sexo
    8:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE SEXO = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisar por Inativo
    9:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE INATIVO = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisar por Estado
    10:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE PESSOAFISICA = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;

    //Op��o de pesquisar por Estado
    11:
    begin
      dm.cdsClientes.Close;
      dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE PESSOAFISICA = '''+EdtDescricao.Text+'''';
      dm.cdsClientes.Open;
    end;
  end;

  LblQtde.Caption := 'Clientes: '+#13+InttoStr(dm.cdsClientes.RecordCount);

  if (EdtDescricao.Text = '') or (MKInicio.Text = '') or (MKFim.Text = '') then
  begin
    Application.MessageBox('Campo est� em branco!', 'Erro', MB_ICONINFORMATION+MB_OK);
    Exit;
    dm.sqlClientes.CommandText := 'SELECT * FROM CLIENTE ORDER BY IDUSUARIO';
    dm.cdsClientes.Open;
  end;

//  '+CboxConsulta.Text+' = '''+EdtConsulta.Text+'''';

end;

procedure TFrmPesquisaCliente.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPesquisaCliente.BtnTransferirClick(Sender: TObject);
begin
  //Faz a variavel receber o registro selecionado
  if dm.cdsClientes.RecordCount > 0 then
  begin
//    Codigo:= dm.cds
  end;


end;

procedure TFrmPesquisaCliente.CBChaveChange(Sender: TObject);
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
    //Pesquisa por Endere�o
    EdtDescricao.Visible := True;
    LblDescricao.Visible := True;
    LblDescricao.Caption := 'Digite O endere�o:';
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;

    3:Begin
    //Pesquisa por cnpj
    EdtDescricao.Visible:= true;
    LblDescricao.Caption := 'Digite o CNPJ:';
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;

   4:Begin
    //Pesquisa por Telefone
    EdtDescricao.Visible:= false;
    LblDescricao.Visible := false;
    LblInicio.Caption := 'Digite o Telefone';
    LblInicio.Visible := true;
    MKinicio.Visible := true;
    LblFim.Visible := false;
    MkFim.Visible := false;
    MKInicio.SetFocus;
    MKInicio.Clear;
   end;

   
    5:begin
    //Pesquisa por Data de cadastro
    EdtDescricao.Visible := false;
    LblDescricao.Visible := true;
    LblDescricao.Caption := 'Digite a data';
    LblInicio.Visible := true;
    LblInicio.Caption := 'Data:';
    MKInicio.Visible := true;
    LblFim.Visible := true;
    MkFim.Visible := true;
    MkInicio.SetFocus;
    MKinicio.Clear;
    MKfim.Clear;
    end;

    6:Begin
    //Pesquisa por CIDADE
    EdtDescricao.Visible:= true;
    LblDescricao.Caption := 'Digite a cidade:';
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;


    7:Begin
    //Pesquisa por Estado
    EdtDescricao.Visible:= true;
    LblDescricao.Caption := 'Digite o Estado:';
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;

    8:Begin
    //Pesquisa por Sexo
    EdtDescricao.Visible:= true;
    LblDescricao.Caption := 'Digite o Sexo (M ou F):';
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    end;

    9:Begin
    //Pesquisa por Inatividade
    EdtDescricao.Visible:= true;
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    DM.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE INATIVO = ''T''';
    DM.cdsClientes.Open;
    end;

    10:Begin
    //Pesquisa por Estado
    EdtDescricao.Visible:= true;
    LblDescricao.Visible:= true;
    LblInicio.Visible := false;
    MKinicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    EdtDescricao.SetFocus;
    EdtDescricao.Clear;
    DM.sqlClientes.CommandText := 'SELECT * FROM CLIENTE WHERE PESSOA FISICA = ''T'''
    end;

    11: Begin
    //Pesquisa por todos os campos
    EdtDescricao.Visible := false;
    LblDescricao.Visible := true;
    LblDescricao.Caption := 'MOSTRANDO TODOS OS CLIENTES';
    LblInicio.Visible := false;
    MkInicio.Visible := false;
    LblFim.Visible := false;
    MkFim.Visible := false;
    DM.sqlMovimento.CommandText := 'SELECT * FROM CLIENTE';
    DM.cdsMovimento.Open;
    end;
  end;
end;

procedure TFrmPesquisaCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

end.
