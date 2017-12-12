unit WebAPI.Clipboard;

uses WebAPI;

function CopyTextToClipboard(const text : String; container : Variant = nil) : Boolean;
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

   container := container ?? QuerySelector('.modal.in') ?? Document.body;

   container.appendChild(textArea);
   try
      textArea.select();
      Result := Document.execCommand('copy');
   finally
      container.removeChild(textArea);
   end;
end;
