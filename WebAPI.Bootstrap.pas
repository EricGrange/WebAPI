unit WebAPI.Bootstrap;

uses WebAPI.jQuery.Core;

type
   JJQuery = partial class external 'jQuery'

      function Modal(command : String) : Variant; external 'modal';

      function Popover(options : Variant) : Variant; external 'popover';

   end;
