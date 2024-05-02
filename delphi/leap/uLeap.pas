unit uLeap;

interface

type
  TYear = class(TObject)

  public
    class function IsLeap(year: Integer): Boolean;
    class function divisibleBy(dividend, divider: integer): Boolean;
  end;

implementation

{ TYear }

class function TYear.IsLeap(year: Integer): Boolean;
begin
  Result :=
    divisibleBy(year, 400) or
    divisibleBy(year, 4) and
    not divisibleBy(year, 100);
end;

class function TYear.divisibleBy(dividend, divider: Integer): Boolean;
begin
  Result := dividend mod divider = 0;
end;

end.