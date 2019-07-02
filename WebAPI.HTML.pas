unit WebAPI.HTML;

interface

uses WebAPI;

type
   t = array of string;
   HTMLSanitizer = class static sealed
      private
         class var vAllowedTags : Variant := class
            'b' : array of String;
            'em' : array of String;
            'i' : array of String;
            'u' : array of String;
            'strong' : array of String;
            'strike' : array of String;
      
            'br' : array of String;
            'hr' : array of String;
      
            'a' := ['href', 'name', 'target'];
            'p' : array of String;
            'div' : array of String;
            'span' : array of String;
            'pre' : array of String;
            'code' : array of String;
            'blockquote' : array of String;
      
            'h1' : array of String;
            'h2' : array of String;
            'h3' : array of String;
            'h4' : array of String;
      
            'ul' : array of String;
            'ol' : array of String;
            'nl' : array of String;
            'li' : array of String;
         end;
         class var vAllowedSchemes : Variant := class
            'http' := '*';
            'https' := '*';
            'ftp' := '*';
            'mailto' := '*';
         end;

      public
         class function DOMtoJSON(node : Variant; sanitize : Boolean = True) : Variant; static;
         class function JSONtoDOM(obj : Variant) : Variant; static;

         class property AllowedTags : Variant read vAllowedTags write vAllowedTags;
         class property AllowedSchemes : Variant read vAllowedSchemes write vAllowedSchemes;
   end;

implementation

class function HTMLSanitizer.DOMtoJSON(node : Variant; sanitize : Boolean = True) : Variant;
begin
	if node.nodeType = 1 then begin
      var tagName := node.tagName.toLowerCase();
      var allowedAttributes := HTMLSanitizer.AllowedTags[tagName];
      if sanitize and not allowedAttributes then exit nil;
	   Result := class tag := node.tagName.toLowerCase() end;
		var attrs := node.attributes;
		if attrs and (attrs.length > 0) then begin
			Result.attr := new JObject;
			for var i := attrs.length-1 downto 0 do begin
            var attrName := attrs[i].nodeName.toLowerCase();
            var attrValue := attrs[i].nodeValue;
            if sanitize and allowedAttributes[attrName] then begin
               if attrName in ['href', 'src'] then
                  if not HTMLSanitizer.AllowedSchemes[attrValue.Before(':')] then
                     attrName := '';
            end;
            if attrName <> '' then
				   Result.attr[attrName] := attrValue;
         end;
		end;
		var nodes := node.childNodes;
		if nodes and (nodes.length > 0) then begin
			Result.nodes := [];
			for var i := 0 to nodes.length-1 do begin
				var child := HTMLSanitizer.DOMtoJSON(nodes[i]);
				if child <> nil then
               Result.nodes.push(child);
			end;
      end;
	end else if node.nodeType = 3 then begin
		Result := node.nodeValue;
	end else Result := nil;
end;

class function HTMLSanitizer.JSONtoDOM(obj : Variant) : Variant;
begin
	if TypeOf(obj)='string' then
      exit Document.createTextNode(obj);
   var allowedAttributes := HTMLSanitizer.AllowedTags[obj.tag];
   if not allowedAttributes then exit nil;
	Result := Document.createElement(obj.tag);
	if obj.attr then begin
		for var n in obj.attr do begin
         if allowedAttributes[n] then begin
            var attrValue := obj.attr[n];
            if n in ['href', 'src'] then
               if not HTMLSanitizer.AllowedSchemes[attrValue.Before(':')] then continue;
			   Result.setAttribute(n, obj.attr[n]);
         end;
      end;
   end;
   if obj.nodes then begin
		for var i := 0 to obj.nodes.length-1 do begin
         var child := HTMLSanitizer.JSONtoDOM(obj.nodes[i]);
         if child <> nil then
			   Result.appendChild(child);
      end;
   end;
end;


