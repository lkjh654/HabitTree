using Toybox.WatchUi;
using Toybox.Graphics;

class MenuDelegate extends WatchUi.MenuInputDelegate {

    var callback;

    function initialize(c) {
        MenuInputDelegate.initialize();
        callback = c;
    }

    function onMenuItem(item) {

        if(item == :resist) {
            callback.onResist();
        } else if(item == :plant) {
            WatchUi.pushView(new Rez.Menus.ConfirmationMenu(), new ConfirmationMenuDelegate(callback), WatchUi.SLIDE_LEFT);
        } else if(item == :exit) {
            //no-op
        }
    }
}
