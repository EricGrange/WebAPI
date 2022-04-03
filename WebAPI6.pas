unit WebAPI6;

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

   JDate = class external 'Date'

      constructor Create(); overload; external;
      constructor Create(millisecondsSinceEpoch : Float); overload; external;

      function GetSeconds : Integer; external 'getSeconds';
      function GetMinutes : Integer; external 'getMinutes';
      function GetHours : Integer; external 'getHours';

      function GetDate : Integer; external 'getDate'; // 1-31
      function GetMonth : Integer; external 'getMonth'; // 0-11
      function GetFullYear : Integer; external 'getFullYear'; // 2016
      function GetTimezoneOffset : Integer; external 'getTimezoneOffset'; // in minutes

      function ToLocaleString : String; external 'toLocaleString';

      function GetTime : Float; external 'getTime';
      class function Now : Float; external 'now';

      class function Parse(isoDate : String) : Integer; external 'parse';

   end;

   JElementHelper = helper for JElement

      procedure AppendHTML(html : String);
      procedure PrependHTML(html : String);

      procedure Click(callback : procedure);
      procedure On(eventTypes : String; callback : procedure);

   end;

   JElementsHelper = helper for JElements

      procedure Click(callback : procedure);
      procedure On(eventTypes : String; callback : procedure);

   end;

   JResponse = class external 'Response'

      function JSON : JPromise<Variant>; external 'json';
      Ok : Boolean; external 'ok';

   end;

function JSON : JJSON; external 'JSON' property;

function This : Variant; external 'this' property;
function Arguments : Variant; external 'arguments' property;
function Document : JElement; external 'document' property;
function Window : Variant; external 'window' property;
function Console : Variant; external 'console' property;
function Math : Variant; external 'Math' property;
function LocalStorage : Variant; external 'localStorage' property;
function Event : Variant; external 'event' property;

function ElementByID(id : String) : JElement; external 'document.getElementById';
function QuerySelector(selector : String) : JElement; external 'document.querySelector';
function QuerySelectorAll(selector : String) : array of JElement; external 'document.querySelectorAll';

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

function Fetch(res : String) : JPromise<JResponse>; overload; external 'fetch';
function Fetch(res : String; init : Variant) : JPromise<JResponse>; overload; external 'fetch';
procedure FetchJSON(res : String; success : procedure (data : Variant); fail : procedure (r : JResponse)); overload;
procedure FetchJSON(res : String; success : procedure (data : Variant)); overload;

implementation

function Unescape(s : String) : String; external 'unescape';
function StrToUTF8(s: String): String;
begin
   Result := Unescape(EncodeURIComponent(s));
end;

procedure FetchJSON(res: String; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   var f := Fetch(res);
   f.&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success)
      else fail(r)
   end);
   f.Catch(fail);
end;

procedure FetchJSON(res: String; success: procedure (data: Variant));
begin
   Fetch(res).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success);
   end);
end;

// JElementHelper

procedure JElementHelper.PrependHTML(html: String);
begin
   Self.InsertAdjacentHTML('afterbegin', html);
end;

procedure JElementHelper.AppendHTML(html: String);
begin
   Self.InsertAdjacentHTML('beforeend', html);
end;

procedure JElementHelper.Click(callback: procedure);
begin
   AddEventListener('click', callback);
end;

procedure JElementHelper.On(eventTypes: String; callback: procedure  );
begin
   for var typ in eventTypes.Split(' ') do
      AddEventListener(typ, callback);
end;

// JElementsHelper

procedure JElementsHelper.Click(callback: procedure);
begin
   On('click', callback);
end;

procedure JElementsHelper.On(eventTypes: String; callback: procedure  );
begin
   for var typ in eventTypes.Split(' ') do
      for var i := 0 to Self.High do
         Self[i].AddEventListener(typ, callback);
end;

