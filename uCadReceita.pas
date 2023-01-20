unit uCadReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ImgList, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ExtCtrls, uDM, uCadProduto, uPesqProduto, uPesqMatPrima;

type
  TfrmCadReceita = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
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
    Edit1: TEdit;
    Edit2: TEdit;
    ImageList1: TImageList;
    ImageList2: TImageList;
    StringGrid1: TStringGrid;
    btnPesquisar: TButton;
    Edit3: TEdit;
    btnPesquisar1: TButton;
    ActionList1: TActionList;
    Novo: TAction;
    Editar: TAction;
    Salvar: TAction;
    Excluir: TAction;
    Cancelar: TAction;
    Sair: TAction;
    btnPesqItem: TButton;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid1GetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesquisar1Click(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SalvarExecute(Sender: TObject);
    procedure ExcluirExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnPesqItemClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure habilitarEdicao(verdade:boolean);
  end;

var
  frmCadReceita: TfrmCadReceita;
  editGrav:boolean;
  tempRecCodigo : integer;
  aux : Double;
  aux1 : string;

implementation

{$R *.dfm}

procedure TfrmCadReceita.btnCancelarClick(Sender: TObject);
var i:integer;
begin
  habilitarEdicao(false);

  btnNovo.Enabled := True;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := false;
  btnPesquisar1.Enabled := true;

  Edit1.Clear;
  Edit2.Clear;                        //Limpar a Tela
  Edit3.Clear;
  for I := 1 to StringGrid1.RowCount -1 do
  begin
  StringGrid1.Cells[0,i] := '';
  StringGrid1.Cells[1,i] := '';
  StringGrid1.Cells[2,i] := '';
  end;
  StringGrid1.RowCount:=2;
end;

procedure TfrmCadReceita.btnEditarClick(Sender: TObject);
begin
  StringGrid1.Enabled := true;
  Edit2.Enabled := false;
  Edit3.Enabled := False;
  StringGrid1.SetFocus;

  tempRecCodigo := StrToInt(Edit1.Text);

  editGrav:= false;

  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := false;
  btnPesquisar1.Enabled := false;
end;

procedure TfrmCadReceita.btnExcluirClick(Sender: TObject);
var i:integer;
begin
 if Application.MessageBox('Tem certeza que deseja excluir a receita selecionado?',
   'Confirmação', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    btnNovo.Enabled := True;
    btnEditar.Enabled := False;
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnCancelar.Enabled := False;
    btnSair.Enabled := True;
    btnPesquisar.Enabled := false;
    btnPesquisar1.Enabled := true;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('delete from receita where recCodigo = '+Edit1.Text);
    frmDM.Consultas.ExecSQL;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('delete from matPrima_receita where receita_recCodigo = '+Edit1.Text);
    frmDM.Consultas.ExecSQL;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('update produto set recAssociada = 0 where proCodigo = '+Edit2.Text);
    frmDM.Consultas.ExecSQL;

    Edit1.Clear;
    Edit2.Clear;                        //Limpar a Tela
    Edit3.Clear;
    for I := 1 to StringGrid1.RowCount -1 do
    begin
      StringGrid1.Cells[0,i] := '';
      StringGrid1.Cells[1,i] := '';
      StringGrid1.Cells[2,i] := '';
    end;
    StringGrid1.RowCount:=2;

    frmDM.tabReceita.Close;
    frmDM.tabMpReceita.Close;
    frmDM.tabProduto.Close;
    frmDM.tabReceita.Open;
    frmDM.tabMpReceita.Open;
    frmDM.tabProduto.Open;
  end
  else
  abort
end;

procedure TfrmCadReceita.btnNovoClick(Sender: TObject);
var i:integer;
begin
  habilitarEdicao(true);

  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := true;
  btnPesquisar1.Enabled := false;

  Edit1.Clear;
  Edit2.Clear;                        //Limpar a Tela
  Edit3.Clear;
  for I := 1 to StringGrid1.RowCount -1 do
  begin
    StringGrid1.Cells[0,i] := '';
    StringGrid1.Cells[1,i] := '';
    StringGrid1.Cells[2,i] := '';
  end;
  StringGrid1.RowCount:=2;

  frmDM.tabReceita.Close;
  frmDM.tabMpReceita.Close;
  frmDM.tabProduto.Close;
  frmDM.tabReceita.Open;
  frmDM.tabMpReceita.Open;
  frmDM.tabProduto.Open;;

  Edit2.SetFocus;

  editGrav:= true;

  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('show table status from padaria like '+QuotedStr('receita'));
  frmDM.Consultas.Open;
  edit1.Text := frmDM.Consultas.FieldByName('Auto_increment').AsString;
end;

procedure TfrmCadReceita.btnPesqItemClick(Sender: TObject);
begin
  pesqMp := 2;

  frmPesqMatPrima := TfrmPesqMatPrima.Create(Application);
  frmPesqMatPrima.ShowModal;
  frmPesqMatPrima.Release;
end;

procedure TfrmCadReceita.btnPesquisar1Click(Sender: TObject);
var i:integer;
begin
  pesqProd := 3;

  frmCadReceita.Edit1.Clear;
  frmCadReceita.Edit2.Clear;
  frmCadReceita.Edit3.Clear;
  for I := 1 to frmCadReceita.StringGrid1.RowCount -1 do
  begin
     frmCadReceita.StringGrid1.Cells[0,i] := '';
     frmCadReceita.StringGrid1.Cells[1,i] := '';
     frmCadReceita.StringGrid1.Cells[2,i] := '';
  end;
  frmCadReceita.StringGrid1.RowCount:=2;
  // O código acima limpa a tela do cadastro de receitas, antes de inserir
  // os dados da nova consulta

  frmPesqProduto := TfrmPesqProduto.Create(Application);
  frmPesqProduto.ShowModal;
  frmPesqProduto.Release;
end;

procedure TfrmCadReceita.btnPesquisarClick(Sender: TObject);
begin
  pesqProd := 2;

  frmPesqProduto := TfrmPesqProduto.Create(Application);
  frmPesqProduto.ShowModal;
  frmPesqProduto.Release;
end;

procedure TfrmCadReceita.btnSairClick(Sender: TObject);
begin
  frmCadReceita.Close;
end;

procedure TfrmCadReceita.btnSalvarClick(Sender: TObject);
var i:integer;
    str, strNovo : string;
begin
  habilitarEdicao(false);

  btnNovo.Enabled := True;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := True;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := false;
  StringGrid1.Enabled := false;
  StringGrid1.Enabled := false;
  btnPesquisar1.Enabled := true;

  if editGrav = true then //Botao Novo
  begin
   frmDm.Consultas.Close;
   frmDm.Consultas.Sql.Clear;
   frmDm.Consultas.SQL.Add('insert into receita (produto_proCodigo) '
   + ' values ('+QuotedStr(Edit2.Text)+')');
   frmDm.Consultas.ExecSQL;
   // Insere dados na tabela receita

   for i := 1 to StringGrid1.RowCount -2 do
   begin
      str := Quotedstr(StringGrid1.Cells[2,i]);
      strnovo := StringReplace(str, ',', '.', [rfReplaceAll]);
      // converte a virgula em ponto para salvar no banco

      frmDm.Consultas.Close;
      frmDm.Consultas.Sql.Clear;
      frmDm.Consultas.SQL.Add('insert into matPrima_receita (matPrima_mpCodigo, '
       + 'receita_recCodigo, mp_recQtde)'
       + ' values ('+Quotedstr(StringGrid1.Cells[0,i])+', '+QuotedStr(Edit1.Text)
       + ', '+strNovo+')');
      frmDm.Consultas.ExecSQL;
    end;
    //Insere dados na tabela matPrima_receita
  end

  else  //botao editar
  begin
    frmDm.Consultas.Close;
    frmDm.Consultas.Sql.Clear;
    frmDm.Consultas.SQL.Add('delete from matPrima_receita where receita_recCodigo = '+QuotedStr(Edit1.Text));
    frmDm.Consultas.ExecSQL;

    for i := 1 to StringGrid1.RowCount -2 do
   begin
      str := Quotedstr(StringGrid1.Cells[2,i]);
      strnovo := StringReplace(str, ',', '.', [rfReplaceAll]);
      // converte a virgula em ponto para salvar no banco

      frmDm.Consultas.Close;
      frmDm.Consultas.Sql.Clear;
      frmDm.Consultas.SQL.Add('insert into matPrima_receita (matPrima_mpCodigo, '
       + 'receita_recCodigo, mp_recQtde)'
       + ' values ('+Quotedstr(StringGrid1.Cells[0,i])+', '+QuotedStr(Edit1.Text)
       + ', '+strNovo+')');
      frmDm.Consultas.ExecSQL;
    end;
    //Insere os novos dados na tabela matPrima_receita

  end;
  frmDm.Consultas.Close;
  frmDm.Consultas.Sql.Clear;
  frmDm.Consultas.SQL.Add('update produto set recAssociada = 1 where proCodigo = '
  +QuotedStr(Edit2.Text));
  frmDm.Consultas.ExecSQL;

  editGrav := true;
  frmDm.tabReceita.Close;
  frmDm.tabMpReceita.Close;
  frmDm.tabReceita.Open;
  frmDm.tabMpReceita.Open;
end;

procedure TfrmCadReceita.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmCadReceita.Edit2Exit(Sender: TObject);
begin
  if Edit2.Text <> '' then
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select * from produto where proCodigo = '+Edit2.Text);
    frmDM.Consultas.Open;
    if (frmDM.Consultas.FieldByName('recAssociada').Text =  '0') then //Verifica se ja existe receita cadastrada para o produto
      Edit3.Text := (frmDM.Consultas.FieldByName('proDescricao').AsString)
    else
      ShowMessage('Já existe receita cadastrada para este produto!');
  end
end;

procedure TfrmCadReceita.EditarExecute(Sender: TObject);
begin
  btnEditarClick(sender);
end;

procedure TfrmCadReceita.ExcluirExecute(Sender: TObject);
begin
  btnExcluirClick(sender);
end;

procedure TfrmCadReceita.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabProduto.Close;
  frmDM.tabReceita.Close;
  frmDM.tabMp.Close;
  frmDM.tabMpReceita.Close;
end;

procedure TfrmCadReceita.FormCreate(Sender: TObject);
begin
  frmDM.tabProduto.Open;
  frmDM.tabReceita.Open;
  frmDM.tabMp.Open;
  frmDM.tabMpReceita.Open;
end;

procedure TfrmCadReceita.FormShow(Sender: TObject);
begin
  StringGrid1.Cells[0,0] := 'Código';
  StringGrid1.Cells[1,0] := 'Produto';
  StringGrid1.Cells[2,0] := 'Quantidade';


end;

procedure TfrmCadReceita.SairExecute(Sender: TObject);
begin
  btnSairClick(sender);
end;

procedure TfrmCadReceita.SalvarExecute(Sender: TObject);
begin
  btnSalvarClick(sender);
end;

procedure TfrmCadReceita.StringGrid1GetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin

 if (StringGrid1.Cells[0,StringGrid1.RowCount - 1] <> '') and
    (StringGrid1.Cells[1,StringGrid1.RowCount - 1] <> '') then
    StringGrid1.RowCount := StringGrid1.RowCount +1;
 // Adiciona linha quando a ultima linha e coluna entra em edicao
end;

procedure TfrmCadReceita.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);

var i: integer;
begin
  if (ACol = 1) then
    begin
        StringGrid1.Options:=StringGrid1.Options - [goEditing];
    end
  else
        StringGrid1.Options:=StringGrid1.Options + [goEditing];
 // O cod acima habilita os campos editáveis da grid
end;

procedure TfrmCadReceita.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var i : integer;
begin
  for I := 1 to StringGrid1.RowCount +1 do
    if (StringGrid1.Cells[0,i] <> '') and (ACol = 0) then
    begin
      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;
      frmDM.Consultas.SQL.Add('Select * from matPrima where mpCodigo = '
        +StringGrid1.Cells[0,i]);
      frmDM.Consultas.open;
      if frmDM.Consultas.IsEmpty then
        begin
          ShowMessage('Código Invalido');
          StringGrid1.Cells[1,i] := '';
          StringGrid1.Cells[2,i] := '';
        end
      else
      begin
        frmDM.qryUnidade.Close;
        frmDM.qryUnidade.SQL.Clear;
        frmDM.qryUnidade.SQL.Add('select * from unidade where undCodigo = '
        +QuotedStr(frmDM.Consultas.FieldByName('mp_undCodigo').AsString));
        frmDM.qryUnidade.Open;

        StringGrid1.Cells[1,i] := frmDM.Consultas.FieldByName('mpDescricao').AsString
          +' '+frmDM.qryUnidade.FieldByName('undDescricao').AsString;
      end;
    end
    else if (StringGrid1.Cells[0,i] = '') and (ACol = 0) then
      begin
        StringGrid1.Cells[1,i] := '';
        StringGrid1.Cells[2,i] := '';
      end;
end;

procedure TfrmCadReceita.habilitarEdicao(verdade : boolean);
  begin
    edit2.Enabled := verdade;
    Edit3.Enabled := verdade;
    StringGrid1.Enabled := verdade;
    btnPesqItem.Enabled := verdade
  end;

procedure TfrmCadReceita.NovoExecute(Sender: TObject);
begin
  btnNovoClick(sender);
end;

end.
