unit uConvertGigasecond;

interface
uses
  System.SysUtils, uCommonDateTime;

type
  TConvertGigasecond = class(TObject)
    private
      function CalculateTime(time: Double): Double;
      function GetSeconds(secondsInGigaseconds: double): Integer;
      function GetTotalMinutes(secondsInGigaseconds: double): Integer;
      function GetTotalHours(minutes: Integer): Integer;
      function GetMinutes(minutes: Integer): Integer;
      function GetTotalDays(hours: Integer): Integer;
      function GetHours(hours: Integer):Integer;
    public
      procedure ConvertSeconds(gigasecond: Double; var time: String; var days: Integer);
  end;

implementation

{ TTimeGigasecond }

procedure TConvertGigasecond.ConvertSeconds(gigasecond: Double; var time: String; var days: Integer);
var
  hours, minutes, seconds: Integer;
  commonDateTime: TCommonDateTime;
begin
  seconds := GetSeconds(gigasecond);
  minutes := GetTotalMinutes(gigasecond);

  hours := GetTotalHours(minutes);
  minutes := GetMinutes(minutes);

  days := GetTotalDays(hours);
  hours := GetHours(hours);

  commonDateTime := TCommonDateTime.Create;
  try
    time := commonDateTime.GetFormattedTime(hours, minutes, seconds);
  finally
    FreeAndNil(commonDateTime);
  end;
end;

function TConvertGigasecond.GetSeconds(secondsInGigaseconds: double): Integer;
begin
  Result := round(frac(calculateTime(secondsInGigaseconds)) * 60);
end;

function TConvertGigasecond.GetTotalMinutes(secondsInGigaseconds: double): Integer;
begin
  Result := trunc(calculateTime(secondsInGigaseconds));
end;

function TConvertGigasecond.GetTotalHours(minutes: Integer): Integer;
begin
  Result := trunc(calculateTime(minutes));
end;

function TConvertGigasecond.GetMinutes(minutes: Integer): Integer;
begin
  Result := round(frac(calculateTime(minutes)) * 60);
end;

function TConvertGigasecond.GetTotalDays(hours: Integer): Integer;
begin
  Result := trunc((hours / 24));
end;

function TConvertGigasecond.GetHours(hours: Integer):Integer;
begin
  Result := round(frac(hours / 24) * 24);
end;

function TConvertGigasecond.CalculateTime(time: Double): Double;
begin
  Result := time / 60;
end;

end.
