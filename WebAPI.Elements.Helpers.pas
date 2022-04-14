unit WebAPI.Elements.Helpers;

interface

uses WebAPI.Elements, WebAPI.Core;

type

   JElementHelper = helper for JElement

      function AppendHTML(html : String) : JElement;
      function PrependHTML(html : String) : JElement;

      function HTML : String; overload;
      function HTML(htmlContent : String) : JElement; overload;
      function Text : String; overload;
      function Text(txt : String) : JElement; overload;

      function Click(callback : procedure) : JElement; overload;
      function Click(callback : procedure (event : Variant)) : JElement; overload;
      function On(eventTypes : String; callback : procedure) : JElement; overload;
      function On(eventTypes : String; callback : procedure (event : Variant)) : JElement; overload;

      function AddClass(aClass : String) : JElement;
      function RemoveClass(aClass : String) : JElement;
      function CSS(styles : Variant) : JElement;

      function FadeOut(durationMSec : Integer; callback : procedure) : JElement;
   end;

   JElementsHelper = helper for JElements

      procedure Each(callback : procedure (element : JElement));

      function Click(callback : procedure) : JElements; overload;
      function Click(callback : procedure (event : Variant)) : JElements; overload;
      function On(eventTypes : String; callback : procedure) : JElements; overload;
      function On(eventTypes : String; callback : procedure (event : Variant)) : JElements; overload;

      function AddClass(aClass : String) : JElements;
      function RemoveClass(aClass : String) : JElements;
      function CSS(styles : Variant) : JElements;

      procedure SetAttribute(name, value : String);
      property Attr[name : String] : String write SetAttribute;

   end;

implementation

// JElementHelper

function JElementHelper.PrependHTML(html: String) : JElement;
begin
   InsertAdjacentHTML('afterbegin', html);
   Result := Self;
end;

function JElementHelper.AppendHTML(html: String) : JElement;
begin
   InsertAdjacentHTML('beforeend', html);
   Result := Self;
end;

function JElementHelper.HTML : String;
begin
   Result := InnerHTML;
end;

function JElementHelper.HTML(htmlContent: String): JElement;
begin
   InnerHTML := htmlContent;
   Result := Self;
end;

function JElementHelper.Text : String;
begin
   Result := TextContent;
end;

function JElementHelper.Text(txt: String): JElement;
begin
   TextContent := txt;
   Result := Self;
end;

function JElementHelper.Click(callback: procedure) : JElement;
begin
   AddEventListener('click', @callback, True);
   Result := Self;
end;

function JElementHelper.Click(callback: procedure(event : Variant)) : JElement;
begin
   AddEventListener('click', @callback, True);
   Result := Self;
end;

function JElementHelper.On(eventTypes: String; callback: procedure) : JElement;
begin
   for var typ in eventTypes.Split(' ') do
      AddEventListener(typ, @callback, True);
   Result := Self;
end;

function JElementHelper.On(eventTypes: String; callback: procedure (event : Variant)): JElement;
begin
   for var typ in eventTypes.Split(' ') do
      AddEventListener(typ, @callback, True);
   Result := Self;
end;

function JElementHelper.AddClass(aClass: String): JElement;
begin
   ClassList.Add(aClass);
   Result := Self;
end;

function JElementHelper.RemoveClass(aClass: String): JElement;
begin
   ClassList.Remove(aClass);
   Result := Self;
end;

function JElementHelper.CSS(styles: Variant): JElement;
begin
   for var k in styles do
      Style.setProperty(k, styles[k]);
   Result := Self;
end;

function JElementHelper.FadeOut(durationMSec: Integer; callback: procedure  ): JElement;
begin
   var sv = Variant(Self);
   if sv._fx then ClearTimeout(sv._fx);
   Self.Style.transition := 'none';
   Self.Style.opacity := 1;
   Self.Style.transition := '.2s';
   Self.Style.opacity := 0;
   sv._fx := SetTimeout(
      lambda
         sv._fx := 0;
         callback;
      end, durationMSec
   );
   Result := Self;
end;

// JElementsHelper

procedure JElementsHelper.Each(callback: procedure (element: JElement));
begin
   Variant(Self).forEach(@callback);
end;

function JElementsHelper.Click(callback: procedure): JElements;
begin
   Result := On('click', @callback);
end;

function JElementsHelper.Click(callback: procedure (event: Variant)): JElements;
begin
   Result := On('click', @callback);
end;

function JElementsHelper.On(eventTypes: String; callback: procedure): JElements;
begin
   for var typ in eventTypes.Split(' ') do
      for var i := 0 to Self.High do
         Self[i].AddEventListener(typ, @callback, True);
   Result := Self;
end;

function JElementsHelper.On(eventTypes: String; callback: procedure (event : Variant)): JElements;
begin
   for var typ in eventTypes.Split(' ') do
      for var i := 0 to Self.High do
         Self[i].AddEventListener(typ, @callback, True);
   Result := Self;
end;

function JElementsHelper.AddClass(aClass: String): JElements;
begin
   for var i := 0 to Self.High do
      Self[i].ClassList.Add(aClass);
   Result := Self;
end;

function JElementsHelper.RemoveClass(aClass: String): JElements;
begin
   for var i := 0 to Self.High do
      Self[i].ClassList.Remove(aClass);
   Result := Self;
end;

function JElementsHelper.CSS(styles: Variant): JElements;
begin
   for var i := 0 to Self.High do
      Self[i].CSS(styles);
   Result := Self;
end;

procedure JElementsHelper.SetAttribute(name: String; value: String);
begin
   for var i := 0 to Self.High do
      Self[i].SetAttribute(name, value);
end;


