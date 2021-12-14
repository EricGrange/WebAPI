unit WebAPI.SubtleCrypto;

interface

uses WebAPI, WebAPI.TypedArrays;

type

   JSubtleCrypto = class external 'SubtleCrypto'
      function Digest(algorithm : String; data : JArrayBuffer) : JArrayBufferPromise; external 'digest';
   end;


function SubtleCrypto : JSubtleCrypto; external 'window.crypto.subtle' property;


