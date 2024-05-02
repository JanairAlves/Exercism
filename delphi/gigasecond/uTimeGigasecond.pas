unit uTimeGigasecond;

interface
uses
  System.SysUtils, uCommonDateTime;

type
  TTimeGigasecond = class(TObject)
    private
      function ExtractAPartOnTime(time: String; positions: TArray<Integer>): Integer;
      function GetSeconds(oldSecond, newSecond: Integer; var newMinute: Integer):Integer;
      function GetMinutes(oldMinute, newMinute: Integer; var newHour: Integer):Integer;
      function GetHours(oldHour, newHour: Integer; var days: Integer):Integer;
      function CalculateTime(oldTime, newTime: Integer; var time: Integer): Integer;
    public
      function GetTime(oldDate, time: String; var days: Integer): String;
  end;

implementation

  { TTimeGigasecond }

function TTimeGigasecond.GetTime(oldDate, time: String; var days: Integer): String;
var
  oldHour, oldMinute, oldSecond, newHour, newMinute, newSecond: Integer;
  theOldDateHasTime: Boolean;
  commonDateTime: TCommonDateTime;
begin
  newHour := ExtractAPartOnTime(time, [1, 2]);
  newMinute := ExtractAPartOnTime(time, [4, 5]);
  newSecond := ExtractAPartOnTime(time, [7, 8]);

  commonDateTime := TCommonDateTime.Create;
  theOldDateHasTime := Length(oldDate) > 10;

  if not theOldDateHasTime then
  begin
      try
        Result := commonDateTime.GetFormattedTime(newHour, newMinute, newSecond);
      finally
        FreeAndNil(commonDateTime);
      end;
    Exit;
  end;

  oldHour := ExtractAPartOnTime(oldDate, [12, 13]);
  oldMinute := ExtractAPartOnTime(oldDate, [15, 16]);
  oldSecond := ExtractAPartOnTime(oldDate, [18, 19]);

  newSecond := GetSeconds(oldSecond, newSecond, newMinute);
  newMinute := GetMinutes(oldMinute, newMinute, newHour);
  newHour := GetHours(oldHour, newHour, days);

  try
    Result := commonDateTime.GetFormattedTime(newHour, newMinute, newSecond);
  finally
    FreeAndNil(commonDateTime);
  end;
end;

function TTimeGigasecond.GetSeconds(oldSecond, newSecond: Integer; var newMinute: Integer):Integer;
begin
  Result := CalculateTime(oldSecond, newSecond, newMinute);
end;

function TTimeGigasecond.GetMinutes(oldMinute, newMinute: Integer; var newHour: Integer):Integer;
begin
  Result := CalculateTime(oldMinute, newMinute, newHour);
end;

function TTimeGigasecond.GetHours(oldHour, newHour: Integer; var days: Integer):Integer;
begin
 if ( oldHour + newHour ) >= 24 then
  begin
    days := days + trunc( ( oldHour + newHour ) / 24 );
    Result := round( frac( ( newHour + oldHour ) / 24 ) * 24 );
    Exit;
  end;

  Result := newHour + oldHour;
end;

function TTimeGigasecond.CalculateTime(oldTime, newTime: Integer; var time: Integer): Integer;
begin
  if ( oldTime + newTime ) >= 60 then
  begin
    time := time + trunc( ( newTime + oldTime ) / 60 );
    Result := trunc ( frac( ( newTime + oldTime ) / 60 ) * 60 );
    Exit;
  end;

  Result := newTime + oldTime;
end;

function TTimeGigasecond.ExtractAPartOnTime(time: String; positions: TArray<Integer>): Integer;
var
  commonDateTime: TCommonDateTime;
begin
  commonDateTime := TCommonDateTime.Create;
  try
     Result := StrToInt( commonDateTime.ExtractPartOf(time, positions) );
  finally
    FreeAndNil(commonDateTime);
  end;
end;

end.
