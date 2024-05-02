unit uGigasecond;

interface
uses
  System.SysUtils, uConvertGigasecond, uDateGigasecond, uTimeGigasecond;

type
  TGigasecond = class(TObject)
    class function Add(oldDate: String): String;
  end;

implementation

{ TGigasecond }

const
  oneGigasecondInSeconds: Double = 1000000000;

class function TGigasecond.Add(oldDate: String): String;
var
  time, newTime, newDate: String;
  days: Integer;
  convertGigasecond: TConvertGigasecond;
  timeGigasecond: TTimeGigasecond;
  dateGigasecond: TDateGigasecond;
begin
  convertGigasecond := TConvertGigasecond.Create;
  timeGigasecond := TTimeGigasecond.Create;
  dateGigasecond := TDateGigasecond.Create;

  try
    convertGigasecond.ConvertSeconds(oneGigasecondInSeconds, time, days);

    newTime := timeGigasecond.GetTime(oldDate, time, days);

    newDate := dateGigasecond.GetDate(oldDate, days);

    Result := newDate + 'T' + newTime;

  finally
    FreeAndNil(convertGigasecond);
    FreeAndNil(timeGigasecond);
    FreeAndNil(dateGigasecond);
  end;
end;

end.
