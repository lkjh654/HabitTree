using Toybox.WatchUi;
using Toybox.Graphics;

class ConfirmationMenuDelegate extends WatchUi.MenuInputDelegate {

    var callback;

    function initialize(c) {
        MenuInputDelegate.initialize();
        callback = c;
    }

    function onMenuItem(item) {

        if(item == :yes) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            callback.onRestart();
        } else {
            //no-op
        }
    }
}
