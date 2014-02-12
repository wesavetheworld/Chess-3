package gameplataform.controller.layer {

import flash.display.DisplayObjectContainer;

import gameplataform.view.popup.PopupSearching;

/**
 * @author bona
 */

public class PopupController extends LayerControllerBase {

    public var searching:PopupSearching;

    public function PopupController(inPlaceHolder:DisplayObjectContainer) {
        super(inPlaceHolder, "PopupController");
    }


    public function showSearching():void {
        searching = new PopupSearching();
        addChild(searching, "searching");
    }

    public function hideSearching():void {
        if(searching && super.placeHolder.contains(searching)) {
            super.removeChild(searching);
        }
    }
}

}