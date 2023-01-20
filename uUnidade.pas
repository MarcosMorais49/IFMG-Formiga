unit uUnidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TfrmUnidade = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Salvar: TButton;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    dsUnidade: TDataSource;
    procedure SalvarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUnidade: TfrmUnidade;
  editGrav : boolean;
  codUn:integer;

implementation

{$R *.dfm}

procedure TfrmUnidade.Button1Click(Sender: TObject);
begin
  if Application.MessageBox('Tem certeza que deseja excluir a unidade selecionada?',
   'Confirmação', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
   begin
     frmDM.Consultas.Close;
     frmDM.Consultas.SQL.Clear;
     frmDM.Consultas.SQL.Add('Delete from unidade where undCodigo = '+QuotedStr(DBGrid1.Fields[0].Text));
     frmDM.Consultas.ExecSQL;
     frmDM.tabUnidade.Close;
     frmDM.tabUnidade.Open;
   end
   else
    abort;
end;

procedure TfrmUnidade.Button2Click(Sender: TObject);
begin
  Edit1.Text := DBGrid1.Fields[1].Text;
  editGrav := false;
  codUn := StrToInt(DBGrid1.Fields[0].text);
end;

procedure TfrmUnidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabUnidade.Close;
end;

procedure TfrmUnidade.FormCreate(Sender: TObject);
begin
  editGrav := true;

  frmDM.tabUnidade.Open;
end;

procedure TfrmUnidade.SalvarClick(Sender: TObject);
begin
  if editGrav = true then
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('Insert into unidade (undDescricao) value ('+QuotedStr(Edit1.Text)+')');
    frmDM.Consultas.ExecSQL;
  end
  else
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('Update unidade set undDescricao = '+QuotedStr(Edit1.Text)
    +' where undCodigo = '+IntToStr(codUn));
    frmDM.Consultas.ExecSQL;
  end;
  frmDM.tabUnidade.Close;
  frmDM.tabUnidade.Open;
  Edit1.Clear;
  editGrav := true;
end;

end.
