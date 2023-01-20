unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, uDM, uPesqProduto,
  Vcl.DBCtrls, Data.DB;

type
  TfrmCadProduto = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    btnNovo: TToolButton;
    ToolButton2: TToolButton;
    btnEditar: TToolButton;
    ToolButton4: TToolButton;
    btnSalvar: TToolButton;
    ToolButton17: TToolButton;
    btnExcluir: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    btnSair: TToolButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    btnPesquisar: TButton;
    Edit4: TEdit;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Label2: TLabel;
    Edit5: TEdit;
    Label3: TLabel;
    dsUnidade: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    ActionList1: TActionList;
    Novo: TAction;
    Editar: TAction;
    Salvar: TAction;
    Excluir: TAction;
    Cancelar: TAction;
    Sair: TAction;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SalvarExecute(Sender: TObject);
    procedure ExcluirExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure habilitarEdicao (verdade : boolean);
  end;

var
  frmCadProduto: TfrmCadProduto;
  editGrav : boolean;

implementation

{$R *.dfm}

procedure TfrmCadProduto.btnCancelarClick(Sender: TObject);
begin
  btnNovo.Enabled := True;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := True;

  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Text := ' ';
  Edit5.Text := ' ';
  DBLookupComboBox1.KeyValue := -1;

  habilitarEdicao(false);
end;

procedure TfrmCadProduto.btnEditarClick(Sender: TObject);
begin
  editGrav := false;

  habilitarEdicao(true);
  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := False;

  habilitarEdicao(true);

  Edit2.SetFocus;
end;

procedure TfrmCadProduto.btnExcluirClick(Sender: TObject);
begin
 if Application.MessageBox('Tem certeza que deseja excluir o produto selecionado?',
   'Confirmação', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    btnNovo.Enabled := True;
    btnEditar.Enabled := False;
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnCancelar.Enabled := False;
    btnSair.Enabled := True;
    btnPesquisar.Enabled := True;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('delete from produto where proCodigo = '+Edit1.Text);
    frmDM.Consultas.ExecSQL;

    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit4.Text := ' ';
    Edit5.Text := ' ';
    DBLookupComboBox1.ListFieldIndex := -1;

    frmDM.tabProduto.Close;
    frmDM.tabProduto.Open;
  end
  else
  abort
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  editGrav := true;

  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := False;

  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Text := ' ';
  Edit5.Text := ' ';
  DBLookupComboBox1.KeyValue := -1;

  habilitarEdicao(true);

  Edit2.SetFocus;
end;

procedure TfrmCadProduto.btnPesquisarClick(Sender: TObject);
begin
  pesqProd := 1;

  frmPesqProduto := TfrmPesqProduto.Create(Application);
  frmPesqProduto.ShowModal;
  frmPesqProduto.Release;
end;

procedure TfrmCadProduto.btnSairClick(Sender: TObject);
begin
  frmCadProduto.Close;
end;

procedure TfrmCadProduto.btnSalvarClick(Sender: TObject);
var temp:string;
begin
  temp := '';
  btnNovo.Enabled := True;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := True;

  habilitarEdicao(false);

  if editGrav = true then
  begin
    temp := StringReplace(Edit3.Text, ',', '.', [rfReplaceAll]);
    frmDM.Consultas.Close;
    frmDM.Consultas.Sql.Clear;
    frmDM.Consultas.SQL.Add('insert into produto (proDescricao, proPVenda, proEstMinimo, recAssociada, pro_undCodigo)'
    + ' values ('+ QuotedStr(Edit2.Text)+', '+QuotedStr(temp)+', '+
    QuotedStr(Edit5.Text)+', false, '+QuotedStr(DBLookupComboBox1.KeyValue)+')');
    frmDM.Consultas.ExecSQL;

    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select MAX(proCodigo) from Produto');
    frmDM.Consultas.Open;
    Edit1.Text := frmDM.Consultas.FieldByName('MAX(proCodigo)').AsString;
  end

  else

  begin
    temp := StringReplace(Edit3.Text, ',', '.', [rfReplaceAll]);
    frmDM.Consultas.Close;
    frmDM.Consultas.Sql.Clear;
    frmDM.Consultas.SQL.Add('update produto set proDescricao = '+QuotedStr(Edit2.text)+','
                       + ' proPVenda = '+QuotedStr(temp)+','
                       + 'proEstMinimo = '+QuotedStr(Edit5.Text)+','
                       + 'pro_undCodigo = '+QuotedStr(DBLookupComboBox1.KeyValue)
                       + ' where proCodigo = '+Edit1.text);
    frmDM.Consultas.ExecSQL;
  end;
  frmDM.tabProduto.Close;
  frmDM.tabProduto.Open;
end;

procedure TfrmCadProduto.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(Sender);
end;

procedure TfrmCadProduto.EditarExecute(Sender: TObject);
begin
  btnEditarClick(sender);
end;

procedure TfrmCadProduto.ExcluirExecute(Sender: TObject);
begin
  btnExcluirClick(sender);
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabProduto.Close;
  frmDM.tabUnidade.Close;
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  frmDM.tabProduto.Open;
  frmDM.tabUnidade.Open;
end;

procedure TfrmCadProduto.habilitarEdicao(verdade : boolean);
  begin
    edit2.Enabled := verdade;
    edit3.Enabled := verdade;
    edit5.Enabled := verdade;
    DBLookupComboBox1.Enabled := verdade;
  end;


procedure TfrmCadProduto.NovoExecute(Sender: TObject);
begin
  btnNovoClick(sender);
end;

procedure TfrmCadProduto.SairExecute(Sender: TObject);
begin
btnSairClick(sender);
end;

procedure TfrmCadProduto.SalvarExecute(Sender: TObject);
begin
  btnSalvarClick(sender);
end;

end.
