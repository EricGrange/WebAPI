unit WebAPI.Files;

interface

uses WebAPI.TypedArrays;

type

   JBlob = class external 'Blob'
      constructor Create(data : array of Variant; options : Variant);
      Size : Integer; external 'size';
      TypeMime : String; external 'type';
      function ArrayBuffer : JArrayBufferPromise; external 'arrayBuffer';
      function Slice(startByte, endByte : Integer) : JBlob; external 'slice';
   end;

   JFileReader = class external "FileReader"
      procedure AddEventListener(event : String; callback : procedure; useCapture : Boolean); external 'addEventListener';
      procedure ReadAsDataURL(input : Variant); external 'readAsDataURL';
      procedure ReadAsArrayBuffer(blob : JBlob); external 'readAsArrayBuffer';
   end;

   JFile = class external 'File' (JBlob)
      Name : String; external 'name';
   end;

   JFileList = array of JFile;
