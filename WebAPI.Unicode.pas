unit WebAPI.Unicode;

uses WebAPI.Core, WebAPI.TypedArrays;

type
   UTF8Encoder = class static

      class function Encode(s : String) : JUint8Array; static;
      begin
      	var i := 0;
      	var bytes := new JUint8Array(s.Length * 4);
      	for var ci := 1 to s.Length do begin
      		var c := Ord(s[ci]);
      		if c < 128 then begin
      			bytes[i] := c;
               i += 1;
      		end else begin
               if c < 2048 then begin
         			bytes[i] := (c shr 6) or 192;
                  i += 1;
      		   end else begin
                  // c <= 0xffff
      			   bytes[i] := (c shr 12) or 224;
      			   bytes[i+1] := ((c shr 6) and 63) or 128;
                  i += 2;
      		   end;
      		   bytes[i] := (c and 63) or 128;
               i += 1;
            end;
      	end;
      	Result := bytes.SubArray(0, i);
      end;

   end;

type
   UTF16LEEncoder = class static

      class function Encode(s : String) : JUint8Array; static;
      begin
      	var i := 0;
      	Result := new JUint8Array(s.Length * 2);
      	for var ci := 1 to s.Length do begin
      		var c := Ord(s[ci]);
            Result[i] := c and 255;
            Result[i+1] := c shr 8;
            i += 2;
      	end;
      end;

   end;


