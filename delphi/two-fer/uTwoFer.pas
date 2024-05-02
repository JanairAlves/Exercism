unit uTwoFer;

interface

uses
  System.SysUtils;

  function twoFer(name: string = ''): string;

implementation

function twoFer(name: string = ''): string;
begin
  if Trim(name) = '' then
    result := 'One for you, one for me.';

  if Trim(name) <> '' then
    result := 'One for ' + name + ', one for me.';
end;

end.