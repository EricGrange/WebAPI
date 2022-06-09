unit WebAPI.jQuery.Core;

interface

type

   TJQueryAddClassFunction = function (index : Integer; currentClassName : String) : String;

   TJQueryEvent = function (eventObject : Variant) : Boolean;
   TJQueryProcEvent = procedure (eventObject : Variant);

   TJQueryElementFunction = function (index : Integer; element : Variant) : Boolean;

   TJQueryQueueFunction = procedure (next : procedure);

   TJQueryAjaxSuccess = procedure (data : Variant; textStatus : String; xhr : Variant);
   TJQueryAjaxSimpleSuccess = procedure (data : Variant);
   TJQueryCompareFunction = function (a, b : Variant) : Integer;

   TJQueryPosition = class external

      left : Integer;
      top : Integer;

   end;

   JjqXHR = class external 'jqXHR'

      Status : Integer; external 'status';
      StatusText : String; external 'statusText';
      ResponseText : String; external 'responseText';

      function Done(callback : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'done';
      function Done(callback : TJQueryAjaxSuccess) : JjqXHR; overload; external 'done';
      function Done(callback : procedure) : JjqXHR; overload; external 'done';

      function Fail(callback : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'fail';
      function Fail(callback : TJQueryAjaxSuccess) : JjqXHR; overload; external 'fail';
      function Fail(callback : procedure) : JjqXHR; overload; external 'fail';
      function Fail(callback : procedure (xhr : JjqXHR)) : JjqXHR; overload; external 'fail';

      function Always(callback : procedure) : JjqXHR; overload; external 'always';

      procedure Abort; external 'abort';

   end;

   JJQuery = partial class external 'jQuery'

      function Add(html : String) : JJQuery; overload; external 'add';
      function Add(selection : JJQuery) : JJQuery; overload; external 'add';
      function Add(selector : String; context : Variant) : JJQuery; overload; external 'add';

      function AddBack : JJQuery; overload; external 'addBack';
      function AddBack(selector : String) : JJQuery; overload; external 'addBack';

      function AddClass(classNames : String) : JJQuery; overload; external 'addClass';
      function AddClass(func : TJQueryAddClassFunction) : JJQuery; overload; external 'addClass';

      function After(content : String) : JJQuery; overload; external 'after';
      function After(content : JJQuery) : JJQuery; overload; external 'after';

      function Ajax(url : String; options : Variant) : JjqXHR; overload; external 'ajax';
      
      function AjaxSetup(options : Variant) : JjqXHR; overload; external 'ajaxSetup';

      function Animate(options : Variant) : JJQuery; overload; external 'animate';

      function Append(content : String) : JJQuery; overload; external 'append';
      function Append(content : JJQuery) : JJQuery; overload; external 'append';

      function Prepend(content : String) : JJQuery; overload; external 'prepend';
      function Prepend(content : JJQuery) : JJQuery; overload; external 'prepend';

      function AppendTo(content : String) : JJQuery; overload; external 'appendTo';
      function AppendTo(content : JJQuery) : JJQuery; overload; external 'appendTo';

      function Attr(name : String) : String; overload; external 'attr';
      function Attr(name : String; value : Variant) : JJQuery; overload; external 'attr';

      function Before(content : String) : JJQuery; overload; external 'before';
      function Before(content : JJQuery) : JJQuery; overload; external 'before';

      function Bind(eventType : String; handler : procedure) : JJQuery; overload; external 'bind';
      function Bind(eventType : String; handler : TJQueryEvent) : JJQuery; overload; external 'bind';
      function Bind(eventType : String; handler : TJQueryProcEvent) : JJQuery; overload; external 'bind';
      function Bind(eventType : String; eventData : Variant; handler : TJQueryEvent) : JJQuery; overload; external 'bind';
      function Bind(eventType : String; eventData : Variant; preventBubble : Boolean) : JJQuery; overload; external 'bind';

      function Blur : JJQuery; overload; external 'blur';
      function Blur(handler : TJQueryEvent) : JJQuery; overload; external 'blur';

      function Change(handler : procedure) : JJQuery; overload; external 'change';
      function Change : JJQuery; overload; external 'change';

      function Children(selector : String) : JJQuery; overload; external 'children';
      function Children : JJQuery; overload; external 'children';

      function Click : JJQuery; overload; external 'click';
      function Click(handler : procedure) : JJQuery; overload; external 'click';
      function Click(handler : TJQueryEvent) : JJQuery; overload; external 'click';
      function Click(handler : TJQueryProcEvent) : JJQuery; overload; external 'click';

      function Clone : JJQuery; overload; external 'clone';
      function Clone(withDataAndEvents : Boolean) : JJQuery; overload; external 'clone';
      function Clone(withDataAndEvents, deepWithDataAndEvents : Boolean) : JJQuery; overload; external 'clone';

      function Closest(selector : String) : JJQuery; overload; external 'closest';

      function Contents : JJQuery; overload; external 'contents';

      function CSS(name : String) : String; overload; external 'css';
      function CSS(name : String; value : Variant) : JJQuery; overload; external 'css';
      function CSS(nameValue : Variant) : JJQuery; overload; external 'css';

      function Data(key : String) : Variant; overload; external 'data';
      function Data(key : String; value : Variant) : JJQuery; overload; external 'data';

      function Deferred() : Variant; external;

      function Delay(duration : Integer) : JJQuery; overload; external 'delay';
      function Delay(duration : Integer; queueName : String) : JJQuery; overload; external 'delay';

      function DblClick : JJQuery; overload; external 'dblclick';
      function DblClick(handler : TJQueryEvent) : JJQuery; overload; external 'dblclick';

      function Detach : JJQuery; overload; external 'detach';
      function Detach(selector : String) : JJQuery; overload; external 'detach';

      function Each(func : TJQueryElementFunction) : JJQuery; external 'each';

      function Empty : JJQuery; external 'empty';

      function FadeIn : JJQuery; overload; external 'fadeIn';
      function FadeIn(duration : Integer) : JJQuery; overload; external 'fadeIn';
      function FadeIn(duration : Integer; complete : procedure) : JJQuery; overload; external 'fadeIn';
      function FadeOut : JJQuery; overload; external 'fadeOut';
      function FadeOut(duration : Integer) : JJQuery; overload; external 'fadeOut';
      function FadeOut(duration : Integer; complete : procedure) : JJQuery; overload; external 'fadeOut';
      function FadeTo(duration : Integer; opacity : Float) : JJQuery; overload; external 'fadeTo';
      function FadeTo(duration : Integer; opacity : Float; complete : procedure) : JJQuery; overload; external 'fadeTo';
      function FadeToggle : JJQuery; overload; external 'fadeToggle';
      function FadeToggle(duration : Integer) : JJQuery; overload; external 'fadeToggle';
      function FadeToggle(duration : Integer; complete : procedure) : JJQuery; overload; external 'fadeToggle';

      function Filter(selector : String) : JJQuery; overload; external 'filter';
      function Filter(selection : JJQuery) : JJQuery; overload; external 'filter';
      function Filter(func : TJQueryElementFunction) : JJQuery; overload; external 'filter';

      function Find(selector : String) : JJQuery; external 'find';

      function Finish : JJQuery; external 'finish';

      function First : JJQuery; external 'first';

      function Focus : JJQuery; external 'focus';

      function Get : array of Variant; overload; external 'get';
      function Get(url : String) : JjqXHR; overload; external 'get';
      function Get(url, data : String) : JjqXHR; overload; external 'get';
      function Get(url : String; success : procedure) : JjqXHR; overload; external 'get';
      function Get(url : String; success : TJQueryAjaxSuccess) : JjqXHR; overload; external 'get';
      function Get(url : String; success : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'get';
      function Get(url, data : String; success : TJQueryAjaxSuccess) : JjqXHR; overload; external 'get';
      function Get(url : String; data : JObject; success : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'get';

      function GetScript(url : String) : JjqXHR; overload; external 'getScript';
      function GetScript(url : String; success : procedure) : JjqXHR; overload; external 'getScript';

      function Has(selector : String) : JJQuery; external 'has';
      function Match(selector : String) : Boolean; external 'is';

      function HasClass(className : String) : Boolean; external 'hasClass';

      function Height : Integer; overload; external 'height';
      function Height(value : Variant) : JJQuery; overload; external 'height';

      function Hide : JJQuery; overload; external 'hide';
      function Hide(duration : Integer) : JJQuery; overload; external 'hide';
      function Hide(duration : Integer; complete : procedure) : JJQuery; overload; external 'hide';

      function Hover(handlerIn, handlerOut : TJQueryProcEvent) : JJQuery; overload; external 'hover';
      function Hover(handlerIn, handlerOut : procedure) : JJQuery; overload; external 'hover';

      function HTML : String; overload; external 'html';
      function HTML(htmlString : Variant) : JJQuery; overload; external 'html';

      function Index : Integer; overload; external 'index';
      function Index(element : Variant) : Integer; overload; external 'index';

      function InnerHeight : Integer; overload; external 'innerHeight';
      function InnerWidth : Integer; overload; external 'innerWidth';

      function InsertAfter(selector : String) : JJQuery; overload; external 'insertAfter';
      function InsertAfter(content : JJQuery) : JJQuery; overload; external 'insertAfter';

      function InsertBefore(selector : String) : JJQuery; overload; external 'insertBefore';
      function InsertBefore(content : JJQuery) : JJQuery; overload; external 'insertBefore';

      function KeyPress(event : TJQueryEvent) : JJQuery; overload; external 'keypress';
      function KeyPress(event : TJQueryProcEvent) : JJQuery; overload; external 'keypress';

      function Last : JJQuery; external 'last';

      function Load(url : String) : JJQuery; overload; external 'load';
      function Load(url, data : String) : JJQuery; overload; external 'load';
      function Load(url : String; success : TJQueryAjaxSimpleSuccess) : JJQuery; overload; external 'load';
      function Load(url : String; success : procedure) : JJQuery; overload; external 'load';
      function Load(url, data : String; success : TJQueryAjaxSimpleSuccess) : JJQuery; overload; external 'load';

      function Map(callback : function : Variant) : JJQuery; external 'map';

      function &Not(selector : String) : JJQuery; overload; external 'not';

      function On(event : String; callback : TJQueryEvent) : JJQuery; overload; external 'on';
      function On(event : String; callback : TJQueryProcEvent) : JJQuery; overload; external 'on';
      function On(event : String; callback : procedure) : JJQuery; overload; external 'on';
      function On(event, selector : String; callback : procedure) : JJQuery; overload; external 'on';
      function On(event, selector : String; callback : TJQueryEvent) : JJQuery; overload; external 'on';
      function Off : JJQuery; overload; external 'off';
      function Off(event : String) : JJQuery; overload; external 'off';

      function Offset : TJQueryPosition; overload; external 'offset';

      function OuterHeight : Integer; overload; external 'outerHeight';
      function OuterHeight(includeMargin : Boolean) : Integer; overload; external 'outerHeight';

      function OuterWidth : Integer; overload; external 'outerWidth';
      function OuterWidth(includeMargin : Boolean) : Integer; overload; external 'outerWidth';

      function Parent : JJQuery; overload; external 'parent';
      function Parents(selector : String) : JJQuery; overload; external 'parents';

      function Prev : JJQuery; overload; external 'prev';
      function Prev(selector : String) : JJQuery; overload; external 'prev';
      function Next : JJQuery; overload; external 'next';
      function Next(selector : String) : JJQuery; overload; external 'next';

      function ParseHTML(html : String) : Variant; external 'parseHTML';
      function ParseXML(html : String) : Variant; external 'parseXML';

      function Post(url : String) : JjqXHR; overload; external 'post';
      function Post(url, data : String) : JjqXHR; overload; external 'post';
      function Post(url : String; success : procedure) : JjqXHR; overload; external 'post';
      function Post(url : String; success : TJQueryAjaxSuccess) : JjqXHR; overload; external 'post';
      function Post(url : String; success : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'post';
      function Post(url, data : String; success : TJQueryAjaxSuccess) : JjqXHR; overload; external 'post';
      function Post(url, data : String; success : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'post';
      function Post(url : String; data : JObject) : JjqXHR; overload; external 'post';
      function Post(url : String; data : JObject; success : TJQueryAjaxSimpleSuccess) : JjqXHR; overload; external 'post';

      function Prop(name : String) : Variant; overload; external 'prop';
      function Prop(name : String; value : Variant) : JJQuery; overload; external 'prop';

      function Queue(callback : TJQueryQueueFunction) : JJQuery; overload; external 'queue';
      function Queue(queueName : String; callback : TJQueryQueueFunction) : JJQuery; overload; external 'queue';

      function Ready(handler : procedure) : JJQuery; external 'ready';

      function Remove : JJQuery; overload; external 'remove';
      function Remove(selector : String) : JJQuery; overload; external 'remove';

      function RemoveAttr(name : String) : JJQuery; external 'removeAttr';

      function RemoveClass(name : String) : JJQuery; external 'removeClass';

      function ReplaceWith(htmlString : Variant) : JJQuery; overload; external 'replaceWith';

      function Select : JJQuery; external 'select';

      function Show : JJQuery; overload; external 'show';
      function Show(duration : Integer) : JJQuery; overload; external 'show';
      function Show(duration : Integer; complete : procedure) : JJQuery; overload; external 'show';

      function SlideDown : JJQuery; overload; external 'slideDown';
      function SlideDown(duration : Integer) : JJQuery; overload; external 'slideDown';
      function SlideDown(duration : Integer; complete : procedure) : JJQuery; overload; external 'slideDown';
      function SlideToggle : JJQuery; overload; external 'slideToggle';
      function SlideToggle(duration : Integer) : JJQuery; overload; external 'slideToggle';
      function SlideToggle(duration : Integer; complete : procedure) : JJQuery; overload; external 'slideToggle';
      function SlideUp : JJQuery; overload; external 'slideUp';
      function SlideUp(duration : Integer) : JJQuery; overload; external 'slideUp';
      function SlideUp(duration : Integer; complete : procedure) : JJQuery; overload; external 'slideUp';

      function ScrollTop(value : Float) : JJQuery; external 'scrollTop';

      function Sort(compare : TJQueryCompareFunction) : JJQuery; external 'sort';

      function Text : String; overload; external 'text';
      function Text(textString : String) : JJQuery; overload; external 'text';

      function ToggleClass(className : String) : JJQuery; external 'toggleClass';

      function Trigger : JJQuery; overload; external 'trigger';
      function Trigger(handler : procedure) : JJQuery; overload; external 'trigger';
      function Trigger(handler : TJQueryEvent) : JJQuery; overload; external 'trigger';
      function Trigger(handler : TJQueryProcEvent) : JJQuery; overload; external 'trigger';
      function Trigger(textString : String) : JJQuery; overload; external 'trigger';

      function TriggerHandler : JJQuery; overload; external 'triggerHandler';
      function TriggerHandler(handler : procedure) : JJQuery; overload; external 'triggerHandler';
      function TriggerHandler(handler : TJQueryEvent) : JJQuery; overload; external 'triggerHandler';
      function TriggerHandler(handler : TJQueryProcEvent) : JJQuery; overload; external 'triggerHandler';
      function TriggerHandler(textString : String) : JJQuery; overload; external 'triggerHandler';
      function TriggerHandler(textString : String; data : Variant) : JJQuery; overload; external 'triggerHandler';

      function Typ(v : Variant) : String; external 'type';

      function Val : Variant; overload; external 'val';
      function Val(value : Variant) : JJQuery; overload; external 'val';

      function Width : Integer; overload; external 'width';
      function Width(value : Variant) : JJQuery; overload; external 'width';

      function GetItems(index : Integer) : Variant; external array;
      property Items[index : Integer] : Variant read GetItems; default;
      property length : Integer;

   end;

function jQuery(selector : Variant) : JJQuery; overload; external '$';
function jQuery : JJQuery; overload; external '$' property;

procedure jQueryReady(handler : procedure); external '$(document).ready';
