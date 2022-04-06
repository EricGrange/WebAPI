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

      function AppendHTML(html : String) : JElement;
      function PrependHTML(html : String) : JElement;

      function Click(callback : procedure) : JElement;
      function On(eventTypes : String; callback : procedure) : JElement;

   end;

   JElementsHelper = helper for JElements

      function Click(callback : procedure) : JElements;
      function On(eventTypes : String; callback : procedure) : JElements; overload;
      function On(eventTypes : String; callback : procedure (event : Variant)) : JElements; overload;

      function AddClass(aClass : String) : JElements;
      function RemoveClass(aClass : String) : JElements;
      function CSS(styles : Variant) : JElements;

      procedure SetAttribute(name, value : String);
      property Attr[name : String] : String write SetAttribute;

   end;

   JResponse = class external 'Response'

      Ok : Boolean; external 'ok';
      Status : Integer; external 'status';
      StatusText : Integer; external 'statusText';

      function JSON : JPromise<Variant>; external 'json';
      function Text : JPromise<String>; external 'text';

   end;

   JFormData = class external 'FormData'

      constructor Create();

      procedure Append(name, value : String); overload; external 'append';

   end;

   JURLSearchParams = class external 'URLSearchParams'

      constructor Create(data : Variant);

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
procedure PostRawBody(res, dataType : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));
procedure PostJSON(res : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));
procedure PostFormData(res : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));
procedure PostURLEncoded(res : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));

implementation

function Unescape(s : String) : String; external 'unescape';
function StrToUTF8(s: String): String;
begin
   Result := Unescape(EncodeURIComponent(s));
end;

procedure FetchJSON(res: String; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   Fetch(res, class
      credentials := 'same-origin'
   end).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success)
      else fail(r)
   end).Catch(fail);
end;

procedure FetchJSON(res: String; success: procedure (data: Variant));
begin
   Fetch(res, class
      credentials := 'same-origin'
   end).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success);
   end);
end;

procedure PostRawBody(res, dataType: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   var init : Variant = class
      'method' := 'POST';
      credentials := 'same-origin';
      body := data;
   end;
   if dataType <> '' then
      init.headers := class
         'Content-Type' := dataType;
      end;
   Fetch(res, init).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success)
      else fail(r)
   end).Catch(fail);
end;

procedure PostJSON(res: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   PostRawBody(res, 'application/json', JSON.Stringify(data), success, fail);
end;

procedure PostFormData(res: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   var fd := new JFormData;
   for var k in data do
      fd.Append(k, JSON.Stringify(data[k]));
   PostRawBody(res, '', fd, success, fail);
end;

procedure PostURLEncoded(res: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   PostRawBody(res, 'application/x-www-form-urlencoded', new JURLSearchParams(data), success, fail);
end;

// JElementHelper

function JElementHelper.PrependHTML(html: String) : JElement;
begin
   InsertAdjacentHTML('afterbegin', html);
   Result := Self;
end;

function JElementHelper.AppendHTML(html: String) : JElement;
begin
   InsertAdjacentHTML('beforeend', html);
   Result := Self;
end;

function JElementHelper.Click(callback: procedure) : JElement;
begin
   AddEventListener('click', @callback, True);
   Result := Self;
end;

function JElementHelper.On(eventTypes: String; callback: Variant) : JElement;
begin
   for var typ in eventTypes.Split(' ') do
      AddEventListener(typ, @callback, True);
   Result := Self;
end;

// JElementsHelper

function JElementsHelper.Click(callback: procedure): JElements;
begin
   On('click', @callback);
   Result := Self;
end;

function JElementsHelper.On(eventTypes: String; callback: procedure): JElements;
begin
   for var typ in eventTypes.Split(' ') do
      for var i := 0 to Self.High do
         Self[i].AddEventListener(typ, @callback, True);
   Result := Self;
end;

function JElementsHelper.On(eventTypes: String; callback: procedure (event : Variant)): JElements;
begin
   for var typ in eventTypes.Split(' ') do
      for var i := 0 to Self.High do
         Self[i].AddEventListener(typ, @callback, True);
   Result := Self;
end;

function JElementsHelper.AddClass(aClass: String): JElements;
begin
   for var i := 0 to Self.High do
      Self[i].ClassList.Add(aClass);
   Result := Self;
end;

function JElementsHelper.RemoveClass(aClass: String): JElements;
begin
   for var i := 0 to Self.High do
      Self[i].ClassList.Remove(aClass);
   Result := Self;
end;

function JElementsHelper.CSS(styles: Variant): JElements;
begin
   for var i := 0 to Self.High do begin
      var s := Self[i].Style;
      for var k in styles do
         s.setProperty(k, styles[k]);
   end;
   Result := Self;
end;

procedure JElementsHelper.SetAttribute(name: String; value: String);
begin
   for var i := 0 to Self.High do
      Self[i].SetAttribute(name, value);
end;


