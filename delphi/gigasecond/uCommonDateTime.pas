unit uCommonDateTime;

interface
uses
  System.SysUtils;

type
  TCommonDateTime = class(TObject)
    public
      function GetFormattedDate(year, month, day: Integer): String;
      function GetFormattedTime(hours, minutes, seconds: Integer): String;
      function ExtractPartOf(time: String; positions: TArray<Integer>): String;
  end;

implementation

{ TCommonDateTime }

function TCommonDateTime.ExtractPartOf(time: String; positions: TArray<Integer>): String;
var
  position: Integer;
  value: String;
begin
  for position in positions do
    value := value + time[position];
  Result := value;
end;

function TCommonDateTime.GetFormattedDate(year, month, day: Integer): String;
begin
  Result := IntToStr( year ) + '-' + Format('%2.2d', [month]) + '-' + Format('%2.2d', [day]);
end;

function TCommonDateTime.GetFormattedTime(hours, minutes, seconds: Integer): String;
begin
  Result := Format('%2.2d', [hours]) + ':' + Format('%2.2d', [minutes]) + ':' + Format('%2.2d', [seconds]);
end;

end.
