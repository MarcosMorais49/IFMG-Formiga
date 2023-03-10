unit uRelVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uDM, RpCon, RpConDS,
  RpBase, RpSystem, RpDefine, RpRave;

type
  TfrmRelVenda = class(TForm)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnGerar: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ActionList1: TActionList;
    Gerar: TAction;
    Cancelar: TAction;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    RvProjectDia: TRvProject;
    RvSystem1: TRvSystem;
    RVDSConexaoVenda: TRvDataSetConnection;
    RVDSConexaoItemVenda: TRvDataSetConnection;
    RvProjectPeriodo: TRvProject;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure GerarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVenda: TfrmRelVenda;

implementation

{$R *.dfm}

procedure TfrmRelVenda.btnCancelarClick(Sender: TObject);
begin
  frmRelVenda.Close;
end;

procedure TfrmRelVenda.btnGerarClick(Sender: TObject);
var dt1, dt2 : string;
begin
  try
  dt1 := FormatDateTime('yyyy-mm-dd',StrToDate(MaskEdit1.Text));
  dt2 := FormatDateTime('yyyy-mm-dd',StrToDate(MaskEdit2.Text));
  except
    ShowMessage('Erro na convers?o das datas');
    exit;
  end;

  frmDM.qryVenda.Close;
  frmDM.qryVenda.SQL.Clear;
  frmDM.qryVenda.SQL.Add('select * from venda, cliente where venData between '
  +QuotedStr(dt1)+' and '+QuotedStr(dt2)+
  ' and cliente.cliCodigo = venda.cliente_cliCodigo order by venda.venCodigo');

  RvProjectPeriodo.Open;
  RvProjectPeriodo.ExecuteReport('Report1');

end;

procedure TfrmRelVenda.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmRelVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabCliente.Close;
  frmDM.tabVenda.Close;
  frmDM.tabItemVenda.Close;
end;

procedure TfrmRelVenda.FormCreate(Sender: TObject);
begin
  frmDM.tabCliente.Close;
  frmDM.tabVenda.Close;
  frmDM.tabItemVenda.Close;
  frmDM.tabCliente.Open;
  frmDM.tabVenda.Open;
  frmDM.tabItemVenda.Open;
end;

procedure TfrmRelVenda.GerarExecute(Sender: TObject);
begin
  btnGerarClick(sender);
end;

end.
