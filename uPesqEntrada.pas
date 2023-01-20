unit uPesqEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, uDm, uEntradaNf, Vcl.ImgList;

type
  TfrmPesqEntrada = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    dsEntrada: TDataSource;
    btnPesquisar: TButton;
    Edit2: TEdit;
    ImageList1: TImageList;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesqEntrada: TfrmPesqEntrada;

implementation

{$R *.dfm}
uses uPesqFornecedor, uCadFornecedor;

procedure TfrmPesqEntrada.btnPesquisarClick(Sender: TObject);
begin
  pesqForn := 2;

  frmPesqFornecedor := TfrmPesqFornecedor.Create(Application);
  frmPesqFornecedor.ShowModal;
  frmPesqFornecedor.Release;
end;

procedure TfrmPesqEntrada.Button1Click(Sender: TObject);
begin
  if Edit2.Text <> '' then //pesquisa nota fiscal por fornecedor
  begin
    frmDM.tabEntrada.Filtered := false;
    frmDM.tabEntrada.Filter := 'fornecedor_forCodigo = '+QuotedStr(Edit1.Text);
    frmDM.tabEntrada.Filtered := true;
  end
  else  //se n�o tiver filtro apaga a consulta e mostra todas nf
  begin
    frmDM.tabEntrada.Filtered := false;
    frmDM.tabEntrada.Filter := '';
    frmDM.tabEntrada.Filtered := true;
  end;
  Edit1.SetFocus;
end;

procedure TfrmPesqEntrada.DBGrid1DblClick(Sender: TObject);
var i,j,contrTemp :integer;
  cod: array [1..30]of string;    // Colocar array com tamanho certo
  qtde: array [1..30]of string;   // conforme o necess�rio
  total:Double;
begin
  FillChar(cod, SizeOf(cod), #0);  // Zerar o Vetor
  FillChar(qtde, SizeOf(qtde), #0);
  i:=1;
  frmEntradaNF.Edit4.Text := DBGrid1.fields[4].AsString; //Serie
  frmEntradaNF.maskEdit1.Text := DBGrid1.fields[5].AsString; //Emissao
  frmEntradaNF.Edit1.Text := DBGrid1.fields[1].AsString; //Cod Fornecedor
  frmEntradaNF.Edit3.Text := DBGrid1.fields[3].AsString;  //Numero NF
  frmEntradaNF.maskEdit2.Text := DBGrid1.fields[6].AsString; //Entrada
  frmEntradaNF.Edit9.Text := DBGrid1.fields[7].AsString; //Vlr Total Bruto
  frmEntradaNF.Edit8.Text := DBGrid1.fields[9].AsString;  // Vlr ICMS
  frmEntradaNF.Edit10.Text := DBGrid1.fields[10].AsString;   //Base ST
  frmEntradaNF.Edit14.Text := DBGrid1.fields[13].AsString;  //Desconto
  frmEntradaNF.Edit13.Text := DBGrid1.fields[14].AsString;  //Despesa
  frmEntradaNF.Edit15.Text := DBGrid1.fields[15].AsString;   //Total Liquido
  frmEntradaNF.Edit12.Text := DBGrid1.fields[12].AsString;  //IPI
  frmEntradaNF.Edit11.Text := DBGrid1.fields[11].AsString;  //Valor ST
  frmEntradaNF.Edit7.Text := DBGrid1.fields[8].AsString;   //Base ICMS
  frmEntradaNF.Edit2.Text := DBGrid1.fields[2].AsString; // Fornecedor Raz. Social
  contrTemp := StrToInt(DBGrid1.fields[0].AsString);

  frmEntradaNF.StringGrid1.RowCount := 30;
  j:=1;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from entrada_matPrima where entrada_entControle = '+IntToStr(contrTemp));
  frmDM.Consultas.Open;
  while not frmDM.Consultas.Eof do
  begin
    cod[j]:= (frmDM.Consultas.FieldByName('matPrima_mpCodigo').AsString);
    qtde[j]:= (frmDM.Consultas.FieldByName('mp_nfQtde').AsString);
    j:=j+1;
    frmDM.Consultas.Next;
  end;

  i:=1;
  while i<j do
  begin
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from matPrima where mpCodigo = '
  +cod[i]);
  frmDM.Consultas.Open;
  frmDM.Consultas.First;
    frmDM.qryUnidade.Close;
    frmDM.qryUnidade.SQL.Clear;
    frmDM.qryUnidade.SQL.Add('select * from unidade where undCodigo = '
    +QuotedStr(frmDM.Consultas.FieldByName('mp_undCodigo').AsString));
    frmDM.qryUnidade.Open;

    frmEntradaNF.StringGrid1.Cells[0,i] := cod[i];
    frmEntradaNF.StringGrid1.Cells[1,i] := frmDM.Consultas.FieldByName('mpDescricao').AsString
    + ' ' +frmDM.qryUnidade.FieldByName('undDescricao').AsString;
    frmEntradaNF.StringGrid1.Cells[3,i] := qtde[i];
    frmEntradaNF.StringGrid1.Cells[2,i] := frmDM.Consultas.FieldByName('mpPCusto').AsString;
    total := StrToFloat(qtde[i])* StrToFloat(frmDM.Consultas.FieldByName('mpPCusto').AsString);
    frmEntradaNF.StringGrid1.Cells[4,i] := FloatToStr(total);
    frmEntradaNF.StringGrid1.Cells[5,i] := IntToStr(contrTemp);
    frmDM.Consultas.Next;
    i:=i+1;
  end;

  for I := 1 to 29 do  //calcula quantas linhas est�o sendo usadas para a propriedade rowCount
    if frmEntradaNF.StringGrid1.Cells[0,i] = '' then
      frmEntradaNF.StringGrid1.RowCount := frmEntradaNF.StringGrid1.RowCount -1;

  frmEntradaNF.btnNovo.Enabled := True;
  frmEntradaNF.btnEditar.Enabled := true;
  frmEntradaNF.btnExcluir.Enabled := true;
  frmEntradaNF.btnSalvar.Enabled := False;
  frmEntradaNF.btnCancelar.Enabled := False;
  frmEntradaNF.btnSair.Enabled := True;
  frmEntradaNF.btnPesquisar.Enabled := false;
  frmEntradaNF.btnPesquisar1.Enabled := True;
  frmEntradaNF.StringGrid1.Enabled := false;
  frmEntradaNF.StringGrid1.Enabled := false;

  frmPesqEntrada.Close;
end;

procedure TfrmPesqEntrada.Edit1Exit(Sender: TObject);
begin
  frmDM.Consultas.Close;
  frmDM.Consultas.Sql.Clear;
  frmDM.Consultas.SQL.Add('select * from fornecedor where forCodigo = '
  +QuotedStr(Edit1.Text));
  frmDM.Consultas.open;
  Edit2.Text := frmDM.Consultas.FieldByName('forNome').AsString
end;

procedure TfrmPesqEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabEntrada.Filtered := false;
    frmDM.tabEntrada.Filter := '';
    frmDM.tabEntrada.Filtered := true;
end;

procedure TfrmPesqEntrada.FormCreate(Sender: TObject);
begin
  frmDM.tabEntrada.Filtered := false;
  frmDM.tabEntrada.Filter := '';
  frmDM.tabEntrada.Filtered := true;

  frmDM.tabFornecedor.Close;
  frmDM.tabFornecedor.Open;
  frmDM.tabEntrada.Close;
  frmDM.tabEntrada.Open;
  DBGrid1.Refresh;
  frmDM.tabFornecedor.Refresh;
  frmDM.tabEntrada.Refresh;
end;

end.
