unit WebAPI.Storage;

type
   JStorage = class external 'Storage'

      Length : Integer; external 'length';

      procedure Clear; external 'clear';
      function GetItem(name : String) : Variant; external 'getItem';
      procedure SetItem(name : String; value : Variant); external 'setItem';
      function Key(index : Integer) : Variant; external 'key';
      procedure RemoveItem(name : String); external 'removeItem';

      property Items[name : String] : Variant read GetItem write SetItem;

   end;

function LocalStorage : JStorage; external 'localStorage' property;

