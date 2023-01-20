object frmPrincipal: TfrmPrincipal
  Left = 195
  Top = 0
  Caption = 'SIGPAD - Sistema de Gerenciamento de Produ'#231#245'es'
  ClientHeight = 692
  ClientWidth = 1366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 19
  object TreeView1: TTreeView
    Left = -14
    Top = 31
    Width = 311
    Height = 649
    BorderWidth = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Indent = 19
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnDblClick = TreeView1DblClick
    Items.NodeData = {
      03050000002E0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      0005000000010843006100640061007300740072006F002E0000000000000001
      000000FFFFFFFFFFFFFFFF0000000000000000000000000108550073007500E1
      00720069006F0073002E0000000000000002000000FFFFFFFFFFFFFFFF000000
      000000000000000000010843006C00690065006E007400650073003600000000
      00000003000000FFFFFFFFFFFFFFFF000000000000000000000000010C46006F
      0072006E0065006300650064006F007200650073002E00000000000000040000
      00FFFFFFFFFFFFFFFF0000000000000000000000000108500072006F00640075
      0074006F007300380000000000000005000000FFFFFFFFFFFFFFFF0000000000
      00000000000000010D4D0061007400650072006900610020005000720069006D
      006100340000000000000000000000FFFFFFFFFFFFFFFF000000000000000001
      000000010B5200650063006500620069006D0065006E0074006F004400000000
      00000006000000FFFFFFFFFFFFFFFF000000000000000000000000011345006E
      007400720061006400610020004E006F00740061002000460069007300630061
      006C002E0000000000000000000000FFFFFFFFFFFFFFFF000000000000000002
      0000000108500072006F0064007500E700E3006F003800000000000000070000
      00FFFFFFFFFFFFFFFF000000000000000000000000010D430072006900610072
      0020005200650063006500690074006100400000000000000008000000FFFFFF
      FFFFFFFFFF00000000000000000000000001114F007200640065006D00200064
      0065002000500072006F0064007500E700E3006F002800000000000000000000
      00FFFFFFFFFFFFFFFF0000000000000000010000000105560065006E00640061
      003C0000000000000009000000FFFFFFFFFFFFFFFF0000000000000000000000
      00010F5200650061006C0069007A00610072002000560065006E006400610073
      00320000000000000000000000FFFFFFFFFFFFFFFF0000000000000000040000
      00010A520065006C0061007400F300720069006F00730058000000000000000A
      000000FFFFFFFFFFFFFFFF000000000000000000000000011D520065006C0061
      0074002E0020005200650063006500690074006100730020005800200043006F
      006D0070006F006E0065006E0074006500730052000000000000000B000000FF
      FFFFFFFFFFFFFF000000000000000000000000011A520065006C00610074002E
      0020004500730074006F007100750065002000640065002000500072006F0064
      00750074006F0073005C000000000000000C000000FFFFFFFFFFFFFFFF000000
      000000000000000000011F520065006C00610074002E0020004500730074006F
      0071007500650020006400650020004D0061007400E900720069006100200050
      00720069006D00610038000000000000000D000000FFFFFFFFFFFFFFFF000000
      000000000000000000010D520065006C00610074002E002000560065006E0064
      0061007300}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1369
    Height = 25
    ParentBackground = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 303
    Top = 31
    Width = 1066
    Height = 649
    Align = alCustom
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 536
    Top = 112
    object c1: TMenuItem
      Caption = 'Cadastro'
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = Usurios1Click
      end
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
      object Fornecedores1: TMenuItem
        Caption = 'Fornecedores'
        OnClick = Fornecedores1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
      object MatriaPrima1: TMenuItem
        Caption = 'Materia Prima'
        OnClick = MatriaPrima1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Param. Unidade'
        OnClick = Sair1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Sair2: TMenuItem
        Caption = 'Sair'
      end
    end
    object Recebimento1: TMenuItem
      Caption = 'Recebimento'
      object EntradaNotaFiscal1: TMenuItem
        Caption = 'Entrada Nota Fiscal'
        OnClick = EntradaNotaFiscal1Click
      end
    end
    object Receita1: TMenuItem
      Caption = 'Produ'#231#227'o'
      object CadastrarReceita1: TMenuItem
        Caption = 'Criar Receita'
        OnClick = CadastrarReceita1Click
      end
      object OrdemdeProduo1: TMenuItem
        Caption = 'Ordem de Produ'#231#227'o'
        OnClick = OrdemdeProduo1Click
      end
    end
    object Relatrio1: TMenuItem
      Caption = 'Venda'
      object RealizarVendas1: TMenuItem
        Caption = 'Realizar Vendas'
        OnClick = RealizarVendas1Click
      end
    end
    object Relatrio2: TMenuItem
      Caption = 'Relat'#243'rios'
      object RelatReceitasXComponentes1: TMenuItem
        Caption = 'Relat. Receitas X Componentes'
        OnClick = RelatReceitasXComponentes1Click
      end
      object RelatEstoquedeProdutos1: TMenuItem
        Caption = 'Relat. Estoque de Produtos'
        OnClick = RelatEstoquedeProdutos1Click
      end
      object RelatEstoquedeMatriaPrima1: TMenuItem
        Caption = 'Relat. Estoque de Mat'#233'ria Prima'
        OnClick = RelatEstoquedeMatriaPrima1Click
      end
      object RelatVendas1: TMenuItem
        Caption = 'Relat. Vendas'
        OnClick = RelatVendas1Click
      end
    end
  end
end
