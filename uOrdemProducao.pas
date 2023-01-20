unit uOrdemProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, uDM, Data.DB, uCriarOP,
  RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave, Vcl.ActnList,
  Data.Win.ADODB;

type
  TfrmOrdemProducao = class(TForm)
    ToolBar1: TToolBar;
    btnNovo: TToolButton;
    ToolButton2: TToolButton;
    btnEditar: TToolButton;
    ToolButton4: TToolButton;
    btnCriticar: TToolButton;
    ToolButton17: TToolButton;
    btnExcluir: TToolButton;
    ToolButton19: TToolButton;
    btnAtualizar: TToolButton;
    ToolButton21: TToolButton;
    btnSair: TToolButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    RvItensProducao: TRvProject;
    RvSystemItemProducao: TRvSystem;
    RVConexaoItemProducaoOP: TRvDataSetConnection;
    RVConexaoProducaoOP: TRvDataSetConnection;
    ActionList1: TActionList;
    Criar: TAction;
    Digitar: TAction;
    Criticar: TAction;
    Atualizar: TAction;
    Excluir: TAction;
    Sair: TAction;
    btnAutorizar: TToolButton;
    ToolButton1: TToolButton;
    ConsultaAux: TADOQuery;
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnCriticarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btnAutorizarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOrdemProducao: TfrmOrdemProducao;

implementation

{$R *.dfm}
uses uDigitarOP;

procedure TfrmOrdemProducao.btnAtualizarClick(Sender: TObject);
var x,i : integer;
    aux : boolean;
