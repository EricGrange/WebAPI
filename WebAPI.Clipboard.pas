unit WebAPI.Clipboard;

uses WebAPI;

function CopyTextToClipboard(const text : String) : Boolean;
begin
   var textArea := Document.createElement('textarea');
   var style := textArea.style;

   style.position := 'absolute';
   style.top := 0;
   style.left := 0;
   style.width := '2em';
   style.height := '2em';
   style.opacity := 0;

   textArea.value := text;

   Document.body.appendChild(textArea);
   try
      textArea.select();
      Result := Document.execCommand('copy');
   finally
      Document.body.removeChild(textArea);
   end;
end;
