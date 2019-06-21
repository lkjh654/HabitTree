using Toybox.Application;

class TreeApp extends Application.AppBase {

    var view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        view = new TreeView();
        return [ view, new InputDelegate(view) ];
    }

    (:glance)
    function getGlanceView() {
        return [ new TreeGlanceView() ];
    }
}

function objectStoreGet(key) {
    return Application.getApp().getProperty(key);
}

function objectStorePut(key, value) {
    Application.getApp().setProperty(key, value);
}
