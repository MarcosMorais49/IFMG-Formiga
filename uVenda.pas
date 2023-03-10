unit uVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Grids, Vcl.StdCtrls, Vcl.ActnList;

type
  TfrmVenda = class(TForm)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnFinalizar: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    btnSair: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    btnPesuisarItem: TButton;
    btnPesquisar: TButton;
    StringGrid1: TStringGrid;
    ActionList1: TActionList;
    Finalizar: TAction;
    Sair: TAction;
    Cancelar: TAction;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesuisarItemClick(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure FinalizarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVenda: TfrmVenda;

implementation

{$R *.dfm}

uses uPesqCliente, uPesqProduto, uDM, uFinalizar;

procedure TfrmVenda.btnCancelarClick(Sender: TObject);
var i, numNf :integer;
begin
  if Application.MessageBox('Tem certeza que deseja cancelar a venda?',
  'ConfirmašŃo', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    btnSair.Enabled := true;
    btnCancelar.Enabled := false;
    Label6.Caption := '';
    frmVenda.Edit1.Clear;
    frmVenda.Edit2.Clear;
    frmVenda.Label6.Caption := '0,00';
    with frmVenda.StringGrid1 do
    for I := 1 to frmVenda.StringGrid1.RowCount do
      frmVenda.StringGrid1.Rows[i].Clear;
    frmVenda.StringGrid1.RowCount := 2;
  end
  else
    abort
end;

procedure TfrmVenda.btnFinalizarClick(Sender: TObject);
begin
  frmFinalizar := TfrmFinalizar.Create(Application);
  frmFinalizar.ShowModal;
  frmFinalizar.Release;
end;

procedure TfrmVenda.btnPesquisarClick(Sender: TObject);
begin
  tipoForm := true;  //especifica qual formulario esta chamando a pesquisa (cadCliente ou uVeda)

  frmPesqCliente := TfrmPesqCliente.Create(Application);
  frmPesqCliente.ShowModal;
  frmPesqCliente.Release;
end;

procedure TfrmVenda.btnPesuisarItemClick(Sender: TObject);
begin
  pesqProd := 4;

  frmPesqProduto := TfrmPesqProduto.Create(Application);
  frmPesqProduto.ShowModal;
  frmPesqProduto.Release;
end;

procedure TfrmVenda.btnSairClick(Sender: TObject);
begin
  frmVenda.Close;
end;

procedure TfrmVenda.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(Sender);
end;

procedure TfrmVenda.Edit2Exit(Sender: TObject);
begin
  if edit2.Text = '' then
  begin
    btnPesuisarItem.Enabled := false;
    btnFinalizar.Enabled := false;
    btnCancelar.Enabled := false;
    StringGrid1.Enabled := false;
  end
  else
  begin
    btnPesuisarItem.Enabled := true;
    btnFinalizar.Enabled := true;
    btnCancelar.Enabled := true;
    StringGrid1.Enabled := true;
    btnSair.Enabled := false;

    frmDM.Consultas.Close;
    frmDM.Consultas.Sql.Clear;
    frmDM.Consultas.SQL.Add('select * from cliente where cliCodigo = '
    +QuotedStr(Edit2.Text));
    frmDM.Consultas.open;
    Edit1.Text := frmDM.Consultas.FieldByName('cliNome').AsString;
  end;

end;

procedure TfrmVenda.FinalizarExecute(Sender: TObject);
begin
  btnFinalizarClick(Sender);
end;

procedure TfrmVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmDM.tabCliente.Close;
   frmDM.tabVenda.Close;
   frmDM.tabItemVenda.Close;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
var i, numNf : integer;
begin
   frmDM.tabCliente.Open;
   frmDM.tabVenda.Open;
   frmDM.tabItemVenda.Open;

   Edit4.text := DateTimeToStr(now);

   frmdm.Consultas.SQL.Clear;
   frmDM.Consultas.SQL.Add('show table status from padaria like '+QuotedStr('venda'));
   frmDM.Consultas.Open;
   edit3.Text := frmDM.Consultas.FieldByName('Auto_increment').AsString;
   // Verifica o valor do prˇximo campo auto_increment da tabela

   StringGrid1.Cells[0,0] := 'Cˇdigo';
   StringGrid1.Cells[1,0] := 'Produto';
   StringGrid1.Cells[2,0] := 'Qtde';
   StringGrid1.Cells[3,0] := 'Prešo';
   StringGrid1.Cells[4,0] := 'Total';

   btnPesuisarItem.Enabled := false;
   btnFinalizar.Enabled := false;
   btnCancelar.Enabled := false;
   StringGrid1.Enabled := false;
   btnSair.Enabled := true;
end;

procedure TfrmVenda.SairExecute(Sender: TObject);
begin
  btnSairClick(sender);
end;

procedure TfrmVenda.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var cl, ln, ln_atual: integer;
    t,a : real;
  i: Integer;
begin
if key = vk_delete then
begin
//vai da linha atual atÚ a ˙ltima (pois a primeira Ú zero)
for ln:= StringGrid1.Row to StringGrid1.RowCount - 1 do
for cl:= 0 to StringGrid1.ColCount -1 do
StringGrid1.Cells[cl, ln]:= StringGrid1.Cells[cl, ln+1];
//diminui uma linha
StringGrid1.RowCount := StringGrid1.RowCount -1;

t:=0;
a:=0;
for i := 1 to StringGrid1.RowCount-2 do
begin
  a :=  StrToFloat(StringGrid1.cells[4,i]);
  t := t + a;
  Label6.Caption := FormatFloat(',0.00', t);
end;
end;
end;

procedure TfrmVenda.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
  var i : integer;
      a,b,tot,totVenda, tempEst, tempQtde : real;
begin
  totVenda := 0;
  if (ACol = 1) or (ACol = 3) or (ACol = 4) then
    begin
        StringGrid1.Options:=StringGrid1.Options - [goEditing];
    end
  else
        StringGrid1.Options:=StringGrid1.Options + [goEditing];
 // O cod acima habilita os campos editßveis da grid

  for i := 1 to StringGrid1.RowCount +1 do
  begin
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select * from produto where proCodigo = '
    +QuotedStr(StringGrid1.Cells[0,i]));
    frmDM.Consultas.Open;
    StringGrid1.Cells[1,i] := frmDM.Consultas.FieldByName('proDescricao').AsString;
    StringGrid1.Cells[3,i] := frmDM.Consultas.FieldByName('proPVenda').AsString;
    frmDM.Consultas.Close;
    if (StringGrid1.Cells[2,i] <> '') and (StrToFloat(StringGrid1.Cells[2,i]) > 0)then
      begin
        frmDM.Consultas.SQL.Clear;
        frmDM.Consultas.SQL.Add('select * from produto where proCodigo = '
        +QuotedStr(StringGrid1.Cells[0,i]));
        frmDM.Consultas.Open;
        tempEst := StrToFloat(frmDM.Consultas.FieldByName('proEstoque').AsString);
        tempQtde := StrToFloat(StringGrid1.Cells[2,i]);
        if tempEst >= tempQtde then //Verifica se o estoque Ú suficiente para a venda
          begin
            a := StrToFloat(StringGrid1.Cells[2,i]);
            b := StrToFloat(StringGrid1.Cells[3,i]);
            tot := a * b;
            StringGrid1.Cells[4,i] := FloatToStr(tot);
            totVenda := totVenda + tot;
            label6.caption := FormatFloat(',0.00', totVenda); //faz a formatašŃo pro label ter valor apˇs a virgula R$xx,xx
          end
        else
          begin
            ShowMessage('Quantidade insuficiente no estoque!');
            StringGrid1.Cells[2,i] := '';
          end;
      end
    else
      StringGrid1.Cells[4,i] := ''

  end;
  if StringGrid1.Cells[1,StringGrid1.RowCount -1] <> '' then
    StringGrid1.RowCount := StringGrid1.RowCount + 1    // adiciona linhas quando necessario

end;

end.
