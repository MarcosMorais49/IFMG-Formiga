unit uRelEstoqueMatPrima;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RpCon, RpConDS, RpBase, RpSystem,
  RpDefine, RpRave, Vcl.ActnList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, uDM;

type
  TfrmRelEstoqueMatPrima = class(TForm)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnGerar: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    RadioGroup1: TRadioGroup;
    ImageList1: TImageList;
    ActionList1: TActionList;
    Gerar: TAction;
    Cancelar: TAction;
    RvProjectEstoqueMp: TRvProject;
    RvSystemEstoqueMp: TRvSystem;
    RVDSConexaoEstoqueMp: TRvDataSetConnection;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure GerarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEstoqueMatPrima: TfrmRelEstoqueMatPrima;

implementation

{$R *.dfm}

procedure TfrmRelEstoqueMatPrima.btnCancelarClick(Sender: TObject);
begin
  frmRelEstoqueMatPrima.Close;
end;

procedure TfrmRelEstoqueMatPrima.btnGerarClick(Sender: TObject);
var ordenar, mostrar : string;
begin
  if ComboBox1.ItemIndex = 0 then
    ordenar := 'mpCodigo'
  else if ComboBox1.ItemIndex = 1 then
    ordenar := 'mpDescricao'
  else
    ordenar := 'mpEstoque desc';

  if RadioGroup1.ItemIndex = 0 then
    mostrar := 'mpCodigo >= '+QuotedStr('0')
  else if RadioGroup1.ItemIndex = 1 then
    mostrar := 'mpEstoque > '+QuotedStr('0')
  else
    mostrar := 'mpEstoque <= '+QuotedStr('0');

  frmDM.qryMp.close;
  frmDM.qryMp.SQL.Clear;
  frmDM.qryMp.SQL.Add('select * from matPrima where '+mostrar+' order by '+ordenar);

  RvProjectEstoqueMp.Open;
  RvProjectEstoqueMp.ExecuteReport('Report1');
end;

procedure TfrmRelEstoqueMatPrima.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmRelEstoqueMatPrima.GerarExecute(Sender: TObject);
begin
  btnGerarClick(sender);
end;

end.
