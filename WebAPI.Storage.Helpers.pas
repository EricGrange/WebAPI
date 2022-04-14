unit WebAPI.Storage.Helpers;

uses WebAPI.Storage;

type
   JStorageHelper = helper for JStorage

      function GetString(name : String) : String; begin Result := GetItem(name) ?? '' end;
      procedure SetString(name, value : String); begin SetItem(name, value) end;

      property Strings[name : String] : String read GetString write SetString;

   end;


