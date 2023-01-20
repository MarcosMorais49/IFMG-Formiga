program prjPadaria;

uses
  Vcl.Forms,
  uDM in 'uDM.pas' {frmDM: TDataModule},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uCadUsuario in 'uCadUsuario.pas' {frmCadUsuario},
  uCadCliente in 'uCadCliente.pas' {frmCadCliente},
  uCadFornecedor in 'uCadFornecedor.pas' {frmCadFornecedor},
  uCadProduto in 'uCadProduto.pas' {frmCadProduto},
  uCadMatPrima in 'uCadMatPrima.pas' {frmCadMatPrima},
  uCadReceita in 'uCadReceita.pas' {frmCadReceita},
  uPesqCliente in 'uPesqCliente.pas' {frmPesqCliente},
  uPesqUsuario in 'uPesqUsuario.pas' {frmPesqUsuario},
  uPesqFornecedor in 'uPesqFornecedor.pas' {frmPesqFornecedor},
  uPesqMatPrima in 'uPesqMatPrima.pas' {frmPesqMatPrima},
  uPesqProduto in 'uPesqProduto.pas' {frmPesqProduto},
  uUnidade in 'uUnidade.pas' {frmUnidade},
  uEntradaNF in 'uEntradaNF.pas' {frmEntradaNF},
  uPesqEntrada in 'uPesqEntrada.pas' {frmPesqEntrada},
  uOrdemProducao in 'uOrdemProducao.pas' {frmOrdemProducao},
  uVenda in 'uVenda.pas' {frmVenda},
  uFinalizar in 'uFinalizar.pas' {frmFinalizar},
  uCriarOP in 'uCriarOP.pas' {frmCriarOP},
  uDigitarOP in 'uDigitarOP.pas' {frmDigitarOP},
  uRelReceitasComponentes in 'uRelReceitasComponentes.pas' {frmRelReceitasComponentes},
  uRelEstoqueProdutos in 'uRelEstoqueProdutos.pas' {frmRelEstoqueProdutos},
  uRelEstoqueMatPrima in 'uRelEstoqueMatPrima.pas' {frmRelEstoqueMatPrima},
  uRelVendas in 'uRelVendas.pas' {frmRelVenda},
  uRelItemVenda in 'uRelItemVenda.pas' {frmRelItemVenda},
  uLogin in 'uLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDM, frmDM);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
