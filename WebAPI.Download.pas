unit WebAPI.Download;

uses WebAPI, WebAPI.Unicode, WebAPI.TypedArrays;

type
   JBlob = class external 'Blob'
      constructor Create(data : array of Variant; options : Variant);
   end;

type
   JBlobHelper = class helper for JBlob

      class function CreateUTF8Text(txt : String; mimeType : String = 'text/plain') : JBlob; static;
      begin
         var data : array of Variant;
         data.Add(new JUint8Array([$EF, $BB, $BF])); // BOM
         data.Add(UTF8Encoder.Encode(txt));
         Result := new JBlob(data, class
            'type' := mimeType;
         end);
      end;

      class function CreateUTF16LEText(txt : String; mimeType : String = 'text/plain') : JBlob; static;
      begin
         var data : array of Variant;
         data.Add(new JUint8Array([$FF, $FE])); // BOM
         data.Add(UTF16LEEncoder.Encode(txt));
         Result := new JBlob(data, class
            'type' := mimeType;
         end);
      end;

   end;

procedure DownloadContent(fileName : String; blob : JBlob;
                          mimeType : String = 'application/octet-stream');
begin
   if Window.navigator.msSaveOrOpenBlob then
      Window.navigator.msSaveBlob(blob, fileName)
   else begin
      var elem := Document.createElement('a');
      elem.href := Window.URL.createObjectURL(blob);
      elem.download := fileName;
      Document.body.appendChild(elem);
      elem.click();
      Document.body.removeChild(elem);
   end;
end;
