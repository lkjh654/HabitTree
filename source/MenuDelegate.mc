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
            callback.onRestart();
        } else if(item == :exit) {
            //no-op
        }
    }
}
