unit WebAPI.WeakMap;

interface

type

   JWeakMap = class external 'WeakMap'
      constructor Create;

      function Delete(key : Variant) : Boolean; external 'delete';
      function Get(key : Variant) : Variant; external 'get';
      function Has(key : Variant) : Boolean; external 'has';
      function Set(key, value : Variant) : JWeakMap; external 'set';
   end;

