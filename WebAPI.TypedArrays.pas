unit WebAPI.TypedArrays;

interface

uses WebAPI;

type
   JArrayBuffer = class external 'ArrayBuffer'
      public
         byteLength : Integer; // Read Only
         function  Slice(aBegin : Integer; aEnd : Integer) : JArrayBuffer; external 'slice';
         constructor Create(aLength : Integer);
   end;

   JArrayBufferView = class external
      public
         buffer : JArrayBuffer; // Read Only
         byteOffset : Integer; // Read Only
         byteLength : Integer; // Read Only
   end;

   JTypedArray = class external (JArrayBufferView)
      public
         BYTES_PER_ELEMENT : Integer; // Read Only

         &length : Integer; // Read Only

         procedure Set(aArray : JTypedArray; offset : Integer); overload; external 'set';

         constructor Create(aLength : Integer); overload;
         constructor Create(aArray : JTypedArray); overload;
         constructor Create(buffer : JArrayBuffer; byteOffset, aLength : Integer); overload;
   end;

   JIntegerTypedArray = class abstract external (JTypedArray)
      public
         function GetItems(index : Integer) : Integer; external array;
         procedure SetItems(index : Integer; value : Integer); external array;
         property Items[index : Integer] : Integer read getItems write setItems; default;

         procedure Set(aArray : array of Integer; offset : Integer); overload; external 'set';

         constructor Create(aArray : array of Integer); overload;
   end;

   JInt8Array = class external 'Int8Array' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 1;
         function  SubArray(aBegin, aEnd : Integer) : JInt8Array; external 'subarray';
   end;

   JUint8Array = class external 'Uint8Array' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 1;
         function  SubArray(aBegin, aEnd : Integer) : JUint8Array; external 'subarray';
   end;

   JUint8ClampedArray = class external 'Uint8ClampedArray' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 1;
         function  SubArray(aBegin, aEnd : Integer) : JUint8ClampedArray; external 'subarray';
   end;

   JInt16Array = class external 'Int16Array' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 2;
         function  SubArray(aBegin, aEnd : Integer) : JInt16Array; external 'subarray';
   end;

   JUint16Array = class external 'Uint16Array' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 2;
         function  SubArray(aBegin, aEnd : Integer) : JUint16Array; external 'subarray';
   end;

   JInt32Array = class external 'Int32Array' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 4;
         function  SubArray(aBegin, aEnd : Integer) : JInt32Array; external 'subarray';
   end;

   JUint32Array = class external 'Uint32Array' (JIntegerTypedArray)
      public
         const BYTES_PER_ELEMENT = 4;
         function  SubArray(aBegin, aEnd : Integer) : JUint32Array; external 'subarray';
   end;

   JFloatTypedArray = class abstract external (JTypedArray)
      public
         function GetItems(index : Integer) : Float; external array;
         procedure SetItems(index : Integer; value : Float); external array;
         property Items[index : Integer] : Float read getItems write setItems; default;

         procedure Set(aArray : array of Float; offset : Integer); overload; external 'set';

         constructor Create(aArray : array of Float); overload;
   end;

   JFloat32Array = class external 'Float32Array' (JFloatTypedArray)
      public
         const BYTES_PER_ELEMENT = 4;
         function  SubArray(aBegin, aEnd : Integer) : JFloat32Array; external 'subarray';
   end;

   JFloat64Array = class external 'Float64Array' (JFloatTypedArray)
      public
         const BYTES_PER_ELEMENT = 8;
         function  SubArray(aBegin, aEnd : Integer) : JFloat64Array; external 'subarray';
   end;


   JDataView = class external 'DataView' (JArrayBufferView)
      public

         constructor Create(buffer : JArrayBuffer; byteOffset, byteLength : Integer);
         // Gets the value of the given type at the specified byte offset
         // from the start of the view. There is no alignment constraint;
         // multi-byte values may be fetched from any offset.
         //
         // For multi-byte values, the littleEndian argument
         // indicates whether a big-endian or little-endian value should be
         // read. If false or undefined, a big-endian value is read.
         //
         // These methods raise an exception if they would read
         // beyond the end of the view.
         function  getInt8(byteOffset : Integer) : Integer;
         function  getUint8(byteOffset : Integer) : Integer;
         function  getInt16(byteOffset : Integer; littleEndian : Boolean) : Integer;
         function  getUint16(byteOffset : Integer; littleEndian : Boolean) : Integer;
         function  getInt32(byteOffset : Integer; littleEndian : Boolean) : Integer;
         function  getUint32(byteOffset : Integer; littleEndian : Boolean) : Integer;
         function  getFloat32(byteOffset : Integer; littleEndian : Boolean) : Float;
         function  getFloat64(byteOffset : Integer; littleEndian : Boolean) : Float;

         // Stores a value of the given type at the specified byte offset
         // from the start of the view. There is no alignment constraint;
         // multi-byte values may be stored at any offset.
         //
         // For multi-byte values, the littleEndian argument
         // indicates whether the value should be stored in big-endian or
         // little-endian byte order. If false or undefined, the value is
         // stored in big-endian byte order.
         //
         // These methods raise an exception if they would write
         // beyond the end of the view.
         procedure setInt8(byteOffset : Integer; value : Integer);
         procedure setUint8(byteOffset : Integer; value : Integer);
         procedure setInt16(byteOffset : Integer; value : Integer; littleEndian : Boolean);
         procedure setUint16(byteOffset : Integer; value : Integer; littleEndian : Boolean);
         procedure setInt32(byteOffset : Integer; value : Integer; littleEndian : Boolean);
         procedure setUint32(byteOffset : Integer; value : Integer; littleEndian : Boolean);
         procedure setFloat32(byteOffset : Integer; value : Float; littleEndian : Boolean);
         procedure setFloat64(byteOffset : Integer; value : Float; littleEndian : Boolean);
   end;

function StringToUTF8Bytes(s : String) : JUint8Array;

function BytesToBase64(bytes : JUint8Array) : String;
function BytesToHex(bytes : JUint8Array) : String;

implementation

function StringToUTF8Bytes(s: String): JUint8Array;
begin
   s := StrToUTF8(s);
   Result := new JUint8Array(s.Length);
   for var i := 0 to s.Length-1 do
      Result[i] := Ord(s[i+1]);
end;

function BytesToBase64(bytes : JUint8Array) : String;
begin
   var b := '';
   for var i := 0 to bytes.byteLength-1 do
      b += Chr(bytes[i]);
   Result := Window.btoa(b);
end;

function BytesToHex(bytes: JUint8Array): String;
begin
   for var i := 0 to bytes.byteLength-1 do
      Result += IntToHex(bytes[i], 2);
end;

