unit uFinalizar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ImgList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.ActnList;

type
  TfrmFinalizar = class(TForm)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnFinalizar: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ActionList1: TActionList;
    Finalizar: TAction;
    Cancelar: TAction;
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FinalizarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinalizar: TfrmFinalizar;
  temp1: string;

implementation

{$R *.dfm}
uses uVenda, uDm;

procedure TfrmFinalizar.btnCancelarClick(Sender: TObject);
var numNf,i :integer;
begin
    frmFinalizar.Close;
    frmVenda.btnCancelar.Enabled := true;
    frmVenda.btnSair.Enabled := false;

end;

procedure TfrmFinalizar.btnFinalizarClick(Sender: TObject);
var i, numNf : integer;
    str, strnovo : string;
begin
   str := '';
   strnovo := '';
   if edit1.Text >= label6.Caption then
   begin
     str := temp1;
     strnovo := StringReplace(str, ',', '.', [rfReplaceAll]);
     // converte a virgula em ponto para salvar no banco

     frmDM.Consultas.Close;
     frmDM.Consultas.Sql.Clear;
     frmDM.Consultas.SQL.Add('insert into venda (cliente_cliCodigo, '
     + 'venData, venTotal) '
     + ' values ('+QuotedStr(frmVenda.Edit2.text)+', Current_timestamp'
     + ', '+QuotedStr(strnovo)+')');
     frmDM.Consultas.ExecSQL;

     for i := 1 to frmVenda.StringGrid1.RowCount -2 do
     begin
        str := frmVenda.StringGrid1.Cells[3, i];
        strnovo := StringReplace(str, ',', '.', [rfReplaceAll]);
        // converte a virgula em ponto para salvar no banco

        frmDM.Consultas.Close;
        frmDM.Consultas.Sql.Clear;
        frmDM.Consultas.SQL.Add('insert into item_Venda (venda_venCodigo, '
         + 'produto_proCodigo, venValorUnit, venQtde) '
         + ' values ('+Quotedstr(frmVenda.Edit3.Text)+', '+QuotedStr(StringReplace(frmVenda.StringGrid1.Cells[0, i], ',', '.', [rfReplaceAll]))
         + ', '+QuotedStr(strnovo)+', '+QuotedStr(StringReplace(frmVenda.StringGrid1.Cells[2, i], ',', '.', [rfReplaceAll]))+')');
        frmDM.Consultas.ExecSQL;
        //Insere o itemVenda no Banco

        frmDM.Consultas.Close;
        frmDM.Consultas.SQL.Clear;
        frmDM.Consultas.SQL.Add('update produto set proEstoque = proEstoque - '+QuotedStr(StringReplace(frmVenda.StringGrid1.Cells[2, i], ',', '.', [rfReplaceAll]))
                      +' where proCodigo = '+QuotedStr(frmVenda.StringGrid1.Cells[0,i]));
        frmDM.Consultas.ExecSQL; //atualiza estoque do produto ap�s a venda
      end;

      frmvenda.label6.Caption := '';
      frmVenda.Edit1.Clear;
      frmVenda.Edit2.Clear;
      with frmVenda.StringGrid1 do
      for I := 1 to frmVenda.StringGrid1.RowCount do
        frmVenda.StringGrid1.Rows[i].Clear;

      Label6.Caption := '';
      Label7.Caption := '';
      frmVenda.StringGrid1.RowCount := 2;
      frmVenda.btnSair.Enabled := true;
      frmVenda.btnPesuisarItem.Enabled := false;
      frmVenda.btnFinalizar.Enabled := false;
      frmVenda.btnCancelar.Enabled := false;
      frmVenda.StringGrid1.Enabled := false;
      frmDM.tabItemVenda.Close;
      frmDM.tabVenda.Close;
      frmDM.tabItemVenda.Open;
      frmDM.tabVenda.Open;

      frmfinalizar.close;
   end
   else
      ShowMessage('O valor recebido � menor que o total de vencimentos!');
end;

procedure TfrmFinalizar.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmFinalizar.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
   var a,b,c : real;
  temp : string;
  i,j:integer;
begin
temp := '';
temp1 := '';
if key = VK_TAB then
begin
if Edit1.Text <> '' then
  begin
    btnFinalizar.Enabled := true;

    temp := Label6.Caption;
    J:=1;
    for i := 1 to Length(temp) do
      if temp[i] <> '.' then
      begin
        temp1 := temp1 + temp[i];
        j:=j+1;
      end;

    a := strtofloat(temp1);
    b := StrTofloat(Edit1.Text);
    c := b - a;

    if c < 0 then
      begin
      ShowMessage('O valor recebido � menor que o total de vencimentos!');
      temp1 := '';
      end
    else
      label7.caption := FormatFloat(',0.00',c);
  end
  else
    begin
      btnFinalizar.Enabled := false;
      Label7.Caption := '0,00';
    end;
end;
end;

procedure TfrmFinalizar.FinalizarExecute(Sender: TObject);
begin
  btnFinalizarClick(sender);
end;

procedure TfrmFinalizar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmDM.Consultas.SQL.Clear;
   frmDM.Consultas.SQL.Add('show table status from padaria like '+QuotedStr('venda'));
   frmDM.Consultas.Open;
   frmVenda.edit3.Text := frmDM.Consultas.FieldByName('Auto_increment').AsString;
   // Verifica o valor do pr�ximo campo auto_increment da tabela

   Label6.Caption := '';
   Label7.Caption := '';
end;

procedure TfrmFinalizar.FormCreate(Sender: TObject);
begin
  Label6.Caption := frmVenda.label6.Caption;
  temp1 := '';
end;

procedure TfrmFinalizar.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.
