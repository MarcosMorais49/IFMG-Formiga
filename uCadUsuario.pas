unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ImgList, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, uDM, uPesqUsuario;

type
  TfrmCadUsuario = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    btnPesquisar: TButton;
    ComboBox1: TComboBox;
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
    Label11: TLabel;
    Edit8: TEdit;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Label12: TLabel;
    MaskEdit1: TMaskEdit;
    Label13: TLabel;
    MaskEdit2: TMaskEdit;
    ActionList1: TActionList;
    Novo: TAction;
    Editar: TAction;
    Salvar: TAction;
    Excluir: TAction;
    Cancelar: TAction;
    Sair: TAction;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
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
    procedure habilitarEdicao (verdade : boolean);
  end;

var
  frmCadUsuario: TfrmCadUsuario;
  var editGrav : boolean;

implementation

{$R *.dfm}

procedure TfrmCadUsuario.btnEditarClick(Sender: TObject);
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

procedure TfrmCadUsuario.btnExcluirClick(Sender: TObject);
begin
 if Application.MessageBox('Tem certeza que deseja excluir o usu�rio selecionado?',
   'Confirma��o', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
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
    frmDM.Consultas.SQL.Add('delete from usuario where usuCodigo = '+Edit1.Text);
    frmDM.Consultas.ExecSQL;

    Edit1.Clear;
    Edit2.Clear;
    Edit3.Clear;
    Edit4.Clear;
    Edit5.Clear;
    Edit6.Clear;
    Edit7.Clear;
    Edit8.Clear;
    MaskEdit1.Clear;
    MaskEdit2.Clear;
    MaskEdit3.Clear;
    MaskEdit4.Clear;
    ComboBox1.ItemIndex := -1;

    frmDM.tabUsuario.Close;
    frmDM.tabUsuario.Open;
  end
  else
    abort
end;

procedure TfrmCadUsuario.btnNovoClick(Sender: TObject);
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
  Edit7.Clear;
  Edit8.Clear;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  MaskEdit4.Clear;
  ComboBox1.ItemIndex := -1;

  editGrav := True;

  Edit2.SetFocus;
end;
procedure TfrmCadUsuario.btnSairClick(Sender: TObject);
begin
    frmCadUsuario.Close;
end;

procedure TfrmCadUsuario.btnSalvarClick(Sender: TObject);
begin
  if (Edit2.Text = '') or (Edit3.Text = '') or (Edit4.Text = '') or (Edit5.Text = '') or
  (Edit6.Text = '') or (Edit7.Text = '') or (MaskEdit1.Text = '   .   .   -  ') or
  (MaskEdit2.Text = ' .   .   ') or (MaskEdit3.Text = '  .   -   ') or
  (MaskEdit4.Text = '(  )    -    ') or (ComboBox1.ItemIndex < 0) then
    ShowMessage('Favor Preencher Todos os campos')
  else
  begin
    habilitarEdicao(false);

    btnNovo.Enabled := True;
    btnEditar.Enabled := true;
    btnExcluir.Enabled := true;
    btnSalvar.Enabled := False;
    btnCancelar.Enabled := False;
    btnSair.Enabled := True;
    btnPesquisar.Enabled := True;

    if editGrav = true then //Botao Novo
      begin
        frmDM.Consultas.Close;
        frmDM.Consultas.Sql.Clear;
        frmDM.Consultas.SQL.Add('insert into usuario (usuLogin, usuSenha, usuNome, usuEndereco,'
        +' usuBairro, usuCidade, usuEstado, usuTelefone, usuCep, usuCpf, usuRg, usuEmail)'
        + ' values ('+ QuotedStr(Edit6.Text)+', '+QuotedStr(Edit7.Text)+', '+QuotedStr(Edit2.Text)+', '
        +QuotedStr(Edit3.Text)+', '+QuotedStr(Edit4.Text)+', '+QuotedStr(Edit5.Text)+', '
        +QuotedStr(ComboBox1.Text)+', '+QuotedStr(MaskEdit4.Text)+', '+QuotedStr(MaskEdit3.Text)+', '
        +QuotedStr(MaskEdit1.Text)+', '+QuotedStr(MaskEdit2.Text)+', '+QuotedStr(Edit8.Text)+')');
        frmDM.Consultas.ExecSQL;
      end

    else
      begin
        frmDM.Consultas.Close;
        frmDM.Consultas.Sql.Clear;
        frmDM.Consultas.SQL.Add('update usuario set usuNome = '+QuotedStr(Edit2.text)+','
                       + ' usuEndereco = '+QuotedStr(Edit3.text)+', usuBairro = '+QuotedStr(Edit4.text)+','
                       + ' usuCidade = '+QuotedStr(Edit5.text)+', usuEstado = '+QuotedStr(combobox1.text)+','
                       + ' usuCep = '+QuotedStr(MaskEdit3.text)+', usuTelefone = '+QuotedStr(MaskEdit4.text)+','
                       + ' usuLogin = '+QuotedStr(Edit6.text)+', usuSenha = '+QuotedStr(Edit7.text)+', '
                       + ' usuCpf = '+QuotedStr(MaskEdit1.text)+', usuRg = '+QuotedStr(MaskEdit2.text)+', '
                       + ' usuEmail = '+QuotedStr(Edit8.text)
                       + ' where usuCodigo = '+Edit1.text);
        frmDM.Consultas.ExecSQL;
      end;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select usuCodigo from usuario where usuNome = '
    +QuotedStr(Edit2.Text)+' and usuSenha = '+QuotedStr(Edit7.Text));
    frmDM.Consultas.Open;
    Edit1.Text := frmDM.Consultas.FieldByName('usuCodigo').AsString;

    frmDM.tabUsuario.Close;
    frmDM.tabUsuario.Open;
  end;
