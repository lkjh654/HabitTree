using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Timer;

const RESTART_TIMESTAMP_KEY = 0;
const RESTARTED_TIMES_KEY = 1;
const RESISTED_TIMES_KEY = 2;

class TreeView extends WatchUi.View {

    const image_y_offset = 0;

    var image;

    var restartTimestamp;
    var restartedTimes;
    var resistedTimes;

    var updateTimer;

    var loadedResource = null;

    function initialize() {
        View.initialize();

        restartTimestamp = objectStoreGet(RESTART_TIMESTAMP_KEY);
        restartedTimes = objectStoreGet(RESTARTED_TIMES_KEY);
        resistedTimes = objectStoreGet(RESISTED_TIMES_KEY);

        if(restartedTimes == null) {
            restartedTimes = 0;
        }
        if(resistedTimes == null) {
            resistedTimes = 0;
        }

        if(restartTimestamp == null) {
            plant();
        }

        updateTimer = new Timer.Timer();
    }

    function onLayout(dc) {

    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();

        var text_y_offset = dc.getFontHeight(Graphics.FONT_XTINY);

        var centerX = screenWidth / 2;
        var centerY = screenHeight / 2;

        var now = Time.now().value();

        var elapsed = now - restartTimestamp;

        updateLoadedResource(elapsed);

        var days = elapsed / Gregorian.SECONDS_PER_DAY;
        var hours = (elapsed - Gregorian.SECONDS_PER_DAY * days) / Gregorian.SECONDS_PER_HOUR;

        var age = days + "d " + hours + "h";

        var imageX = (screenWidth - image.getWidth())/2;
        var imageY = (screenHeight - image.getHeight())/2 + image_y_offset;

        dc.drawBitmap(
            imageX,
            imageY,
            image
        );

        var ageX = centerX;
        var ageY = screenHeight - text_y_offset;

        dc.drawText(
            ageX,
            ageY,
            Graphics.FONT_XTINY,
            age,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );

        var resistedTimesX = centerX;
        var resistedTimesY = 0 + text_y_offset;

        var resistedTimesText = "" + resistedTimes;

        dc.drawText(
            resistedTimesX,
            resistedTimesY,
            Graphics.FONT_XTINY,
            resistedTimesText,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }

    function onShow() {
        updateTimer.start(method(:requestUpdate), 60 * 1000, true);
    }


    function onHide() {
        updateTimer.stop();
    }

    function requestUpdate() {
        WatchUi.requestUpdate();
    }

    function onRestart() {
        restart();
        WatchUi.requestUpdate();
    }

    function onResist() {
        incrementResistedCounter();
        WatchUi.requestUpdate();
    }

    function restart() {
        restartedTimes++;
        objectStorePut(RESTARTED_TIMES_KEY, restartedTimes);
        plant();
    }

    function incrementResistedCounter() {
        resistedTimes++;
        objectStorePut(RESISTED_TIMES_KEY, resistedTimes);
    }

    function plant() {
        restartTimestamp = Time.now().value();
        resistedTimes = 0;
        objectStorePut(RESISTED_TIMES_KEY, resistedTimes);
        objectStorePut(RESTART_TIMESTAMP_KEY, restartTimestamp);
    }

    function updateLoadedResource(elapsedSeconds) {
        var resourceToLoad = null;
        if(elapsedSeconds < Gregorian.SECONDS_PER_HOUR) {
            resourceToLoad = Rez.Drawables.tree_0;
        } else if(elapsedSeconds < Gregorian.SECONDS_PER_DAY) {
            resourceToLoad = Rez.Drawables.tree_1;
        } else if(elapsedSeconds < 7 * Gregorian.SECONDS_PER_DAY) {
            resourceToLoad = Rez.Drawables.tree_2;
        } else if(elapsedSeconds < 30 * Gregorian.SECONDS_PER_DAY) {
            resourceToLoad = Rez.Drawables.tree_3;
        } else {
            resourceToLoad = Rez.Drawables.tree_4;
        }

        if(resourceToLoad != loadedResource) {
            image = WatchUi.loadResource( resourceToLoad );
            loadedResource = resourceToLoad;
        }
    }

}
