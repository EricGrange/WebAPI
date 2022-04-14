unit WebAPI.Core;

interface

uses WebAPI.Elements, WebAPI.Promises;

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

   JDOMParser = class external 'DOMParser'

      function ParseFromString(str, mimeType : String) : Variant; external 'parseFromString';

   end;

function JSON : JJSON; external 'JSON' property;

function This : Variant; external 'this' property;
function Arguments : Variant; external 'arguments' property;
function Document : Variant; external 'document' property;
function Window : Variant; external 'window' property;
function Console : Variant; external 'console' property;
function Math : Variant; external 'Math' property;
function Event : Variant; external 'event' property;

function ElementByID(id : String) : JElement; external 'document.getElementById';
function QuerySelector(selector : String) : JElement; external 'document.querySelector';
function QuerySelectorAll(selector : String) : array of JElement; external 'document.querySelectorAll';
function GetComputedStyle(element : JElement) : Variant; external 'getComputedStyle';

procedure Alert(msg : String); external 'alert';

function SetTimeout(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setTimeout';
function SetInterval(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setInterval';
procedure ClearTimeout(timeoutId : Integer); external 'clearTimeout';
procedure ClearInterval(intervalId : Integer); external 'clearInterval';
procedure RequestAnimationFrame(proc : procedure); external 'requestAnimationFrame';

function EncodeURI(s : String) : String; external 'encodeURI';
function DecodeURI(s : String) : String; external 'decodeURI';

function EncodeURIComponent(s : String) : String; external 'encodeURIComponent';
function DecodeURIComponent(s : String) : String; external 'decodeURIComponent';

function StrToUTF8(s : String): String;

implementation

function Unescape(s : String) : String; external 'unescape';
function StrToUTF8(s: String): String;
begin
   Result := Unescape(EncodeURIComponent(s));
end;

