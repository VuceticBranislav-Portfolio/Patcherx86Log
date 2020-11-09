unit Unit1;

interface

uses
  SysUtils, Classes, Forms, Controls, Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TPatcherForm = class(TForm)
    Edit1       : TEdit;
    Memo1       : TMemo;
    Panel1      : TPanel;
    Button1     : TButton;
    Button2     : TButton;
    ListView1   : TListView;
    TabSheet1   : TTabSheet;
    TabSheet2   : TTabSheet;
    StatusBar1  : TStatusBar;
    OpenDialog1 : TOpenDialog;
    PageControl1: TPageControl;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure FormCreate(Sender: TObject);
    function CompareInt (const S1, S2: string): Integer;
    function CompareTxt (const S1, S2: string): Integer;
    procedure PopulateHeader;
    procedure Update;
  private
    SortedColumn: Integer;
    Descending  : Boolean;
  end;

var
  PatcherForm: TPatcherForm;

implementation

{$R *.dfm}

procedure TPatcherForm.PopulateHeader;
// Populate column headers and add sort direction arrow.
begin
  ListView1.Column[0].Caption := 'A';
  ListView1.Column[1].Caption := 'S';
  ListView1.Column[2].Caption := 'T';
  ListView1.Column[3].Caption := '#';
  ListView1.Column[4].Caption := 'Address';
  ListView1.Column[5].Caption := 'Size';
  ListView1.Column[6].Caption := 'Type';
  ListView1.Column[7].Caption := 'Id.';
  ListView1.Column[8].Caption := 'Name';
  if Descending
    then ListView1.Column[SortedColumn].Caption := #$2191#$20 + ListView1.Column[SortedColumn].Caption
    else ListView1.Column[SortedColumn].Caption := #$2193#$20 + ListView1.Column[SortedColumn].Caption;
end;

function Load(S: String; var List: TStringList):Boolean;
// Brake string to parts. Populate list.
var
  c1, c2, c3, H: string;
  I, II, III, G, F, T: Integer;
begin
  Result := False;
  List.Clear;
  if Length(S) < 10 then Exit;
  if (S[1] = '[') and (S[3] = ']') then c1 := S[2] else Exit;
  if (S[4] = '[') and (S[6] = ']') then c2 := S[5] else Exit;
  if (S[7] = '[') and (S[9] = ']') then c3 := S[8] else Exit;
  I := Pos(':', S, 9);
  H := Copy(S, 10, I-10);
  if not TryStrToInt(H, G) then Exit;

  for III := 1 to G do
    begin
    List.Add(C1);
    List.Add(C2);
    List.Add(C3);
    List.Add(IntToStr(III));
    // Get string between brackets
    F := Pos('(', S);
    T := Pos(')', S);
    if (F = 0) or (T = 0) then Exit;
    H := Copy(S, F+1, T-F-1);
    S := Copy(S, T+3, Length(S));
    // Address
    T := Pos(' ', H);
    if T = 0 then Exit;
    List.Add(Copy('$' +H, 1, T-1));
    H := TrimLeft(Copy(H, T, Length(H)));
    // Length
    T := Pos(' ', H);
    if T = 0 then Exit;
    List.Add(Copy(H, 1, T-1));
    H := TrimLeft(Copy(H, T, Length(H)));
    // Type
    T := Pos(' ', H);
    if T = 0 then Exit;
    List.Add(Copy(H, 1, T-1));
    H := TrimLeft(Copy(H, T, Length(H)));
    // Id
    T := Pos(' ', H);
    if T = 0 then Exit;
    List.Add(Copy(H, 1, T-1));
    H := TrimLeft(Copy(H, T, Length(H)));
    // Rest
    List.Add(Copy(H, 3, Length(H)));
    end;
  Result:= True;
end;

procedure TPatcherForm.Update;
// Update memo and listview if provided file exists
var
  I: Integer;
  Item: TListItem;
  L: TStringList;
  II: Integer;
