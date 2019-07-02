unit WebAPI.EventSource;

uses WebAPI;

type
   TReadyState = enum (Connecting = 0, Open = 1, Closed = 2);


type
   JEventSource = class external 'EventSource'

      constructor Create(eventSourceURL : String); default;

      procedure Close; external 'close';

      OnMessage : procedure (messageEvent : Variant); external 'onmessage';
      OnOpen : procedure (openEvent : Variant); external 'onopen';
      OnError : procedure (errorEvent : Variant); external 'onerror';

      ReadyState : TReadyState; external 'readyState';
      URL : String; external 'url';

   end;



