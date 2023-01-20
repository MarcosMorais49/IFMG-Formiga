unit uDigitarOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Grids, uDM, uOrdemProducao, uCriarOP, Vcl.ActnList;

type
  TfrmDigitarOP = class(TForm)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnConfirmar: TToolButton;
    ToolButton4: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    ActionList1: TActionList;
    Confirmar: TAction;
    Cancelar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfirmarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDigitarOP: TfrmDigitarOP;

implementation

{$R *.dfm}
var tempOP : integer;
procedure TfrmDigitarOP.btnCancelarClick(Sender: TObject);
begin
  frmDigitarOP.Close;
end;

procedure TfrmDigitarOP.btnConfirmarClick(Sender: TObject);
var i : integer;
begin
  for i := 1 to StringGrid1.RowCount -1 do
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('update itens_producao set itPdcQtdeUsada = '
    +QuotedStr(StringReplace(StringGrid1.Cells[2,i], ',', '.', [rfReplaceAll]))+' where itPdc_pdcCodigo = '
    +QuotedStr(IntToStr(tempOP))+' and itPdc_mpCodigo = '+QuotedStr(StringGrid1.Cells[0,i]));
    frmDM.Consultas.ExecSQL; //Insere "qtdePrevista" na tabela itens_producao
  end;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('update producao set pdcStatus = '+QuotedStr('Digitado')
    +' where pdcCodigo = '+QuotedStr(IntToStr(tempOP)));
    frmDM.Consultas.ExecSQL;

    frmDigitarOP.Close;
end;

procedure TfrmDigitarOP.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(Sender);
end;

procedure TfrmDigitarOP.ConfirmarExecute(Sender: TObject);
begin
  btnConfirmarClick(Sender);
end;

procedure TfrmDigitarOP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabProducao.Close;
  frmDM.tabProducao.Open;
  frmOrdemProducao.DBGrid1.Refresh;
end;

procedure TfrmDigitarOP.FormCreate(Sender: TObject);
var
  I,j : Integer;
begin
  StringGrid1.Cells[0,0] := 'Codigo';
  StringGrid1.Cells[1,0] := 'Descri��o';
  StringGrid1.Cells[2,0] := 'Quantidade';

  tempOP := StrToInt(frmOrdemProducao.DBGrid1.Fields[0].AsString);

  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from itens_producao where itPdc_pdcCodigo = '
  +QuotedStr(frmOrdemProducao.DBGrid1.Fields[0].AsString));
  frmDM.Consultas.Open;
  frmDM.Consultas.First;

  j:= frmDM.Consultas.RecordCount;
  for I := 1 to j do
  begin
    StringGrid1.Cells[0,i] := frmDM.Consultas.FieldByName('itPdc_mpCodigo').AsString;
    frmDM.Consultas.Next;
  end;
end;
procedure TfrmDigitarOP.FormShow(Sender: TObject);
var i,j:integer;
begin
  j:=StringGrid1.RowCount-1;
  for i:= 1 to j do
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select * from matPrima where mpCodigo = '
    +QuotedStr(StringGrid1.Cells[0,i]));
    frmDM.Consultas.open;

    frmDM.qryUnidade.Close;
    frmDM.qryUnidade.SQL.Clear;
    frmDM.qryUnidade.SQL.Add('select undDescricao from unidade where undCodigo ='
    +' (select mp_undCodigo from matPrima where mpCodigo = '+QuotedStr(StringGrid1.Cells[0,i])+')');
    frmDM.qryUnidade.Open;

    StringGrid1.Cells[1,i] := frmDM.Consultas.FieldByName('mpDescricao').Text
      +' '+frmDM.qryUnidade.FieldByName('undDescricao').AsString;
  end;

end;

procedure TfrmDigitarOP.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = 0) or (ACol = 1) then
    begin
        StringGrid1.Options:=StringGrid1.Options - [goEditing];
    end
  else
        StringGrid1.Options:=StringGrid1.Options + [goEditing];
 // O cod acima habilita os campos edit�veis da grid
end;

end.
