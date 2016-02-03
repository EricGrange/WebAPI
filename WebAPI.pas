﻿unit WebAPI;

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
function Document : Variant; external 'document' property;
function Window : Variant; external 'window' property;
function Console : Variant; external 'console' property;
function Math : Variant; external 'Math' property;
function LocalStorage : Variant; external 'localStorage' property;
procedure Alert(msg : String); external 'alert';

function SetTimeout(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setTimeout';
function SetInterval(proc : procedure; delayMilliseconds : Integer) : Integer; external 'setInterval';
procedure ClearTimeout(timeoutId : Integer); external 'clearTimeout';
procedure ClearInterval(intervalId : Integer); external 'clearTimeout';

function EncodeURIComponent(s : String) : String; external 'encodeURIComponent';
function DecodeURIComponent(s : String) : String; external 'decodeURIComponent';

