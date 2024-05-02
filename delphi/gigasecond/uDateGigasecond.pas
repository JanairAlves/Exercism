unit uDateGigasecond;

interface
uses
  System.SysUtils, System.DateUtils, uCommonDateTime;

type
  TDateGigasecond = class(TObject)
    private
      function ExtractAPartOnDate(date: String; positions: TArray<Integer>): Integer;
      procedure SetDate(var year, month, day, totalDays: Integer);
      function IsDivisibleBy(dividend, divider: integer): Boolean;
      function IsLeap(year: Integer): Boolean;
    public
      function GetDate(oldDate: String; totalDays: Integer): String;
  end;

implementation

{ TDateGigasecond }

function TDateGigasecond.GetDate(oldDate: String; totalDays: Integer): String;
var
  day, month, year: integer;
  commonDateTime: TCommonDateTime;
begin
  day := ExtractAPartOnDate(oldDate, [9, 10]);
  month := ExtractAPartOnDate(oldDate, [6, 7]);
  year := ExtractAPartOnDate(oldDate, [1, 2, 3, 4]);

  while totalDays <> 0 do
    SetDate(year, month, day, totalDays);

  commonDateTime := TCommonDateTime.Create;
  try
    Result := commonDateTime.GetFormattedDate(year, month, day);
  finally
    FreeAndNil(commonDateTime);
  end;
end;

procedure TDateGigasecond.SetDate(var year, month, day, totalDays: Integer);
  procedure CalculateDate(nextMonth, daysMonth: Integer);
  begin
    if ( day = daysMonth ) and ( totalDays > daysMonth ) then
      totalDays := totalDays - daysMonth;

    if ( day <> daysMonth ) and ( totalDays > daysMonth ) then
      totalDays := totalDays - (daysMonth - day);

    month := nextMonth;

    if ( totalDays <= daysMonth ) then
    begin
      day := totalDays;
      totalDays := 0;
      Exit;
    end;

    if nextMonth + 1 = MonthDecember then
      Inc(year);

    day := 0;
  end;

begin
  case month of
    MonthJanuary: CalculateDate(MonthFebruary, MonthDays[IsLeap(year)][MonthJanuary]);
    MonthFebruary: CalculateDate(MonthMarch, MonthDays[IsLeap(year)][MonthFebruary]);
    MonthMarch: CalculateDate(MonthApril, MonthDays[IsLeap(year)][MonthMarch]);
    MonthApril: CalculateDate(MonthMay, MonthDays[IsLeap(year)][MonthApril]);
    MonthMay: CalculateDate(MonthJune, MonthDays[IsLeap(year)][MonthMay]);
    MonthJune: CalculateDate(MonthJuly, MonthDays[IsLeap(year)][MonthJune]);
    MonthJuly: CalculateDate(MonthAugust, MonthDays[IsLeap(year)][MonthJuly]);
    MonthAugust: CalculateDate(MonthSeptember, MonthDays[IsLeap(year)][MonthAugust]);
    MonthSeptember: CalculateDate(MonthOctober, MonthDays[IsLeap(year)][MonthSeptember]);
    MonthOctober: CalculateDate(MonthNovember, MonthDays[IsLeap(year)][MonthOctober]);
    MonthNovember: CalculateDate(MonthDecember, MonthDays[IsLeap(year)][MonthNovember]);
    MonthDecember:CalculateDate(MonthJanuary, MonthDays[IsLeap(year)][MonthDecember]);
  end;
end;

function TDateGigasecond.ExtractAPartOnDate(date: String; positions: TArray<Integer>): Integer;
var
  commonDateTime: TCommonDateTime;
begin
  commonDateTime := TCommonDateTime.Create;
  try
     Result := StrToInt( commonDateTime.ExtractPartOf(date, positions) );
  finally
    FreeAndNil(commonDateTime);
  end;
end;

function TDateGigasecond.IsLeap(year: Integer): Boolean;
begin
  Result :=
    IsDivisibleBy(year, 400) or
    IsDivisibleBy(year, 4) and
    not IsDivisibleBy(year, 100);
end;

function TDateGigasecond.IsDivisibleBy(dividend, divider: Integer): Boolean;
begin
  Result := dividend mod divider = 0;
end;

end.
