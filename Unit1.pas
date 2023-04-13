unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Source :TFileStream;
  Fileku : String;
  MYBIN : array[0..65535] of byte;
  buff : char;
  Num1,Num2,Num3,Num4,SizeBIN : LongWord;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var i,m : Integer;
begin
    Num1:=0; Num2:=0; Num3:=0; Num4:=0;
    if Opendialog1.Execute then fileku:= OpenDialog1.FileName;
    Source:= TFileStream.Create(Fileku,fmOpenRead);
    for i:=0 to Source.Size -1 do
    begin
      Source.Read(buff,SIZEOF(buff));
      MYBIN[i]:=ord(buff);
      sizeBIN:=i;
    end;
    Source.Free;
    for m:=0 to sizeBIN do
    begin
      Num1:=MYBIN[(m*2)];
      Num2:=MYBIN[1+(m*2)];
      Num3:=Num3+(Num2 shl 8 or Num1);
    end;
    Num4:=Num3 and $FFFF;
    label1.Caption:=IntToHex(Num4,4);
    if (Num4 =$87A6) then label2.Caption:= 'VALID' else label2.Caption:= 'TIDAK VALID';
    // Catatan : Untuk ECU Yamaha tipe lainnya Checksum Defaultnya adalah sebagai berikut:
    // MX KING 2PV0 	      = 87A6
    // TFX - BG70 		      = BF5B
    // VIXION NVL- 2TP0 	  = 9808
    // YZ250F - 1SM 	      = E679
    // YZ250F - 1SMA 	      = E679
    // WR250F - 2GCC 	      = 49A0
    // WR250F 2018 -2GB1 	  = 5BC2
    // WR250F 2018 -2GB2 	  = 5BC2
    // WR250F 2018 -2GBF 	  = 5BC2
    // WR250F 2018-2GBH 	  = 1484
    // YZ450FX 2019 - B3J0 	= E272
    // YZ450FX 2019 - B3J1 	= E272
    // YZ450FX 2019 - B3J2 	= B766
    // YZ450FX 2019 - B3J3 	= B766
    // YZ450FX 2019 - B3J4 	= D0F0
    // YZ250FX 2020 - BAJ0 	= 1AFE
    // YZ250FX 2020 - BAJ1 	= 1AFE
    // YZ250FX 2020 - BAJ2 	= 1AFE
    // YZ250FX 2020 - BAJ3 	= 1AFE
    // YZ250FX 2020 - BAJ4 	= 1AFE
end;
end.