begin
  aux := True;//variavel controla se a digita��o est� correta qtdePrevista x qtdeUsada
  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('Select * from producao where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));
  frmDM.Consultas.Open;
  if (frmDM.Consultas.FieldByName('pdcStatus').AsString = 'Criticado') then
  begin   // Se o status � criticado, pode prosseguir a atualiza��o, caso contrario n�o prossiga
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('select * from itens_producao where itPdc_pdcCodigo = '
    +QuotedStr(DBGrid1.Fields[0].AsString));
    frmDM.Consultas.Open;//verifica se as quantidades foram digitadas corretamente
    x := frmDM.Consultas.RecordCount;
    frmDM.Consultas.First;
    for I := 1 to x-1 do
    begin
      if (frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString <>
      frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString) then
         aux := False;
      frmDM.Consultas.Next;
    end;

    if aux = True then // Se as qtdes foram digitadas iguais, prossiga a atualiza��o
    begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('update produto set proEstoque = proEstoque + '
    +QuotedStr(StringReplace(DBGrid1.Fields[3].AsString, ',', '.', [rfReplaceAll]))
    +' where proCodigo = '+QuotedStr(DBGrid1.Fields[8].AsString));
    frmDM.Consultas.ExecSQL; //Atualiza o estoque dos produtos

    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('update producao set pdcStatus = '+QuotedStr('Atualizado')
    +' where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));
    frmDM.Consultas.ExecSQL;//atualiza o status da produ��o para Atualizado

    ShowMessage('Ordem de Produ��o Atualizada!');
    end
    else
      ShowMessage('Atualiza��o n�o realizada, verifique se as quantidades foram digitadas corretamente!');
  end //Caso haja erro na digita�ao(qtdes divergentes), aparece a msg acima
  else
    ShowMessage('Atualiza��o n�o realizada, verifique se a produ��o foi digitada e criticada!');
    // Caso a produ��o ainda n�o esteja com status criticado, aparece a msg acima

  frmDM.tabProducao.Close;
  frmDM.tabProducao.Open;
  DBGrid1.Refresh;
end;

procedure TfrmOrdemProducao.btnAutorizarClick(Sender: TObject);
var result : real;
begin
  result := 0;
  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from itens_producao where itPdc_pdcCodigo = '
  +QuotedStr(DBGrid1.Fields[0].asstring));
  frmDM.Consultas.open; //consulta se ha divergencias entre qtde usada e qtde prevista
  frmDM.Consultas.First;
  while not frmDM.Consultas.eof do
  begin
    if frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString <>
        frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString then //caso haja divergencia
    begin                                                     //entre qtde usada x prevista
      if frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString <
        frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString then //verifica se a qtdePrev
      begin                                                           // � menor que a usada
        result := Strtofloat(frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString) -
        strtofloat(frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString);
                             //acha a diferen�a para baixar o estoque MP

        ConsultaAux.Close;
        ConsultaAux.SQL.Clear; //baixa o estoque de MP com as quantidades que faltam
        ConsultaAux.SQL.Add('update matPrima set mpEstoque = mpEstoque - '
        +QuotedStr(StringReplace(FloatToStr(result), ',', '.', [rfReplaceAll]))
        +' where mpCodigo = '+QuotedStr(frmDM.Consultas.FieldByName('itPdc_mpCodigo').AsString));
        ConsultaAux.ExecSQL;
      end

      else if frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString > //ou se a qtdePrev
        frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString then   // � menor que a usada
      begin
        result := Strtofloat(frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString) -
        strtofloat(frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString);
                           //acha a diferen�a para somar o estoque MP

        ConsultaAux.Close;
        ConsultaAux.SQL.Clear; //soma a qtde de sobra ao estoque MP
        ConsultaAux.SQL.Add('update matPrima set mpEstoque = mpEstoque + '
        +QuotedStr(StringReplace(FloatToStr(result), ',', '.', [rfReplaceAll]))
        +' where mpCodigo = '+QuotedStr(frmDM.Consultas.FieldByName('itPdc_mpCodigo').AsString));
        ConsultaAux.ExecSQL;
      end;

    end;

    frmDM.Consultas.Next;
  end;

  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('update produto set proEstoque = proEstoque + '
  +QuotedStr(StringReplace(DBGrid1.Fields[3].AsString, ',', '.', [rfReplaceAll]))
  +' where proCodigo = '+QuotedStr(DBGrid1.Fields[8].AsString));
  frmDM.Consultas.ExecSQL; //Atualiza o estoque dos produtos

  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('update producao set pdcStatus = '+QuotedStr('Atualizado')
  +' where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));
  frmDM.Consultas.ExecSQL;//atualiza o status da produ��o para Atualizado

  ShowMessage('Ordem de Produ��o Atualizada!');

  frmDM.tabProducao.Close;
  frmDM.tabProducao.Open;
  DBGrid1.Refresh;
end;

procedure TfrmOrdemProducao.btnCriticarClick(Sender: TObject);
begin
  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('Select * from producao where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));
  frmDM.Consultas.Open;
  if (frmDM.Consultas.FieldByName('pdcStatus').AsString = 'Digitado') or
     (frmDM.Consultas.FieldByName('pdcStatus').AsString = 'Criticado') then
  begin
    frmDM.Consultas.Close;
    frmDM.Consultas.SQL.Clear;
    frmDM.Consultas.SQL.Add('update producao set pdcStatus = '+QuotedStr('Criticado')
    +' where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));;
    frmDM.Consultas.ExecSQL;

    frmDM.qryProducao.Close;
    frmDM.qryProducao.SQL.Clear;
    frmDM.qryProducao.SQL.Add('Select * from producao where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));

    RvItensProducao.Open;
    RvItensProducao.ExecuteReport('Report1');

    ShowMessage('Ordem de Produ��o Criticada!');
  end
  else
    ShowMessage('N�o � poss�vel criticar a produ��o! Produ��o n�o digitada');

  frmDM.tabProducao.Close;
  frmDM.tabProducao.Open;
  DBGrid1.Refresh;
end;

procedure TfrmOrdemProducao.btnEditarClick(Sender: TObject);
begin
  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('Select * from producao where pdcCodigo = '+QuotedStr(DBGrid1.Fields[0].AsString));
  frmDM.Consultas.Open;
  if (frmDM.Consultas.FieldByName('pdcStatus').AsString = 'Incluido') or
     (frmDM.Consultas.FieldByName('pdcStatus').AsString = 'Criticado') then
     begin
       frmDM.Consultas.Close;
       frmDM.Consultas.SQL.Clear;
       frmDM.Consultas.SQL.Add('select * from itens_producao where itPdc_pdcCodigo = '
        +QuotedStr(DBGrid1.Fields[0].AsString));
       frmDM.Consultas.Open;

       frmDigitarOP := TfrmDigitarOP.Create(Application);
       frmDigitarOP.StringGrid1.RowCount := frmDM.Consultas.RecordCount+1;
       frmDigitarOP.ShowModal;
       frmDigitarOP.Release;
     end
     else
      ShowMessage('Produ��o n�o pode ser digitada!');
end;

procedure TfrmOrdemProducao.btnExcluirClick(Sender: TObject);
var tempOP, x,i :integer;
    tempCodMp : array of integer;
    tempQtde  : array of real;
begin
  tempOP := StrToInt(DBGrid1.Fields[0].AsString);

  frmDM.Consultas.Close;
  frmDM.Consultas.SQL.Clear;
  frmDM.Consultas.SQL.Add('select * from producao where pdcCodigo = '+QuotedStr(IntToStr(tempOP)));
  frmDM.Consultas.Open;
  if (frmDM.Consultas.FieldByName('pdcStatus').AsString = 'Atualizado') then
    ShowMessage('Produ��o atualizada n�o pode ser exclu�da!')
  else
  begin
    if Application.MessageBox('Tem certeza que deseja excluir a produ��o selecionada?',
   'Confirma��o', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    begin
      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;
      frmDM.Consultas.SQL.Add('select * from itens_producao where itPdc_pdcCodigo = '
      +QuotedStr(IntToStr(tempOP)));
      frmDM.Consultas.Open;
      x := frmDM.Consultas.RecordCount; //verifica a qtde de resultados da consulta acima para
      SetLength(tempCodMp,x);  // definir o tamanho dos dois vetores
      SetLength(tempQtde,x);   // SetLength define o tamanho dos vetores
      frmDM.Consultas.First;
      for i := 0 to x-1 do
      begin
        tempCodMp[i] := StrToInt(frmDM.Consultas.FieldByName('itPdc_mpCodigo').AsString);
        tempQtde[i]  := StrToFloat(frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString);
        frmDM.Consultas.Next; // Carrega os vetores com cod e qtde para diminuir o estoque MP
      end;

      for I := 0 to x-1 do
      begin
        frmDM.Consultas.Close;
        frmDM.Consultas.SQL.Clear;
        frmDM.Consultas.SQL.Add('update matPrima set mpEstoque = mpEstoque + '
        +QuotedStr(StringReplace(FloatToStr(tempQtde[i]), ',', '.', [rfReplaceAll]))
        +' where mpCodigo = '+QuotedStr(IntToStr(tempCodMp[i])));
        frmDM.Consultas.ExecSQL;
      end;

      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;
      frmDM.Consultas.SQL.Add('delete from itens_producao where itPdc_pdcCodigo = '
      +QuotedStr(IntToStr(tempOP)));
      frmDM.Consultas.ExecSQL;

      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;
      frmDM.Consultas.SQL.Add('delete from producao where pdcCodigo = '+QuotedStr(IntToStr(tempOP)));
      frmDM.Consultas.ExecSQL;
    end
    else
      abort;
  end;
  frmDM.tabProducao.Close;
  frmDM.tabProducao.Open;
  DBGrid1.Refresh;
end;

procedure TfrmOrdemProducao.btnNovoClick(Sender: TObject);
begin
  frmCriarOP := TfrmCriarOP.Create(Application);
  frmCriarOP.ShowModal;
  frmCriarOP.Release;
end;

procedure TfrmOrdemProducao.btnSairClick(Sender: TObject);
begin
  frmOrdemProducao.Close;
end;

procedure TfrmOrdemProducao.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex = 2 then
  begin
    frmDM.tabProducao.Filtered := false;
    frmDM.tabProducao.Filter := 'pdcStatus like '+QuotedStr('Incluido')
    +' or pdcStatus like '+QuotedStr('Criticado')
    +' or pdcStatus like '+QuotedStr('Digitado');
    frmDM.tabProducao.Filtered := true;
  end
  else if ComboBox1.ItemIndex = 1 then
  begin
    frmDM.tabProducao.Filtered := false;
    frmDM.tabProducao.Filter := 'pdcStatus like '+QuotedStr('Atualizado');
    frmDM.tabProducao.Filtered := true;
  end
  else
  begin
    frmDM.tabProducao.Filtered := false;
    frmDM.tabProducao.Filter := '';
    frmDM.tabProducao.Filtered := true;
  end;
end;

procedure TfrmOrdemProducao.DataSource1DataChange(Sender: TObject;
  Field: TField);
  var dif : boolean;
begin
  if DBGrid1.Fields[6].AsString = 'Crit' then
    begin
      frmDM.Consultas.Close;
      frmDM.Consultas.SQL.Clear;
      frmDM.Consultas.SQL.Add('select * from itens_producao where itPdc_pdcCodigo = '
      +QuotedStr(DBGrid1.Fields[0].asstring));
      frmDM.Consultas.open;
      frmDM.Consultas.First;
      dif := false;
      while not frmDM.Consultas.eof do
      begin
        if frmDM.Consultas.FieldByName('itPdcQtdePrevista').AsString <>
            frmDM.Consultas.FieldByName('itPdcQtdeUsada').AsString then
            dif:= true;
        frmDM.Consultas.Next;
      end;

      if dif = true then
        btnAutorizar.Enabled := true
    end

  else
    btnAutorizar.Enabled := false;
end;

procedure TfrmOrdemProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmDM.tabReceita.Close;
  frmDM.tabProduto.Close;
  frmDM.tabMp.Close;
  frmDM.tabProducao.Close;
  frmDM.tabItemProducao.Close;
end;

procedure TfrmOrdemProducao.FormCreate(Sender: TObject);
begin
   frmDM.tabReceita.Open;
   frmDM.tabProduto.Open;
   frmDM.tabMp.Open;
   frmDM.tabProducao.Open;
   frmDM.tabItemProducao.Open;

   frmDM.tabProducao.Filtered := false;
    frmDM.tabProducao.Filter := 'pdcStatus like '+QuotedStr('Incluido')
    +' or pdcStatus like '+QuotedStr('Criticado')
    +' or pdcStatus like '+QuotedStr('Digitado');
    frmDM.tabProducao.Filtered := true;
end;

end.
