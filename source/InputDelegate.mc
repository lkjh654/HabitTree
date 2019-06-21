using Toybox.WatchUi;

class InputDelegate extends WatchUi.BehaviorDelegate {

    var callback;

    function initialize(c) {
        BehaviorDelegate.initialize();
        callback = c;
    }

    function onSelect() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new MenuDelegate(callback), WatchUi.SLIDE_LEFT);
        return true;
    }

}
