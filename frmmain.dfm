object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 310
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object BtnCadCliente: TButton
    Left = 424
    Top = 47
    Width = 115
    Height = 33
    Action = ActCadCliente
    TabOrder = 0
  end
  object Button1: TButton
    Left = 424
    Top = 86
    Width = 115
    Height = 33
    Action = ActCadVeiculo
    TabOrder = 1
  end
  object Button2: TButton
    Left = 424
    Top = 125
    Width = 115
    Height = 33
    Action = ActCadVendas
    TabOrder = 2
  end
  object Button3: TButton
    Left = 32
    Top = 8
    Width = 115
    Height = 33
    Action = ActQtdMarea
    TabOrder = 3
  end
  object Button4: TButton
    Left = 32
    Top = 47
    Width = 115
    Height = 33
    Action = ActQtdUno
    TabOrder = 4
  end
  object Button5: TButton
    Left = 32
    Top = 86
    Width = 115
    Height = 33
    Action = ActSemVendas
    TabOrder = 5
  end
  object Button6: TButton
    Left = 32
    Top = 125
    Width = 115
    Height = 33
    Action = ActSorteados
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 424
    Top = 8
    Width = 115
    Height = 33
    Action = actExcuiVendas
    TabOrder = 7
  end
  object ActionList1: TActionList
    Left = 280
    Top = 56
    object ActCadCliente: TAction
      Caption = 'Cadastro de Cliente'
      OnExecute = ActCadClienteExecute
    end
    object ActCadVeiculo: TAction
      Caption = 'Cadastro de Ve'#237'culo'
      OnExecute = ActCadVeiculoExecute
    end
    object ActCadVendas: TAction
      Caption = 'Cadastro de Venda'
      OnExecute = ActCadVendasExecute
    end
    object actExcuiVendas: TAction
      Caption = 'Excluir Vendas'
      OnExecute = actExcuiVendasExecute
    end
    object ActQtdMarea: TAction
      Caption = 'Qtd. Marea'
      OnExecute = ActQtdMareaExecute
    end
    object ActQtdUno: TAction
      Caption = 'Qtd. Uno'
      OnExecute = ActQtdUnoExecute
    end
    object ActSemVendas: TAction
      Caption = 'Clientes sem Vendas'
      OnExecute = ActSemVendasExecute
    end
    object ActSorteados: TAction
      Caption = 'Clientes Sorteados'
      OnExecute = ActSorteadosExecute
    end
  end
end
