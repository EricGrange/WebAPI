unit WebAPI.Date;

interface

type

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


