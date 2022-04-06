unit WebAPI;

interface

type

   JJSON = class external

      function Parse(s : String) : Variant; external 'parse';
      function Stringify(v : Variant) : String; overload; external 'stringify';
      function Stringify(v, replacer, space : Variant) : String; overload; external 'stringify';

   end;

   JRegExp = class external 'RegExp'

      constructor Create(filter, options : String); default;

      function Test(s : String) : Boolean; external 'test';

   end;

   JDate = class external 'Date'

      constructor Create(); overload; external;
      constructor Create(millisecondsSinceEpoch : Float); overload; external;
      constructor Create(dateString : String); overload; external;

      function GetSeconds : Integer; external 'getSeconds';
      function GetMinutes : Integer; external 'getMinutes';
      function GetHours : Integer; external 'getHours';

      function GetDate : Integer; external 'getDate'; // 1-31
      function GetMonth : Integer; external 'getMonth'; // 0-11
      function GetFullYear : Integer; external 'getFullYear'; // 2016

      function GetTime : Float; external 'getTime';
      class function Now : Float; external 'now';
      function GetTimezoneOffset : Float; external 'getTimezoneOffset';

      class function Parse(s : String) : JDate; external 'parse';

   end;

function JSON : JJSON; external 'JSON' property;

function This : Variant; external 'this' property;
function Arguments : Variant; external 'arguments' property;
function Document : Variant; external 'document' property;
function Window : Variant; external 'window' property;
function Navigator : Variant; external 'navigator' property;
function Console : Variant; external 'console' property;
function Math : Variant; external 'Math' property;
function LocalStorage : Variant; external 'localStorage' property;
function Event : Variant; external 'event' property;
function DevicePixelRatio : Float; external 'devicePixelRatio' property;

function ElementByID(id : String) : Variant; external 'document.getElementById';
function QuerySelector(selector : String) : Variant; external 'document.querySelector';
function QuerySelectorAll(selector : String) : array of Variant; external 'document.querySelectorAll';

procedure Alert(msg : String); external 'alert';

function SetTimeout(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setTimeout';
function SetInterval(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setInterval';
procedure ClearTimeout(timeoutId : Integer); external 'clearTimeout';
procedure ClearInterval(intervalId : Integer); external 'clearInterval';
procedure RequestAnimationFrame(proc : procedure); external 'requestAnimationFrame';
function PerformanceNow : Float; external 'performance.now';

function EncodeURI(s : String) : String; external 'encodeURI';
function DecodeURI(s : String) : String; external 'decodeURI';

function EncodeURIComponent(s : String) : String; external 'encodeURIComponent';
function DecodeURIComponent(s : String) : String; external 'decodeURIComponent';

function EscapeHTML(s : String) : String;

function StrToUTF8(s : String) : String;

implementation

function EscapeHTML(s : String) : String;
begin
   Result := s.ToHtml;
end;

function Unescape(s : String) : String; external 'unescape';
function StrToUTF8(s: String): String;
begin
   Result := Unescape(EncodeURIComponent(s));
end;

