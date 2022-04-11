unit WebAPI.Fetch;

interface

uses WebAPI.Core, WebAPI.Promises;

type

   JResponse = class external 'Response'

      Ok : Boolean; external 'ok';
      Status : Integer; external 'status';
      StatusText : Integer; external 'statusText';

      function JSON : JPromise<Variant>; external 'json';
      function Text : JPromise<String>; external 'text';

   end;

   JFormData = class external 'FormData'

      constructor Create();

      procedure Append(name, value : String); overload; external 'append';

   end;

   JURLSearchParams = class external 'URLSearchParams'

      constructor Create(data : Variant);

   end;

function Fetch(res : String) : JPromise<JResponse>; overload; external 'fetch';
function Fetch(res : String; init : Variant) : JPromise<JResponse>; overload; external 'fetch';

procedure FetchJSON(res : String; success : procedure (data : Variant); fail : procedure (r : JResponse)); overload;
procedure FetchJSON(res : String; success : procedure (data : Variant)); overload;
procedure PostRawBody(res, dataType : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));
procedure PostJSON(res : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));
procedure PostFormData(res : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));
procedure PostURLEncoded(res : String; data : Variant; success : procedure (data : Variant); fail : procedure (r : JResponse));

implementation

procedure FetchJSON(res: String; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   Fetch(res, class
      credentials := 'same-origin'
   end).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success)
      else fail(r)
   end).Catch(fail);
end;

procedure FetchJSON(res: String; success: procedure (data: Variant));
begin
   Fetch(res, class
      credentials := 'same-origin'
   end).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success);
   end);
end;

procedure PostRawBody(res, dataType: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   var init : Variant = class
      'method' := 'POST';
      credentials := 'same-origin';
      body := data;
   end;
   if dataType <> '' then
      init.headers := class
         'Content-Type' := dataType;
      end;
   Fetch(res, init).&Then(lambda (r : JResponse)
      if r.Ok then
         r.JSON.&Then(success)
      else fail(r)
   end).Catch(fail);
end;

procedure PostJSON(res: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   PostRawBody(res, 'application/json', JSON.Stringify(data), success, fail);
end;

procedure PostFormData(res: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   var fd := new JFormData;
   for var k in data do
      fd.Append(k, JSON.Stringify(data[k]));
   PostRawBody(res, '', fd, success, fail);
end;

procedure PostURLEncoded(res: String; data: Variant; success: procedure (data: Variant); fail: procedure (r: JResponse));
begin
   PostRawBody(res, 'application/x-www-form-urlencoded', new JURLSearchParams(data), success, fail);
end;

