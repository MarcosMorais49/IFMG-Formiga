unit uPesqCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, strUtils;

type
  TfrmPesqCliente = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    dsPCliente: TDataSource;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesqCliente: TfrmPesqCliente;
  tipoForm : Boolean;

implementation

{$R *.dfm}

uses uCadCliente, uVenda;

procedure TfrmPesqCliente.Button1Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
    frmDM.tabCliente.Filtered := false;
    frmDM.tabCliente.Filter := 'cliNome like '+QuotedStr(Edit1.Text+'%');
    frmDM.tabCliente.Filtered := true;
  end
  else
  begin
    frmDM.tabCliente.Filtered := false;
    frmDM.tabCliente.Filter := '';
    frmDM.tabCliente.Filtered := true;
  end
end;

procedure TfrmPesqCliente.DBGrid1DblClick(Sender: TObject);
var temp : string;
begin
  if tipoForm = false then
  begin
    frmCadCliente.Edit1.Text := DBGrid1.Fields[0].AsString;
    frmCadCliente.Edit2.Text := DBGrid1.Fields[1].AsString;
    frmCadCliente.Edit3.Text := DBGrid1.Fields[2].AsString;
    frmCadCliente.Edit4.Text := DBGrid1.Fields[3].AsString;
    frmCadCliente.Edit5.Text := DBGrid1.Fields[4].AsString;
    frmCadCliente.Edit6.Text := DBGrid1.Fields[9].AsString;
    frmCadCliente.MaskEdit1.Text := DBGrid1.Fields[7].AsString;
    frmCadCliente.MaskEdit2.Text := DBGrid1.Fields[8].AsString;
    frmCadCliente.MaskEdit3.Text := DBGrid1.Fields[5].AsString;
    frmCadCliente.MaskEdit4.Text := DBGrid1.Fields[10].AsString;
    frmCadCliente.RadioGroup1.ItemIndex := StrToInt(DBGrid1.Fields[11].AsString);
    temp := DBGrid1.Fields[6].AsString;
    case AnsiIndexStr(temp, ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS',
         'MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO']) of

      0 : frmCadCliente.ComboBox1.ItemIndex := 0;
      1 : frmCadCliente.ComboBox1.ItemIndex := 1;
      2 : frmCadCliente.ComboBox1.ItemIndex := 2;
      3 : frmCadCliente.ComboBox1.ItemIndex := 3;
      4 : frmCadCliente.ComboBox1.ItemIndex := 4;
      5 : frmCadCliente.ComboBox1.ItemIndex := 5;
      6 : frmCadCliente.ComboBox1.ItemIndex := 6;
      7 : frmCadCliente.ComboBox1.ItemIndex := 7;
      8 : frmCadCliente.ComboBox1.ItemIndex := 8;
      9 : frmCadCliente.ComboBox1.ItemIndex := 9;
      10 : frmCadCliente.ComboBox1.ItemIndex := 10;
      11 : frmCadCliente.ComboBox1.ItemIndex := 11;
      12 : frmCadCliente.ComboBox1.ItemIndex := 12;
      13 : frmCadCliente.ComboBox1.ItemIndex := 13;
      14 : frmCadCliente.ComboBox1.ItemIndex := 14;
      15 : frmCadCliente.ComboBox1.ItemIndex := 15;
      16 : frmCadCliente.ComboBox1.ItemIndex := 16;
      17 : frmCadCliente.ComboBox1.ItemIndex := 17;
      18 : frmCadCliente.ComboBox1.ItemIndex := 18;
      19 : frmCadCliente.ComboBox1.ItemIndex := 19;
      20 : frmCadCliente.ComboBox1.ItemIndex := 20;
      21 : frmCadCliente.ComboBox1.ItemIndex := 21;
      22 : frmCadCliente.ComboBox1.ItemIndex := 22;
      23 : frmCadCliente.ComboBox1.ItemIndex := 23;
      24 : frmCadCliente.ComboBox1.ItemIndex := 24;
      25 : frmCadCliente.ComboBox1.ItemIndex := 25;
      26 : frmCadCliente.ComboBox1.ItemIndex := 26;

    end;

    frmCadCliente.btnNovo.Enabled := True;
    frmCadCliente.btnEditar.Enabled := true;
    frmCadCliente.btnExcluir.Enabled := true;
    frmCadCliente.btnSalvar.Enabled := false;
    frmCadCliente.btnCancelar.Enabled := False;
    frmCadCliente.btnSair.Enabled := True;
    frmCadCliente.btnPesquisar.Enabled := True;
    end
    else
    begin
       frmVenda.Edit2.Text := DBGrid1.Fields[0].AsString;
       frmVenda.Edit1.Text := DBGrid1.Fields[1].AsString;

       frmVenda.btnPesuisarItem.Enabled := true;
       frmVenda.btnFinalizar.Enabled := true;
       frmVenda.btnCancelar.Enabled := true;
       frmVenda.StringGrid1.Enabled := true;
       frmVenda.btnSair.Enabled := false;
    end;

  frmPesqCliente.Close;
end;

procedure TfrmPesqCliente.FormCreate(Sender: TObject);
begin
  frmDM.tabCliente.Filtered := false;
  frmDM.tabCliente.Filter := '';
  frmDM.tabCliente.Filtered := true;
end;

end.
