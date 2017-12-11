unit WebAPI.CRC32;

interface

uses WebAPI.TypedArrays;

type
   CRC32 = static class
      class function Update(partialCRC : Integer; const data : JUint8Array) : Integer; static;
      class function Finalize(partialCRC : Integer) : Integer; static;

      class function Full(const data : JUint8Array) : Integer; static;
   end;

implementation

var
   vTable : array  of Integer;

procedure InitCrc32Table;
begin
   for var i := 0 to 255 do begin
      var c := i;
      for var n := 1 to 8 do begin
         if (c and 1)<>0 then
            c := Unsigned32((c shr 1) xor $edb88320)
         else c := c shr 1;
       end;
       vTable.Add(c);
   end;
end;

class function CRC32.Update(partialCRC : Integer; const data : JUint8Array) : Integer;
begin
   if vTable.Length = 0 then
      InitCrc32Table;
   Result := Unsigned32(partialCRC);
   for var i := 0 to data.byteLength-1 do
      Result := vTable[(Result xor data[i]) and $ff] xor (Result shr 8);
end;

class function CRC32.Finalize(partialCRC: Integer): Integer;
begin
   Result := Unsigned32(partialCRC xor -1);
end;

class function CRC32.Full(const data: JUint8Array): Integer;
begin
   Result := Unsigned32(Update(-1, data) xor -1);
end;

