unit uEntradaNF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ImgList,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, uDM, Vcl.Mask, uPesqProduto;

type
  TfrmEntradaNF = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ToolBar1: TToolBar;
    btnNovo: TToolButton;
    ToolButton2: TToolButton;
    btnEditar: TToolButton;
    ToolButton4: TToolButton;
    btnSalvar: TToolButton;
    ToolButton17: TToolButton;
    btnExcluir: TToolButton;
    ToolButton19: TToolButton;
    btnCancelar: TToolButton;
    ToolButton21: TToolButton;
    btnSair: TToolButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    btnPesquisar: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label7: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    btnPesquisar1: TButton;
    StringGrid1: TStringGrid;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    ActionList1: TActionList;
    Novo: TAction;
    Editar: TAction;
    Salvar: TAction;
    Excluir: TAction;
    Cancelar: TAction;
    Sair: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnPesquisar1Click(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3Exit(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure EditarExecute(Sender: TObject);
    procedure SalvarExecute(Sender: TObject);
    procedure ExcluirExecute(Sender: TObject);
    procedure CancelarExecute(Sender: TObject);
    procedure SairExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure TabSheet2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure HabilitarEdicao(verdade : boolean);
    procedure LimpaTela();
    procedure LimpaVetor();
    procedure VerificaNF();
  end;

var
  frmEntradaNF: TfrmEntradaNF;

var  InsereAltera : Boolean;
  tempControle, tempForCodigo : integer;
  tempMpEstoque : array of real;
  tempMpCodigo : array of integer;

implementation

{$R *.dfm}

uses uPesqEntrada, uPesqFornecedor, uCadFornecedor;

procedure TfrmEntradaNF.btnCancelarClick(Sender: TObject);
begin
  InsereAltera := true;

  btnNovo.Enabled := True;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := false;
  btnPesquisar1.Enabled := True;

  LimpaTela;
  LimpaVetor;

  btnPesquisar1.SetFocus;
  Edit1.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  Edit7.Enabled := False;
  Edit8.Enabled := False;
  Edit9.Enabled := False;
  Edit10.Enabled := False;
  Edit11.Enabled := False;
  Edit12.Enabled := False;
  Edit13.Enabled := False;
  Edit14.Enabled := False;
  Edit15.Enabled := False;
  MaskEdit1.Enabled := False;
  MaskEdit2.Enabled := False;
  StringGrid1.Enabled := False;
  TabSheet1.Enabled := False;
  TabSheet2.Enabled := False
end;

procedure TfrmEntradaNF.btnEditarClick(Sender: TObject);
var i,j: Integer;
begin
  HabilitarEdicao(true);

  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := true;
  btnPesquisar1.Enabled := False;
  StringGrid1.Enabled := true;

  InsereAltera := false;

  tempControle := StrToInt(StringGrid1.Cells[5,1]);
  tempForCodigo := StrToInt(Edit1.Text);
  SetLength(tempMpEstoque, StringGrid1.RowCount -1);  //Determina o tamnho do array
  SetLength(tempMpCodigo, StringGrid1.RowCount -1);   //Determina o tamanho do array

  j:=1;
  for i := 0 to StringGrid1.RowCount -2 do
  begin            // carrega o array para diminuir o estoque mp ao salvar as altera��es
    tempMpCodigo[i] := StrToInt(StringGrid1.Cells[0,j]);
    tempMpEstoque[i] := StrToFloat(StringGrid1.Cells[3,j]);
    j:=j+1;
  end;

  Edit1.SetFocus;
end;

procedure TfrmEntradaNF.btnExcluirClick(Sender: TObject);
var i : integer;
begin
  if Application.MessageBox('Tem certeza que deseja excluir a entrada selecionada?',
   'Confirma��o', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    btnNovo.Enabled := True;
    btnEditar.Enabled := False;
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnCancelar.Enabled := False;
    btnSair.Enabled := True;
    btnPesquisar.Enabled := false;
    btnPesquisar1.Enabled := True;
    StringGrid1.Enabled := false;

    Edit1.Enabled := False;
    Edit3.Enabled := False;
    Edit4.Enabled := False;
    Edit7.Enabled := False;
    Edit8.Enabled := False;
    Edit9.Enabled := False;
    Edit10.Enabled := False;
    Edit11.Enabled := False;
    Edit12.Enabled := False;
    Edit13.Enabled := False;
    Edit14.Enabled := False;
    Edit15.Enabled := False;
    MaskEdit1.Enabled := False;
    MaskEdit2.Enabled := False;
    StringGrid1.Enabled := False;
    TabSheet1.Enabled := False;
    TabSheet2.Enabled := False;

    tempControle := StrToInt(StringGrid1.Cells[5,1]);

    with StringGrid1 do
      for I := 1 to StringGrid1.RowCount do
      begin
        frmDM.Consultas.Close;
        frmDM.Consultas.SQL.Clear;
        frmDM.Consultas.SQL.Add('update matPrima set mpEstoque = mpEstoque - '+QuotedStr(StringGrid1.Cells[3,i])
                      +' where mpCodigo = '+QuotedStr(StringGrid1.Cells[0,i]));
        frmDM.Consultas.ExecSQL;
      end;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('delete from entrada_matPrima where Entrada_entControle = '+QuotedStr(IntToStr(tempControle)));
    frmDM.Consultas.ExecSQL;

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('delete from entrada where entControle = '+QuotedStr(IntToStr(tempControle)));
    frmDM.Consultas.ExecSQL;

    LimpaTela;
    LimpaVetor;

    frmDM.tabEntrada.Close; //fechar e abrir tabela pra atualizar o grid
    frmDM.tabEntrada.Open;
  end
  else
    abort;
  StringGrid1.Refresh;
end;

procedure TfrmEntradaNF.btnNovoClick(Sender: TObject);
begin
  habilitarEdicao(true);

  btnNovo.Enabled := False;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;
  btnSair.Enabled := False;
  btnPesquisar.Enabled := true;
  btnPesquisar1.Enabled := False;
  StringGrid1.Enabled := true;

  LimpaTela;
  LimpaVetor;

  InsereAltera := True;
  StringGrid1.Refresh;
  Edit1.SetFocus;
end;

procedure TfrmEntradaNF.btnPesquisar1Click(Sender: TObject);
begin
  LimpaTela;

  pesqForn := 2;

  frmPesqEntrada := TfrmPesqEntrada.Create(Application);
  frmPesqEntrada.ShowModal;
  frmPesqEntrada.Release;
end;

procedure TfrmEntradaNF.btnPesquisarClick(Sender: TObject);
begin
  pesqForn := 3;
  frmPesqFornecedor := TfrmPesqFornecedor.Create(Application);
  frmPesqFornecedor.ShowModal;
  frmPesqFornecedor.Release;
end;

procedure TfrmEntradaNF.btnSairClick(Sender: TObject);
begin
  frmEntradaNF.Close;
end;

procedure TfrmEntradaNF.btnSalvarClick(Sender: TObject);
var i,a,b,c,d, prodTemp :integer;
    str, strnovo, aux, aux1,data,data1, contrTemp : string;
    DTaux, DTaux1 : TDate;
    st, ipi, acr, des, proTot, notaTot : real;
begin
  if edit7.text = ' ' then
    edit7.Text := '0';
  if edit8.text = ' ' then
    edit8.Text := '0';
  if edit10.text = ' ' then
    edit10.Text := '0';

  if Edit11.Text <> ' ' then
    st := StrToFloat(Edit11.Text)
  else
  begin
    st := 0;
    Edit11.Text := '0';
  end;

  if edit12.Text <> ' ' then
    ipi := StrToFloat(edit12.Text)
  else
  begin
    ipi := 0;
    edit12.Text := '0';
  end;

  if Edit13.Text <> ' ' then
    acr := StrToFloat(Edit13.Text)
  else
  begin
    acr := 0;
    Edit13.Text := '0';
  end;

  if Edit14.Text <> ' ' then
    des := StrToFloat(Edit14.Text)
  else
  begin
    des := 0;
    Edit14.Text := '0';
  end;

  if (Edit15.Text <> '') and (Edit15.Text <> ' ') and (StrToFloat(Edit15.Text) > 0) then
  begin
  proTot := StrToFloat(Edit9.Text);
  proTot := proTot + st + ipi + acr - des;
  notaTot := StrToFloat(Edit15.Text);

  if proTot = notaTot then
  begin
  DTaux := StrToDate(MaskEdit1.Text);
  DTaux1 := StrToDate(MaskEdit2.Text);
  if DTaux > DTaux1 then
    begin
      ShowMessage('Data de emiss�o n�o pode ser maior que a data de entrada!');
      Abort;
    end

  else
  begin
    Edit1.Enabled := False;
    Edit3.Enabled := False;
    Edit4.Enabled := False;
    Edit7.Enabled := False;
    Edit8.Enabled := False;
    Edit9.Enabled := False;
    Edit10.Enabled := False;
    Edit11.Enabled := False;
    Edit12.Enabled := False;
    Edit13.Enabled := False;
    Edit14.Enabled := False;
    Edit15.Enabled := False;
    MaskEdit1.Enabled := False;
    MaskEdit2.Enabled := False;
    StringGrid1.Enabled := False;
    TabSheet1.Enabled := False;
    TabSheet2.Enabled := False;

    btnNovo.Enabled := True;
    btnEditar.Enabled := true;
    btnExcluir.Enabled := True;
    btnSalvar.Enabled := False;
    btnCancelar.Enabled := False;
    btnSair.Enabled := True;
    btnPesquisar.Enabled := false;
    btnPesquisar1.Enabled := True;
    StringGrid1.Enabled := false;
    StringGrid1.Enabled := false;

    //converter data MaskEdit1
    aux := '';
    data := '';
    aux:=MaskEdit1.Text;
    data := data+aux[7];
    data := data+aux[8];
    data := data+aux[9];
    data := data+aux[10];
    data := data+aux[6];
    data := data+aux[4];
    data := data+aux[5];
    data := data+aux[3];
    data := data+aux[1];
    data := data+aux[2];

    //converter data MaskEdit2
    aux := '';
    data1 := '';
    aux:=MaskEdit2.Text;
    data1 := data1+aux[7];
    data1 := data1+aux[8];
    data1 := data1+aux[9];
    data1 := data1+aux[10];
    data1 := data1+aux[6];
    data1 := data1+aux[4];
    data1 := data1+aux[5];
    data1 := data1+aux[3];
    data1 := data1+aux[1];
    data1 := data1+aux[2];

    if InsereAltera = true then //Botao Novo
    begin
      frmDM.Consultas.Close;
      frmDM.Consultas.Sql.Clear;
      frmDM.Consultas.SQL.Add('insert into entrada (fornecedor_forCodigo, '
      + 'entNumero, entSerie, entEmissao, entEntrada, entTotal, entBaseIcms, entValorIcms, '
      + 'entIpi, entDesconto, entDespesa, entBaseSt, entValorSt, entLiquido) '
      + ' values ('+ QuotedStr(Edit1.text)+', '+QuotedStr(Edit3.Text)+', '+QuotedStr(Edit4.Text)
      + ', '+QuotedStr(data)+', '+QuotedStr(data1)
      + ', '+QuotedStr(StringReplace(Edit9.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit7.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit8.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit12.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit14.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit13.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit10.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit11.Text, ',', '.', [rfReplaceAll]))
      + ', '+QuotedStr(StringReplace(Edit15.Text, ',', '.', [rfReplaceAll]))+')');
      frmDM.Consultas.ExecSQL;

      frmDM.Consultas.Close;
      frmDM.Consultas.Sql.Clear;
      frmDM.Consultas.SQL.Add('select MAX(entControle) as ultimoReg from entrada');
      frmDM.Consultas.open;
      contrTemp := frmDM.Consultas.FieldByName('ultimoReg').AsString;

      for i := 1 to StringGrid1.RowCount -2 do
      begin
        frmDM.Consultas.Close;
        frmDM.Consultas.Sql.Clear;
        frmDM.Consultas.SQL.Add('insert into entrada_matPrima (Entrada_entControle, '
          + 'matPrima_mpCodigo, mp_nfQtde) '
          + ' values ('+QuotedStr(contrTemp)+', '+QuotedStr(StringGrid1.Cells[0,i])
          + ', '+QuotedStr(StringGrid1.Cells[3,i])+')');
        frmDM.Consultas.ExecSQL;

        {frmDM.Consultas.Close; // adiciona o codigoControleMp do registro para us�-lo na altera��o
        frmDM.Consultas.Sql.Clear;
        frmDM.Consultas.SQL.Add('select MAX(ent_mpControle) as ultimoReg from entrada_matPrima');
        frmDM.Consultas.open;
        StringGrid1.Cells[5,i] := frmDM.Consultas.FieldByName('ultimoReg').AsString; }
        StringGrid1.Cells[5,i] := contrTemp;

        frmDM.Consultas.Close;
        frmDM.Consultas.SQL.Clear;
        frmDM.Consultas.SQL.Add('update matPrima set mpEstoque = mpEstoque + '+QuotedStr(StringGrid1.Cells[3,i])
                      +' where mpCodigo = '+QuotedStr(StringGrid1.Cells[0,i]));
        frmDM.Consultas.ExecSQL;
        // atualiza o estoque do materia prima
      end;
      StringGrid1.RowCount := StringGrid1.RowCount -1;
    end

    else  //botao editar
    begin
      for i := 0 to High(tempMpEstoque) do  //high(tempMpEstoque) pega o tamanho do vertor
      begin
        aux := FloatToStr(tempMpEstoque[i]);
        aux1 := FloatToStr(tempMpCodigo[i]);

        frmDM.Consultas.Close;
        frmDM.Consultas.SQL.Clear;  // Retira o estoque da antiga mp, preparando para salvar as alteracoes
        frmDM.Consultas.SQL.Add('update matPrima set mpEstoque = mpEstoque - '+QuotedStr(aux)
                    +' where mpCodigo = '+QuotedStr(aux1));
        frmDM.Consultas.ExecSQL;
      end;

      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;//Deleta todos os itens do grid para adicionar os novos apos a alteracao
      frmDM.Consultas.SQL.Add('delete from entrada_matPrima where Entrada_entControle = '+IntToStr(tempControle));
      frmDM.Consultas.ExecSQL;
          //Os codigos acima retira o estoque antigo das Mp e deleta a inser��o de todas que est�o no grid
         //Os codigos abaixo far�o a nova inser��o com os dados alterados, incluisive novas movimenta��es no estoque MP
      frmDM.Consultas.Close;
      frmDM.Consultas.Sql.Clear;
      frmDM.Consultas.SQL.Add('update entrada set fornecedor_forCodigo = '+QuotedStr(Edit1.text)+','
                      + ' entNumero = '+QuotedStr(Edit3.text)+', entSerie = '+QuotedStr(Edit4.text)+','
                      + ' entEmissao = '+QuotedStr(data)+', entEntrada = '+QuotedStr(data1)+','
                      + ' entTotal = '+QuotedStr(StringReplace(Edit9.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entBaseIcms = '+QuotedStr(StringReplace(Edit7.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entValorIcms = '+QuotedStr(StringReplace(Edit8.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entIpi = '+QuotedStr(StringReplace(Edit12.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entDesconto = '+QuotedStr(StringReplace(Edit14.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entDespesa = '+QuotedStr(StringReplace(Edit13.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entBaseSt = '+QuotedStr(StringReplace(Edit10.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entValorSt = '+QuotedStr(StringReplace(Edit11.Text, ',', '.', [rfReplaceAll]))+','
                      + ' entLiquido = '+QuotedStr(StringReplace(Edit15.Text, ',', '.', [rfReplaceAll]))
                      + ' where entControle = '+IntToStr(tempControle));
      frmDM.Consultas.ExecSQL;

      for i := 1 to StringGrid1.RowCount -2 do
      begin
        frmDM.Consultas.Close;
        frmDM.Consultas.Sql.Clear;
        frmDM.Consultas.SQL.Add('insert into entrada_matPrima (Entrada_entControle, '
           + 'matPrima_mpCodigo, mp_nfQtde) '
           + ' values ('+QuotedStr(IntToStr(tempControle))+', '+QuotedStr(StringGrid1.Cells[0,i])
           + ', '+QuotedStr(StringGrid1.Cells[3,i])+')');
        frmDM.Consultas.ExecSQL;

        StringGrid1.Cells[5,i] := IntToStr(tempControle);

        frmDM.Consultas.Close;
        frmDM.Consultas.SQL.Clear;
        frmDM.Consultas.SQL.Add('update matPrima set mpEstoque = mpEstoque + '+QuotedStr(StringGrid1.Cells[3,i])
                       +' where mpCodigo = '+QuotedStr(StringGrid1.Cells[0,i]));
        frmDM.Consultas.ExecSQL;
        // atualiza o estoque do materia prima
      end;

    end;
    InsereAltera := true;
    frmDM.tabEntrada_mp.Close;
    frmDM.tabEntrada.Close;
    frmDM.tabEntrada_mp.Open;
    frmDM.tabEntrada.Open;
    StringGrid1.RowCount := StringGrid1.RowCount-1;
    StringGrid1.Refresh;
    LimpaVetor;
    end;
  end
  else
    ShowMessage('Valor total da nota difere do total informado!');
  end
  else
    ShowMessage('Valor Total NF Inv�lido!');
end;

procedure TfrmEntradaNF.Button1Click(Sender: TObject);
begin
  ShowMessage(QuotedStr(StringReplace(Edit15.Text, ',', '.', [rfReplaceAll])));
end;

procedure TfrmEntradaNF.CancelarExecute(Sender: TObject);
begin
  btnCancelarClick(sender);
end;

procedure TfrmEntradaNF.Edit1Exit(Sender: TObject);
begin
  frmDM.Consultas.Close;
  frmDM.Consultas.Sql.Clear;
  frmDM.Consultas.SQL.Add('select * from fornecedor where forCodigo = '
  +QuotedStr(Edit1.Text));
  frmDM.Consultas.open;
  Edit2.Text := frmDM.Consultas.FieldByName('forNome').AsString;

  if (Edit1.Text <> '') and (Edit3.Text <> '') and (InsereAltera = true) then
    VerificaNF

end;

procedure TfrmEntradaNF.Edit3Exit(Sender: TObject);
begin
  if InsereAltera = true then
    VerificaNF;
end;

procedure TfrmEntradaNF.EditarExecute(Sender: TObject);
begin
  btnEditarClick(sender);
end;

procedure TfrmEntradaNF.ExcluirExecute(Sender: TObject);
begin
  btnExcluirClick(sender);
end;

procedure TfrmEntradaNF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmDM.tabEntrada.close;
  frmDM.tabFornecedor.close;
  frmDM.tabEntrada_mp.close;
end;

procedure TfrmEntradaNF.FormCreate(Sender: TObject);
var i:integer;
begin
  frmDM.tabEntrada.Open;
  frmDM.tabFornecedor.Open;
  frmDM.tabEntrada_mp.Open;

  StringGrid1.Cells[0,0] := 'C�digo';
  StringGrid1.Cells[1,0] := 'Descri��o';
  StringGrid1.Cells[2,0] := 'Valor Unit.';
  StringGrid1.Cells[3,0] := 'Qtde';
  StringGrid1.Cells[4,0] := 'Valor Total';
 // StringGrid1.ColWidths[5] := 0; esse cod oculta a ultima coluna CtroleMP, mas aparece erro se ativar esse cod

  btnNovo.Enabled := True;
  btnEditar.Enabled := False;
  btnExcluir.Enabled := False;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;
  btnSair.Enabled := True;
  btnPesquisar.Enabled := false;
  btnPesquisar1.Enabled := true;

  For I:=1 to High(tempMpEstoque) Do
  tempMpEstoque[i] := 0;
  For I:=1 to High(tempMpCodigo) Do
  tempMpCodigo[i] := 0;
  tempControle := 0;

  pesqForn := 0;
end;



procedure TfrmEntradaNF.HabilitarEdicao(verdade : boolean);
begin
  Edit1.Enabled := true;
  Edit3.Enabled := true;
  Edit4.Enabled := true;
  Edit7.Enabled := true;
  Edit8.Enabled := true;
  Edit9.Enabled := true;
  Edit10.Enabled := true;
  Edit11.Enabled := true;
  Edit12.Enabled := true;
  Edit13.Enabled := true;
  Edit14.Enabled := true;
  Edit15.Enabled := true;
  MaskEdit1.Enabled := true;
  MaskEdit2.Enabled := true;
  Panel1.Enabled := true;
  StringGrid1.Enabled := true;
  PageControl1.Enabled := true;
  TabSheet1.Enabled := true;
  TabSheet2.Enabled := true
end;

procedure TfrmEntradaNF.LimpaTela;
var
  i: Integer;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit7.Text := ' ';
  Edit8.Text := ' ';
  Edit9.clear;
  Edit10.Text := ' ';
  Edit11.Text := ' ';
  Edit12.Text := ' ';
  Edit13.Text := ' ';
  Edit14.Text := ' ';
  Edit15.Clear;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  for I := 1 to StringGrid1.RowCount -1 do
  begin
    StringGrid1.Cells[0,i] := '';
    StringGrid1.Cells[1,i] := '';
    StringGrid1.Cells[2,i] := '';
    StringGrid1.Cells[3,i] := '';
    StringGrid1.Cells[4,i] := '';
    StringGrid1.Cells[5,i] := '';
  end;
  StringGrid1.RowCount:=2;
end;

procedure TfrmEntradaNF.LimpaVetor;
var
  I: Integer;
begin
    FillChar(tempMpCodigo, SizeOf(tempForCodigo), #0);
    FillChar(tempMpEstoque, SizeOf(tempMpEstoque), #0);
end;

procedure TfrmEntradaNF.SairExecute(Sender: TObject);
begin
  btnSairClick(sender);
end;

procedure TfrmEntradaNF.SalvarExecute(Sender: TObject);
begin
  btnSalvarClick(sender);
end;

procedure TfrmEntradaNF.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var cl, ln, ln_atual: integer;
begin
if key = vk_delete then
begin
//vai da linha atual at� a �ltima (pois a primeira � zero)
for ln:= StringGrid1.Row to StringGrid1.RowCount - 1 do
for cl:= 0 to StringGrid1.ColCount -1 do
StringGrid1.Cells[cl, ln]:= StringGrid1.Cells[cl, ln+1];
//diminui uma linha
StringGrid1.RowCount := StringGrid1.RowCount -1;
end;
end;


procedure TfrmEntradaNF.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var i: integer;
      a,b,tot : real;
begin
  if (ACol = 1) or (ACol = 2) or (ACol = 4) then
    begin
        StringGrid1.Options:=StringGrid1.Options - [goEditing];
    end

  else
        StringGrid1.Options:=StringGrid1.Options + [goEditing];
 // O cod acima habilita os campos edit�veis da grid

  for i := 1 to StringGrid1.RowCount +1 do
  begin
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select * from matPrima where mpCodigo = '
    +QuotedStr(StringGrid1.Cells[0,i]));
    frmDM.Consultas.Open;
    if (frmDM.Consultas.IsEmpty) and (StringGrid1.Cells[0,i] <> '') then
    begin
      ShowMessage('C�dgio n�o Cadastrado!');
      StringGrid1.Cells[0,i] := '';
    end
    else
    begin
      frmDM.qryUnidade.Close;
      frmDM.qryUnidade.SQL.Clear;
      frmDM.qryUnidade.SQL.Add('select * from unidade where undCodigo = '
      +QuotedStr(frmDM.Consultas.FieldByName('mp_undCodigo').AsString));
      frmDM.qryUnidade.Open;

      StringGrid1.Cells[1,i] := frmDM.Consultas.FieldByName('mpDescricao').AsString;
      if StringGrid1.Cells[1,i] <> '' then
        StringGrid1.Cells[1,i] := StringGrid1.Cells[1,i]+' '+frmDM.qryUnidade.FieldByName('undDescricao').AsString;
      StringGrid1.Cells[2,i] := frmDM.Consultas.FieldByName('mpPCusto').AsString;
      frmDM.Consultas.Close;
      if (StringGrid1.Cells[3,i] <> '') and (strtoint(StringGrid1.Cells[3,i]) > 0)then
        begin
          a := StrToFloat(StringGrid1.Cells[3,i]);
          b := StrToFloat(StringGrid1.Cells[2,i]);
          tot := a * b;
          StringGrid1.Cells[4,i] := FloatToStr(tot);
        end

      else
        StringGrid1.Cells[4,i] := ''
    end;

  end;
  if StringGrid1.Cells[1,StringGrid1.RowCount -1] <> '' then
    StringGrid1.RowCount := StringGrid1.RowCount + 1;    // adiciona linhas quando necessario

end;

procedure TfrmEntradaNF.TabSheet2Exit(Sender: TObject);
var totProdutos:real;
    i:integer;
begin
  totProdutos := 0;
  for i := 1 to StringGrid1.RowCount - 2 do
  begin
    totProdutos :=totProdutos + StrToFloat(StringGrid1.Cells[4,i]);
  end;
  Edit9.Text := FloatToStr(totProdutos); //insere valores de produtos
end;

procedure TfrmEntradaNF.VerificaNF;
begin
  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from entrada where entNumero = '+QuotedStr(Edit3.Text)
    +' and fornecedor_forCodigo = '+QuotedStr(Edit1.Text));
  frmDM.Consultas.Open;
  if frmDM.Consultas.RecordCount <> 0 then
  begin
    ShowMessage('Nota Fiscal j� cadastrada para este fornecedor');
    Edit3.Clear;
    Edit3.SetFocus;
  end;
end;

procedure TfrmEntradaNF.MaskEdit2Exit(Sender: TObject);
var aux, aux1 : TDate;
begin
try
  StrToDate(maskedit2.Text);
   except
     on EConvertError do
     begin
       ShowMessage('Data Inv�lida!');
       maskedit2.SetFocus;
     end;
end;

if (MaskEdit1.Text <> '  /  /    ') and (MaskEdit2.Text <> '  /  /    ') then
  begin
    aux := StrToDate(MaskEdit1.Text);  //Verifica se a data de emiss�o � maior que a data
    aux1 := StrToDate(MaskEdit2.Text);            // de entrada
    if aux > aux1 then
      ShowMessage('Data de emiss�o n�o pode ser maior que a data de entrada!')
  end

end;

procedure TfrmEntradaNF.NovoExecute(Sender: TObject);
begin
  btnNovoClick(sender);
end;

end.
