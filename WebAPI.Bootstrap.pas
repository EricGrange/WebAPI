unit WebAPI.Bootstrap;

uses WebAPI.jQuery.Core;

type
   JJQuery = partial class external 'jQuery'

      function Modal(command : String) : JJQuery; external 'modal';

      function Popover(options : Variant) : JJQuery; external 'popover';

      function Tooltip(options : Variant) : JJQuery; external 'tooltip';

      function Tab(command : String) : JJQuery; external 'tab';

      function Dropdown : JJQuery; external 'dropdown';

   end;
