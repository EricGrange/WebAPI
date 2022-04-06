unit WebAPI.Download;

interface

uses WebAPI, WebAPI.Blob;

procedure DownloadContent(fileName : String; blob : JBlob;
                          mimeType : String = 'application/octet-stream');

implementation

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
