unit uRelItemVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ImgList, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Mask, uDM, RpCon, RpConDS,
  RpBase, RpSystem, RpDefine, RpRave;

type
  TfrmRelItemVenda = class(TForm)
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
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    MaskEdit2: TMaskEdit;
    MaskEdit1: TMaskEdit;
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelItemVenda: TfrmRelItemVenda;

implementation

{$R *.dfm}

procedure TfrmRelItemVenda.btnCancelarClick(Sender: TObject);
begin
  frmRelItemVenda.Close;
end;

end.
