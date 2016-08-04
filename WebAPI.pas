unit WebAPI;

interface

type

   JJSON = class external

      function Parse(s : String) : Variant; external 'parse';
      function Stringify(v : Variant) : String; external 'stringify';

   end;

   JRegExp = class external 'RegExp'

      constructor Create(filter, options : String); default;

      function Test(s : String) : Boolean; external 'test';

   end;

   JDate = class external 'Date'

      constructor Create(); overload; external;
      constructor Create(millisecondsSinceEpoch : Float); overload; external;

      function GetSeconds : Integer; external 'getSeconds';
      function GetMinutes : Integer; external 'getMinutes';
      function GetHours : Integer; external 'getHours';

      function GetDate : Integer; external 'getDate'; // 1-31
      function GetMonth : Integer; external 'getMonth'; // 0-11
      function GetFullYear : Integer; external 'getFullYear'; // 2016

      function GetTime : Float; external 'getTime';
      class function Now : Float; external 'now';

   end;

function JSON : JJSON; external 'JSON' property;

function This : Variant; external 'this' property;
function Arguments : Variant; external 'arguments' property;
function Document : Variant; external 'document' property;
function Window : Variant; external 'window' property;
function Console : Variant; external 'console' property;
function Math : Variant; external 'Math' property;
function LocalStorage : Variant; external 'localStorage' property;
function Event : Variant; external 'event' property;

function ElementByID(id : String) : Variant; external 'document.getElementById';

procedure Alert(msg : String); external 'alert';

function SetTimeout(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setTimeout';
function SetInterval(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setInterval';
procedure ClearTimeout(timeoutId : Integer); external 'clearTimeout';
procedure ClearInterval(intervalId : Integer); external 'clearTimeout';

function EncodeURI(s : String) : String; external 'encodeURI';
function DecodeURI(s : String) : String; external 'decodeURI';

function EncodeURIComponent(s : String) : String; external 'encodeURIComponent';
function DecodeURIComponent(s : String) : String; external 'decodeURIComponent';

function EscapeHTML(s : String) : String;

implementation

function EscapeHTML(s : String) : String;
begin
   Result := s.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;')
              .Replace("'", '&apos;').Replace('"', '&quot;');
end;
