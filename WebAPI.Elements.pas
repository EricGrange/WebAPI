unit WebAPI.Elements;

interface

type

   JDOMTokenList = class external 'DOMTokenList'

      procedure Add(token : String); external 'add';
      procedure Remove(token : String); external 'remove';
      procedure Toggle(token : String); external 'toggle';

   end;

   JElement = class;
   JElements = array of JElement;

   JElement = class external 'Element'

      procedure Append(element : JElement); overload; external 'append';
      procedure Append(element : array of JElement); overload; external 'append';

      procedure InsertAdjacentHTML(position, html : String); external 'insertAdjacentHTML';

      function GetAttribute(name : String) : String; external 'getAttribute';
      procedure SetAttribute(name, value : String); external 'setAttribute';
      property Attr[name : String] : String read GetAttribute write SetAttribute;

      function QuerySelector(filter : String) : JElement; external 'querySelector';
      function QuerySelectorAll(filter : String) : JElements; external 'querySelectorAll';

      procedure Remove(); external 'remove';

      ClassList : JDOMTokenList; external 'classList';
      InnerHTML : String; external 'innerHTML';
      ParentElement : JElement; external 'parentElement';
      Style : Variant; external 'style';
      TextContent : String; external 'textContent';
      Value : String; external 'value';

      procedure AddEventListener(eventType : String; callback : procedure); overload; external 'addEventListener';

   end;

