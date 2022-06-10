unit WebAPI.Blob;

interface

uses WebAPI.TypedArrays, WebAPI.Unicode;

type
   JBlob = class external 'Blob'
      constructor Create(data : array of Variant; options : Variant);
   end;

   JBlobHelper = helper for JBlob

      class function CreateUTF8Text(txt : String; mimeType : String = 'text/plain') : JBlob; static;
      class function CreateUTF16LEText(txt : String; mimeType : String = 'text/plain') : JBlob; static;

   end;

implementation

class function JBlobHelper.CreateUTF8Text(txt : String; mimeType : String = 'text/plain') : JBlob;
begin
   var data : array of Variant;
   data.Add(new JUint8Array([$EF, $BB, $BF])); // BOM
   data.Add(UTF8Encoder.Encode(txt));
   Result := new JBlob(data, class
      'type' := mimeType;
   end);
end;

class function JBlobHelper.CreateUTF16LEText(txt : String; mimeType : String = 'text/plain') : JBlob;
begin
   var data : array of Variant;
   data.Add(new JUint8Array([$FF, $FE])); // BOM
   data.Add(UTF16LEEncoder.Encode(txt));
   Result := new JBlob(data, class
      'type' := mimeType;
   end);
end;
