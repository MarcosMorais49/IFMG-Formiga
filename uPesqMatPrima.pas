unit uPesqMatPrima;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPesqMatPrima = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    dsMatPrima: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesqMatPrima: TfrmPesqMatPrima;
  pesqMp :integer;

implementation

uses uCadMatPrima, uCadReceita;

{$R *.dfm}

procedure TfrmPesqMatPrima.Button1Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    frmDM.tabMp.Filtered := false;
    frmDM.tabMp.Filter := 'mpDescricao like '+QuotedStr(Edit1.Text+'%');
    frmDM.tabMp.Filtered := true;
  end
  else
  begin
    frmDM.tabMp.Filtered := false;
    frmDM.tabMp.Filter := '';
    frmDM.tabMp.Filtered := true;
  end
end;

procedure TfrmPesqMatPrima.DBGrid1DblClick(Sender: TObject);
var temp : integer;
begin
  if pesqMp = 1 then
  begin
    frmCadMatPrima.Edit1.Text := DBGrid1.Fields[0].AsString;
    frmCadMatPrima.Edit2.Text := DBGrid1.Fields[1].AsString;
    frmCadMatPrima.Edit3.Text := DBGrid1.Fields[2].AsString;
    frmCadMatPrima.Edit4.Text := DBGrid1.Fields[3].AsString;
    frmCadMatPrima.Edit5.Text := DBGrid1.Fields[4].AsString;
    temp := StrToInt(DBGrid1.Fields[5].AsString);
    frmCadMatPrima.DBLookupComboBox1.KeyValue :=  temp;

    frmCadMatPrima.btnNovo.Enabled := True;
    frmCadMatPrima.btnEditar.Enabled := true;
    frmCadMatPrima.btnExcluir.Enabled := true;
    frmCadMatPrima.btnSalvar.Enabled := False;
    frmCadMatPrima.btnCancelar.Enabled := False;
    frmCadMatPrima.btnSair.Enabled := True;
    frmCadMatPrima.btnPesquisar.Enabled := True;
  end

  else if pesqMp = 2 then
  begin
    temp := frmCadReceita.StringGrid1.RowCount;
    frmDM.qryUnidade.Close;
    frmDM.qryUnidade.SQL.Clear;
    frmDM.qryUnidade.SQL.Add('select * from unidade where undCodigo = '
    +QuotedStr(DBGrid1.Fields[5].AsString));
    frmDM.qryUnidade.Open;

    frmCadReceita.StringGrid1.Cells[0, temp -1] := DBGrid1.Fields[0].AsString;
    frmCadReceita.StringGrid1.Cells[1, temp -1] := DBGrid1.Fields[1].AsString
       +' '+frmDM.qryUnidade.FieldByName('undDescricao').AsString;
  end;


  frmPesqMatPrima.Close;
end;

procedure TfrmPesqMatPrima.FormCreate(Sender: TObject);
begin
  frmDM.tabMp.Filtered := false;
  frmDM.tabMp.Filter := '';
  frmDM.tabMp.Filtered := true;
end;

end.
