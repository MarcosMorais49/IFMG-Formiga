unit uCadFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ImgList, uDm, uPesqFornecedor;

type
  TfrmCadFornecedor = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    btnPesquisar: TButton;
    ComboBox1: TComboBox;
    Label11: TLabel;
    Edit6: TEdit;
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
    ImageList2: TImageList;
    ImageList1: TImageList;
    ActionList1: TActionList;
    Novo: TAction;
    Editar: TAction;
    Salvar: TAction;
    Excluir: TAction;
    Cancelar: TAction;
    Sair: TAction;
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SalvarExecute(Sender: TObject);
    procedure ExcluirExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure habilitarEdicao(verdade : boolean);
  end;

var
  frmCadFornecedor: TfrmCadFornecedor;
  editGrav : boolean;
  pesqForn : integer;

implementation

{$R *.dfm}

procedure TfrmCadFornecedor.btnCancelarClick(Sender: TObject);
begin
  habilitarEdicao(false);

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
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  ComboBox1.ItemIndex := -1;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  MaskEdit4.Clear;
end;

procedure TfrmCadFornecedor.btnEditarClick(Sender: TObject);
begin
  habilitarEdicao(true);

  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := False;

  editGrav := false;

  Edit2.SetFocus;
end;

procedure TfrmCadFornecedor.btnExcluirClick(Sender: TObject);
begin
if Application.MessageBox('Tem certeza que deseja excluir o fornecedor selecionado?',
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
    frmDM.Consultas.SQL.Add('delete from fornecedor where forCodigo = '+Edit1.Text);
    frmDM.Consultas.ExecSQL;


    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit4.Clear;
    Edit5.Clear;
    Edit6.Clear;
    ComboBox1.ItemIndex := -1;
    MaskEdit1.Clear;
    MaskEdit2.Clear;
    MaskEdit3.Clear;
    MaskEdit4.Clear;

    frmDM.tabFornecedor.Close;
    frmDM.tabFornecedor.Open;
  end
  else
    abort
end;

procedure TfrmCadFornecedor.btnNovoClick(Sender: TObject);
begin
  habilitarEdicao(true);

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
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  ComboBox1.ItemIndex := -1;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  MaskEdit4.Clear;

  editGrav := True;

  Edit2.SetFocus;
end;

procedure TfrmCadFornecedor.btnPesquisarClick(Sender: TObject);
begin
  pesqForn := 1; // Variavel controla que unit solicitou os dados (cad Forn ou recebimento/pesq Forn)

  frmPesqFornecedor := TfrmPesqFornecedor.Create(Application);
  frmPesqFornecedor.ShowModal;
  frmPesqFornecedor.Release;
end;

procedure TfrmCadFornecedor.btnSairClick(Sender: TObject);
begin
    frmCadFornecedor.Close
end;

procedure TfrmCadFornecedor.btnSalvarClick(Sender: TObject);
begin
  habilitarEdicao(false);

  btnNovo.Enabled := True;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := True;

  if editGrav = true then //Botao Novo
  begin
     frmDM.Consultas.Close;
     frmDM.Consultas.Sql.Clear;
     frmDM.Consultas.SQL.Add('insert into fornecedor (forNome, forCnpj, forInscEstadual, forEndereco,'
     +' forBairro, forCidade, forEstado, forTelefone, forCep, forEmail)'
     + ' values ('+QuotedStr(Edit2.Text)+', '+QuotedStr(MaskEdit1.Text)+', '+QuotedStr(MaskEdit2.Text)+', '
     +QuotedStr(Edit3.Text)+', '+QuotedStr(Edit4.Text)+', '+QuotedStr(Edit5.Text)+', '
     +QuotedStr(ComboBox1.Text)+', '+QuotedStr(MaskEdit4.Text)+', '+QuotedStr(MaskEdit3.Text)+', '
     +QuotedStr(Edit6.Text)+')');
     frmDM.Consultas.ExecSQL;
  end

  else
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.Sql.Clear;
    frmDM.Consultas.SQL.Add('update fornecedor set forNome = '+QuotedStr(Edit2.text)+','
                      + ' forCnpj = '+QuotedStr(MaskEdit1.text)+', forInscEstadual = '+QuotedStr(MaskEdit2.text)+','
                      + ' forEndereco = '+QuotedStr(Edit3.text)+', forBairro = '+QuotedStr(Edit4.text)+','
                      + ' forCidade = '+QuotedStr(Edit5.text)+', forEstado = '+QuotedStr(combobox1.text)+','
                      + ' forCep = '+QuotedStr(MaskEdit3.text)+', forTelefone = '+QuotedStr(MaskEdit4.text)+', '
                      + ' forEmail = '+QuotedStr(Edit6.text)
                      + ' where forCodigo = '+Edit1.text);
    frmDM.Consultas.ExecSQL;
  end;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select forCodigo from fornecedor where forCnpj = '
  +QuotedStr(MaskEdit1.Text)+' and forInscEstadual = '+QuotedStr(MaskEdit2.Text));
  frmDM.Consultas.Open;
  Edit1.Text := frmDM.Consultas.FieldByName('forCodigo').AsString;

  frmDM.tabFornecedor.Close;
  frmDM.tabFornecedor.Open;
end;

procedure TfrmCadFornecedor.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmCadFornecedor.EditarExecute(Sender: TObject);
begin
btnEditarClick(sender);
end;

procedure TfrmCadFornecedor.ExcluirExecute(Sender: TObject);
begin
  btnExcluirClick(sender);
end;

procedure TfrmCadFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frmDM.tabFornecedor.close;
end;

procedure TfrmCadFornecedor.FormCreate(Sender: TObject);
begin
  frmDM.tabFornecedor.Open;

  btnNovo.Enabled := True;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := True;
end;

procedure TfrmCadFornecedor.habilitarEdicao(verdade : boolean);
  begin
    edit1.Enabled := verdade;
    edit2.Enabled := verdade;
    edit3.Enabled := verdade;
    edit4.Enabled := verdade;
    edit5.Enabled := verdade;
    edit6.Enabled := verdade;
    ComboBox1.Enabled := verdade;
    MaskEdit1.Enabled := verdade;
    MaskEdit2.Enabled := verdade;
    MaskEdit3.Enabled := verdade;
    MaskEdit4.Enabled := verdade;
  end;

procedure TfrmCadFornecedor.NovoExecute(Sender: TObject);
begin
  btnNovoClick(sender);
end;

procedure TfrmCadFornecedor.SairExecute(Sender: TObject);
begin
  btnSairClick(sender);
end;

procedure TfrmCadFornecedor.SalvarExecute(Sender: TObject);
begin
  btnSalvarClick(sender);
end;

end.