end;

procedure TfrmCadUsuario.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmCadUsuario.Edit6Exit(Sender: TObject);
begin
  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from usuario where usuLogin = '+QuotedStr(Edit6.Text));
  frmDM.Consultas.open;
  if frmDM.Consultas.FieldByName('usuLogin').Text = Edit6.Text then
    begin
    ShowMessage('Login j� cadastrado no sistema!');
    Edit6.Text := '';
    end;
end;

procedure TfrmCadUsuario.EditarExecute(Sender: TObject);
begin
  btnEditarClick(sender);
end;

procedure TfrmCadUsuario.ExcluirExecute(Sender: TObject);
begin
  btnExcluirClick(sender);
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabUsuario.close;
end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  frmDM.tabUsuario.Open;

  btnNovo.Enabled := True;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := false;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := True;
end;

procedure TfrmCadUsuario.btnPesquisarClick(Sender: TObject);
begin
  frmPesqUsuario := TfrmPesqUsuario.Create(Application);
  frmPesqUsuario.ShowModal;
  frmPesqUsuario.Release;
end;

procedure TfrmCadUsuario.habilitarEdicao(verdade : boolean);
  begin
    edit1.Enabled := verdade;
    edit2.Enabled := verdade;
    edit3.Enabled := verdade;
    edit4.Enabled := verdade;
    edit5.Enabled := verdade;
    edit6.Enabled := verdade;
    edit7.Enabled := verdade;
    edit8.Enabled := verdade;
    ComboBox1.Enabled := verdade;
    MaskEdit1.Enabled := verdade;
    MaskEdit2.Enabled := verdade;
    MaskEdit3.Enabled := verdade;
    MaskEdit4.Enabled := verdade;
  end;

procedure TfrmCadUsuario.NovoExecute(Sender: TObject);
begin
  btnNovoClick(sender);
end;

procedure TfrmCadUsuario.SairExecute(Sender: TObject);
begin
  btnSairClick(sender);
end;

procedure TfrmCadUsuario.SalvarExecute(Sender: TObject);
begin
  btnSalvarClick(sender);
end;

procedure TfrmCadUsuario.btnCancelarClick(Sender: TObject);
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
  Edit7.Clear;
  Edit8.Clear;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  MaskEdit4.Clear;
  ComboBox1.ItemIndex := -1;
end;

end.
