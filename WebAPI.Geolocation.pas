unit WebAPI.Geolocation;

interface

type

   JGeolocationCoordinates = class external 'GeolocationCoordinates'

      latitude : Float;
      longitude : Float;
      altitude : Variant;
      accuracy : Float;
      altitudeAccuracy : Variant;
      heading : Variant;
      speed : Variant;

   end;

   JGeolocationPosition = class external 'GeolocationPosition'

      coords : JGeolocationCoordinates;
      timestamp : Integer;

   end;

   GeolocationErrorCode = enum (
      ERMISSION_DENIED	= 1,
      POSITION_UNAVAILABLE	= 2,
      TIMEOUT = 3
   );

   JGeolocationPositionError = class external 'GeolocationPositionError'

      code : GeolocationErrorCode;
      message : String;

   end;

   JGeolocation = class external 'Geolocation'

      procedure ClearWatch(id : Integer); external 'clearWatch';

      procedure GetCurrentPosition(success : procedure (p : JGeolocationPosition)); overload; external 'getCurrentPosition';
      procedure GetCurrentPosition(success : procedure (p : JGeolocationPosition);
                                   error : procedure (e : JGeolocationPositionError)); overload; external 'getCurrentPosition';
      procedure GetCurrentPosition(success : procedure (p : JGeolocationPosition);
                                   error : procedure (e : JGeolocationPositionError);
                                   options : Variant); overload; external 'getCurrentPosition';

      function WatchPosition(success : procedure (p : JGeolocationPosition)) : Integer; overload; external 'watchPosition';
      function WatchPosition(success : procedure (p : JGeolocationPosition);
                             error : procedure (e : JGeolocationPositionError)) : Integer; overload; external 'watchPosition';
      function WatchPosition(success : procedure (p : JGeolocationPosition);
                             error : procedure (e : JGeolocationPositionError);
                             options : Variant) : Integer; overload; external 'watchPosition';

   end;

function Geolocation : JGeolocation; external 'navigator.geolocation' property;
