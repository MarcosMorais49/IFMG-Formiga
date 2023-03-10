unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ImgList, uPrincipal, uDM;

type
  TfrmLogin = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnOk: TToolButton;
    ToolButton19: TToolButton;
    btnSair: TToolButton;
    ToolButton21: TToolButton;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.btnOkClick(Sender: TObject);
begin
  frmlogin.close;
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from usuario where usuLogin = '
  +QuotedStr(Edit1.Text)+' and usuSenha = '+QuotedStr(Edit2.Text));
  frmDM.Consultas.Open;
  if frmDM.Consultas.IsEmpty then
  begin
    ShowMessage('Usu?rio ou senha inv?lido!');
    Application.Terminate;
  end
  else
  begin
    usuConectado := StrToInt(frmDM.Consultas.FieldByName('usuCodigo').Text);
    frmPrincipal := TfrmPrincipal.Create(Application);
    frmPrincipal.ShowModal;
    frmPrincipal.Release;
  end;
end;

end.
