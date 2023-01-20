unit uRelReceitasComponentes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ImgList, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, uDM, uPesqProduto, RpCon, RpConDS,
  RpBase, RpSystem, RpDefine, RpRave;

type
  TfrmRelReceitasComponentes = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnGerar: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    ActionList1: TActionList;
    Gerar: TAction;
    Cancelar: TAction;
    ImageList2: TImageList;
    ImageList1: TImageList;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    RvProjectProdRec: TRvProject;
    RvSystemProdRec: TRvSystem;
    RVDSReceita: TRvDataSetConnection;
    RVDSItens_Receita: TRvDataSetConnection;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnGerarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure GerarExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelReceitasComponentes: TfrmRelReceitasComponentes;

implementation

{$R *.dfm}

procedure TfrmRelReceitasComponentes.btnCancelarClick(Sender: TObject);
begin
  frmRelReceitasComponentes.Close;
end;

procedure TfrmRelReceitasComponentes.btnGerarClick(Sender: TObject);
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then
  begin
    frmDM.qryReceita.close;
    frmDM.qryReceita.SQL.Clear;
    frmDM.qryReceita.SQL.Add('select * from receita where recCodigo = '+Edit1.Text);
  end
  else
  begin
    frmDM.qryReceita.close;
    frmDM.qryReceita.SQL.Clear;
    frmDM.qryReceita.SQL.Add('select * from receita');
  end;
  RvProjectProdRec.Open;
  RvProjectProdRec.ExecuteReport('Report1');
end;

procedure TfrmRelReceitasComponentes.Button1Click(Sender: TObject);
begin
  pesqProd := 5;

  frmPesqProduto := tfrmPesqProduto.Create(Application);
  frmPesqProduto.ShowModal;
  frmPesqProduto.Release;
end;

procedure TfrmRelReceitasComponentes.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(Sender);
end;

procedure TfrmRelReceitasComponentes.Edit1Exit(Sender: TObject);
var temp : integer;
begin
  if Edit1.Text <> '' then
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select * from receita where recCodigo ='+Edit1.text);
    frmDM.Consultas.open;
    if frmDM.Consultas.IsEmpty then
      ShowMessage('Codigo da receita invalido!')
    else
    begin
      temp := StrToInt(frmDM.Consultas.FieldByName('Produto_proCodigo').AsString);
      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;
      frmDM.Consultas.SQL.Add('select * from produto where proCodigo ='+QuotedStr(IntToStr(temp)));
      frmDM.Consultas.open;
      Edit2.Text := frmDM.Consultas.FieldByName('proDescricao').AsString;
    end;
  end;
end;

procedure TfrmRelReceitasComponentes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmDM.tabReceita.Close;
  frmDM.tabMpReceita.Close;
  frmDM.qryReceita.Close;
  frmDM.qryMpReceita.Close;
end;

procedure TfrmRelReceitasComponentes.FormCreate(Sender: TObject);
begin
  frmDM.tabReceita.Close;
  frmDM.tabMpReceita.Close;
  frmDM.qryReceita.Close;
  frmDM.qryMpReceita.Close;

  frmDM.tabReceita.open;
  frmDM.tabMpReceita.open;
  frmDM.qryReceita.open;
  frmDM.qryMpReceita.open;

end;

procedure TfrmRelReceitasComponentes.GerarExecute(Sender: TObject);
begin
  btnGerarClick(Sender);
end;

end.
