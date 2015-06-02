unit WebAPI.CSS;

interface

function CSSVendorPrefix : String;

implementation

uses WebAPI;

// CSSVendorPrefix
//
function CSSVendorPrefix : String;

   function GuessPrefix : String;
   begin
      var styles := Window.getComputedStyle(Document.body, '');
      for var s in styles do begin
         var p : String = styles[s];
         if p.StartsWith('-') then begin
            Result := p.Left(PosEx('-', p, 2));
            Break;
         end;
      end;
      Window.CSSVendorPrefix := Result
   end;

begin
   Result := Window.CSSVendorPrefix ?? GuessPrefix;
end;
