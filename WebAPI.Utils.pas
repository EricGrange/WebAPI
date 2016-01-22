unit WebAPI.Utils;

uses WebAPI;

type JBlob = class external 'Blob'
      constructor Create(data : array of Variant; options : Variant);
   end;


procedure SaveBlob(fileName, contentData : String; contentType : String = '');
begin
   if contentType = '' then
      contentType := 'application/data';

   var blob := new JBlob([contentData], class &type := contentType end);
   if Window.navigator.msSaveOrOpenBlob then begin
      Window.navigator.msSaveBlob(blob, fileName);
   end else begin
      var elem := Window.document.createElement('a');
      elem.href := Window.URL.createObjectURL(blob);
      elem.download := fileName;
      Document.body.appendChild(elem);
      elem.click();
      Document.body.removeChild(elem);
   end;
end;
