unit WebAPI.DOMParser;

type
   JDOMParser = class external 'DOMParser'
      function ParseFromString(aString, mimeType : String) : Variant; external 'parseFromString';
   end;
