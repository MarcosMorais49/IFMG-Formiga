object frmPesqCliente: TfrmPesqCliente
  Left = 0
  Top = 0
  Caption = 'Pesquisar Clientes'
  ClientHeight = 549
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 81
    Width = 791
    Height = 468
    Align = alClient
    DataSource = dsPCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'cliCodigo'
        Title.Caption = 'C'#243'digo'
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliNome'
        Title.Caption = 'Cliente'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliEndereco'
        Title.Caption = 'Endere'#231'o'
        Width = 205
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliBairro'
        Title.Caption = 'Bairro'
        Width = 159
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliCidade'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliCep'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliEstado'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliCpf'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliRg'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliEmail'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'cliTelefone'
        Title.Caption = 'Telefone'
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cliTipo'
        Visible = False
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 791
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
      Left = 12
      Top = 25
      Width = 48
      Height = 19
      Caption = 'Nome:'
    end
    object Edit1: TEdit
      Left = 82
      Top = 22
      Width = 450
      Height = 27
      TabOrder = 0
    end
    object Button1: TButton
      Left = 557
      Top = 20
      Width = 97
      Height = 31
      Caption = '&Pesquisar'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object dsPCliente: TDataSource
    DataSet = frmDM.tabCliente
    Left = 488
    Top = 232
  end
end
