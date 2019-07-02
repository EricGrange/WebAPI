unit WebAPI.WebWorkers;

interface

type

   JAbstractWorker = class external 'AbstractWorker'
      constructor Create(workerURL : String);
      OnError : procedure (e : Variant); external 'onerror';
   end;

   JMessagePort = class external 'MessagePort'
      procedure PostMessage(msg : Variant); external 'postMessage';
      
      procedure Start; external 'start';
      procedure Close; external 'close';
      
      OnMessage : procedure (e : Variant); external 'onmessage';
      OnMessageError : procedure (e : Variant); external 'onmessageerror';
   end;

   JSharedWorker = class external 'SharedWorker' (JAbstractWorker)
      Port : JMessagePort; external 'port';
   end;

   JSharedWorkerGlobalScope = class external 'SharedWorkerGlobalScope'
      OnConnect : procedure (e: Variant); external 'onconnect';
      Name : String; external 'name'; // read only
      ApplicationCache : Variant; external 'applicationCache'; // read only
      procedure Close; external 'close';
   end;

function SharedWorkerGlobalScope : JSharedWorkerGlobalScope; external 'self' property;

implementation
