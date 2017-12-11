unit WebAPI.ZipWriter;

uses
   WebAPI, WebAPI.TypedArrays, WebAPI.CRC32;

type
   JZipFileEntry = class (JObject)
      Name : String;
      CompressionMethod : Integer;
      CompressedData : JUint8Array;
      UncompressedSize : Integer;
      Offset : Integer;
      CRC : Integer;

      function LocalSize : Integer;
      function WriteLocal(v : JDataView) : Integer;
      function WriteDirectory(v : JDataView) : Integer;
   end;

type
   JZipWriter = class (JObject)
      protected
         FEntries : array of JZipFileEntry;

      public
         procedure AddFile(name : String; data : JUint8Array);

         function ToByteArray : JUint8Array;
   end;


// structures from https://en.wikipedia.org/wiki/Zip_(file_format)#Structure

function JZipFileEntry.LocalSize : Integer;
begin
   Result := 30 + CompressedData.byteLength + Name.Length;
end;

function JZipFileEntry.WriteLocal(v : JDataView) : Integer;
begin
   v.setUint32( 0, $04034b50, True);     // Local file header signature = 0x04034b50 (read as a little-endian number)
   v.setUint16( 4, 10, True);            // Version needed to extract (minimum)
   v.setUint16( 6, 0, True);             // General purpose bit flag
   v.setUint16( 8, CompressionMethod, True); // Compression method, 0 = store
   v.setUint16(10, 0, True);	           // File last modification time
   v.setUint16(12, 0, True);             // File last modification date
   v.setUint32(14, CRC, True);             // CRC-32
   v.setUint32(18, CompressedData.byteLength, True); // Compressed size
   v.setUint32(22, UncompressedSize, True);          // Uncompressed size
   v.setUint16(26, Name.Length, True);   // File name length (n)
   v.setUint16(28, 0, True);             // Extra field length (m)
   Result := 30;
   // File name
   for var i := 1 to Name.Length do begin
      v.setUint8(Result, Ord(Name[i]));
      Result += 1;
   end;
   // Extra field
   // Compressed data
   for var i := 0 to CompressedData.byteLength-1 do begin
      v.setUint8(Result, CompressedData[i]);
      Result += 1;
   end;
end;

function JZipFileEntry.WriteDirectory(v : JDataView) : Integer;
begin
   v.setUint32( 0, $02014b50, True);    // Central directory file header signature = 0x02014b50
   v.setUint16( 4, $14, True);    // Version made by
   v.setUint16( 6, $14, True);    // Version needed to extract (minimum)
   v.setUint16( 8, 0, True);    // General purpose bit flag
   v.setUint16(10, 0, True);    // Compression method
   v.setUint16(12, 0, True);    // File last modification time
   v.setUint16(14, 0, True);    // File last modification date
   v.setUint32(16, CRC, True);    // CRC-32
   v.setUint32(20, CompressedData.byteLength, True);    // Compressed size
   v.setUint32(24, UncompressedSize, True);    // Uncompressed size
   v.setUint16(28, Name.Length, True);    // File name length (n)
   v.setUint16(30, 0, True);    // Extra field length (m)
   v.setUint16(32, 0, True);    // File comment length (k)
   v.setUint16(34, 0, True);    // Disk number where file starts
   v.setUint16(36, 0, True);    // Internal file attributes
   v.setUint32(38, 0, True);    // External file attributes
   v.setUint32(42, Offset, True);    // Relative offset of local file header. This is the number of bytes between the start of the first disk on which the file occurs, and the start of the local file header.
   //46	n	File name
   Result := 46;
   for var i := 1 to Name.Length do begin
      v.setUint8(Result, Ord(Name[i]));
      Result += 1;
   end;
   //46+n	m	Extra field
   //46+n+m	k	File comment
end;



procedure JZipWriter.AddFile(name: String; data: JUint8Array);
begin
   var entry := new JZipFileEntry;

   entry.CompressionMethod := 0;   // store
   entry.CompressedData := data;
   entry.UncompressedSize := data.byteLength;
   entry.Name := name;
   entry.CRC := CRC32.Full(data);

   FEntries.Add(entry);
end;

function JZipWriter.ToByteArray : JUint8Array;
begin
   var size := 1024 + FEntries.Length * 1024; // approx directory size
   for var i := 0 to FEntries.High do
      size += FEntries[i].LocalSize;

   var buffer := new JArrayBuffer(size);
   var offset := 0;
   for var i := 0 to FEntries.High do begin
      var view := new JDataView(buffer, offset, size-offset);
      FEntries[i].Offset := offset;
      offset += FEntries[i].WriteLocal(view);
   end;

   var eocdOffset := offset;

   for var i := 0 to FEntries.High do begin
      var view := new JDataView(buffer, offset, size-offset);
      offset += FEntries[i].WriteDirectory(view);
   end;

   // End of central directory record (EOCD)

   var view := new JDataView(buffer, offset, size-offset);
   view.setUint32( 0, $06054b50, True);           // End of central directory signature = 0x06054b50         
   view.setUint16( 4, 0, True);                   // Number of this disk
   view.setUint16( 6, 0, True);                   // Disk where central directory starts
   view.setUint16( 8, FEntries.Count, True);      // Number of central directory records on this disk
   view.setUint16(10, FEntries.Count, True);      // Total number of central directory records
   view.setUint32(12, offset-eocdOffset, True);   // Size of central directory (bytes)
   view.setUint32(16, eocdOffset, True);          // Offset of start of central directory, relative to start of archive
   view.setUint16(20, 0, True);                   // Comment length (n)
   // 22	n	Comment

   Result := new JUint8Array(buffer, 0, offset + 22);
end;

