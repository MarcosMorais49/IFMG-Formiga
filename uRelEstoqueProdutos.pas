unit uRelEstoqueProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.StdCtrls, Vcl.ExtCtrls, uDM, RpCon, RpConDS, RpBase,
  RpSystem, RpDefine, RpRave;

type
  TfrmRelEstoqueProdutos = class(TForm)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnGerar: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    Gerar: TAction;
    Cancelar: TAction;
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    RvProjectEstoqueProd: TRvProject;
    RvSystemEstoqueProd: TRvSystem;
    RVDSConexaoEstoqueProd: TRvDataSetConnection;
    procedure btnGerarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure GerarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEstoqueProdutos: TfrmRelEstoqueProdutos;

implementation

{$R *.dfm}

procedure TfrmRelEstoqueProdutos.btnCancelarClick(Sender: TObject);
begin
  frmRelEstoqueProdutos.Close;
end;

procedure TfrmRelEstoqueProdutos.btnGerarClick(Sender: TObject);
var mostrar, ordenar : string;
begin
  if ComboBox1.ItemIndex = 0 then
    ordenar := 'proCodigo'
  else if ComboBox1.ItemIndex = 1 then
    ordenar := 'proDescricao'
  else
    ordenar := 'proEstoque desc';

  if RadioGroup1.ItemIndex = 0 then
    mostrar := 'proCodigo >= '+QuotedStr('0')
  else if RadioGroup1.ItemIndex = 1 then
    mostrar := 'proEstoque > '+QuotedStr('0')
  else
    mostrar := 'proEstoque <= '+QuotedStr('0');

  frmDM.qryProduto.close;
  frmDM.qryProduto.SQL.Clear;
  frmDM.qryProduto.SQL.Add('select * from produto where '+mostrar+' order by '+ordenar);

  RvProjectEstoqueProd.Open;
  RvProjectEstoqueProd.ExecuteReport('Report1');
end;

procedure TfrmRelEstoqueProdutos.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(Sender);
end;

procedure TfrmRelEstoqueProdutos.GerarExecute(Sender: TObject);
begin
  btnGerarClick(Sender);
end;

end.