begin
    if FileExists(Edit1.Text) then
    try
      ProgressBar1.Visible := True;
      Memo1.Lines.Clear;
      Memo1.Lines.LoadFromFile(Edit1.Text);

      ProgressBar1.Min := 0;
      ProgressBar1.Max := Memo1.Lines.Count -1;
      L                := TStringList.Create;

      ListView1.Items.BeginUpdate;
      ListView1.Items.Clear;
      for I := 0 to Memo1.Lines.Count-1 do
      begin
        if Load(Memo1.Lines[I], L) then
        begin
        for II := 0 to (L.Count div 9)-1 do
          begin
          Item:= ListView1.Items.Add();
          Item.Caption :=   L[II*9+0];
          Item.SubItems.Add(L[II*9+1]);
          Item.SubItems.Add(L[II*9+2]);
          Item.SubItems.Add(L[II*9+3]);
          Item.SubItems.Add(L[II*9+4]);
          Item.SubItems.Add(L[II*9+5]);
          Item.SubItems.Add(L[II*9+6]);
          Item.SubItems.Add(L[II*9+7]);
          Item.SubItems.Add(L[II*9+8]);
          end;
        L.Clear;
        end;
        ProgressBar1.Position := I;
        Application.ProcessMessages;
      end;
      ListView1.Items.EndUpdate;
      L.free;
      ListView1.Hint := '|Items in list: ' + IntToStr(ListView1.Items.Count);
    finally
      ProgressBar1.Visible := False;
    end;
end;

procedure TPatcherForm.Button1Click(Sender: TObject);
begin
  // Exit if open dialog file not selected
  if not OpenDialog1.Execute(Application.Handle) then Exit;

  // If file exist add name to edit, otherwise clear all
  if FileExists(OpenDialog1.FileName) then
    begin
    Edit1.Text      := OpenDialog1.FileName;
    Button2.Enabled := True;
    end
  else
    begin
    Edit1.Text      := '';
    Button2.Enabled := False;
    ListView1.Items.Clear;
    Memo1.Lines.Clear;
    end;

  Update;
end;

procedure TPatcherForm.Button2Click(Sender: TObject);
begin
  Update;
end;

procedure TPatcherForm.FormCreate(Sender: TObject);
// Initial preparation
begin
  // If first parameter provided load it. If there are no parameter provided set current
  // open dialog location to program location but only in debug builds.
  if FileExists(ParamStr(1)) then
    begin
    OpenDialog1.FileName   := ParamStr(1);
    OpenDialog1.InitialDir := ExtractFileDir(OpenDialog1.FileName);
    Edit1.Text             := OpenDialog1.FileName;
    Button2.Enabled        := True;
    Update;
  {$IF Defined(DEBUG)}
    end
    else OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName) + '\Data\';
  {$ELSE}
    end;
  {$IFEND}

  // Initialize column header
  SortedColumn := 4;
  PopulateHeader;
end;

function TPatcherForm.CompareInt(const S1, S2: string): Integer;
// Comparator. Compare two strings as integer.
var Code, N1, N2: Integer;
begin
  Val(S1, N1, Code);
  if Code <> 0 then N1 := 0;
  Val(S2, N2, Code);
  if Code <> 0 then N2 := 0;
  Result := N1 - N2;
end;

function TPatcherForm.CompareTxt(const S1, S2: string): Integer;
// Comparator. Compare two strings by length.
begin
  Result := CompareText(S1, S2);
end;

procedure TPatcherForm.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
// Sort data in listview
begin
  TListView(Sender).SortType := stNone;
  if Column.Index <> SortedColumn then
  begin
    SortedColumn := Column.Index;
    Descending   := False;
  end
  else Descending            := not Descending;
  TListView(Sender).SortType := stText;
  PopulateHeader;
end;

procedure TPatcherForm.ListView1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
// Comparator. Integers are compared by values and patch data is compared by length.
begin
  case SortedColumn of
    0:       Compare := CompareTxt(Item1.Caption, Item2.Caption);
    3,4,5,7: Compare := CompareInt(Item1.SubItems[SortedColumn - 1], Item2.SubItems[SortedColumn - 1]);
  else
    Compare := CompareTxt(Item1.SubItems[SortedColumn - 1], Item2.SubItems[SortedColumn - 1]);
  end;
  if Descending then Compare := -Compare;
end;

end.
