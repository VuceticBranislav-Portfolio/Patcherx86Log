object PatcherForm: TPatcherForm
  Left = 0
  Top = 0
  Caption = 'Patcher86Log'
  ClientHeight = 501
  ClientWidth = 742
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 300
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    742
    501)
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 482
    Width = 742
    Height = 19
    AutoHint = True
    Panels = <>
    ParentShowHint = False
    ShowHint = True
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 31
    Align = alTop
    TabOrder = 1
    DesignSize = (
      742
      31)
    object Edit1: TEdit
      Left = 4
      Top = 4
      Width = 634
      Height = 21
      Hint = '|Path to *.txt file.'
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 692
      Top = 4
      Width = 46
      Height = 21
      Hint = '|Open *.txt file.'
      Anchors = [akTop, akRight]
      Caption = 'Open'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 31
    Width = 742
    Height = 434
    ActivePage = TabSheet2
    Align = alClient
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'General'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 734
        Height = 406
        Hint = '|Patch86xLog file.'
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WantTabs = True
        WordWrap = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Table'
      ImageIndex = 1
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 734
        Height = 406
        Hint = '|Patch list.'
        Align = alClient
        Columns = <
          item
            Caption = 'A'
            Width = 30
          end
          item
            Caption = 'S'
            Width = 30
          end
          item
            Caption = 'T'
            Width = 30
          end
          item
            Caption = '#'
            Width = 30
          end
          item
            Caption = 'Address'
            Width = 80
          end
          item
            Caption = 'Size'
            Width = 40
          end
          item
            Caption = 'Type'
            Width = 60
          end
          item
            Caption = 'Id.'
            Width = 80
          end
          item
            Caption = 'Name'
            Width = 330
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ListView1ColumnClick
        OnCompare = ListView1Compare
      end
    end
  end
  object Button2: TButton
    Left = 642
    Top = 4
    Width = 46
    Height = 21
    Hint = '|Reload opened file.'
    Anchors = [akTop, akRight]
    Caption = 'Reload'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = Button2Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 465
    Width = 742
    Height = 17
    Hint = '|Loading...'
    Align = alBottom
    TabOrder = 4
    Visible = False
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Log86x file (*.txt)|*.txt|Any file (*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 24
    Top = 96
  end
end
