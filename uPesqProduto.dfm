object frmPesqProduto: TfrmPesqProduto
  Left = 0
  Top = 0
  Caption = 'Pesquisar Produtos'
  ClientHeight = 539
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 81
    Width = 788
    Height = 458
    Align = alClient
    DataSource = dsProduto
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'proCodigo'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'proDescricao'
        Title.Caption = 'Produto'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 571
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'proPVenda'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'proEstoque'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'recAssociada'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'proEstMinimo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'pro_undCodigo'
        Title.Alignment = taCenter
        Title.Caption = 'Unidade'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'pro_undDescricao'
        Title.Caption = 'Unidade'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 108
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 788
    Height = 81
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 24
      Width = 73
      Height = 19
      Caption = 'Descri'#231#227'o:'
    end
    object Edit1: TEdit
      Left = 103
      Top = 21
      Width = 322
      Height = 27
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 431
    Top = 19
    Width = 96
    Height = 31
    Caption = '&Pesquisar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 533
    Top = 21
    Width = 247
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 3
    Text = 'Todos produtos'
    Items.Strings = (
      'Todos produtos'
      'Somente com receita cadastrada'
      'Semente sem receita cadastrada')
  end
  object dsProduto: TDataSource
    DataSet = frmDM.tabProduto
    Left = 256
    Top = 64
  end
end
