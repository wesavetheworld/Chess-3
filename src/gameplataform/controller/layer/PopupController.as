package gameplataform.controller.layer {

import flash.display.DisplayObjectContainer;

import gameplataform.view.popup.HoldPopup;
import gameplataform.view.popup.SignUp;

/**
 * @author bona
 */

public class PopupController extends LayerControllerBase {

    public var holdPopup:HoldPopup;
    public var signUp:SignUp;

    public function PopupController(inPlaceHolder:DisplayObjectContainer) {
        super(inPlaceHolder, "PopupController");
    }


    public function showHold(message:String = "WAIT..."):void {
        holdPopup = new HoldPopup();
        holdPopup.text = message;
        super.addChild(holdPopup, "searching");
    }

    public function hideHold():void {
        if(holdPopup && super.placeHolder.contains(holdPopup)) {
            super.removeChild(holdPopup);
        }
        holdPopup = null;
    }


    public function showSignup():void {
        signUp = new SignUp();
        super.addChild(signUp, "signup");
    }

    public function hideSignup():void {
        if(signUp != null && super.placeHolder.contains(signUp)) {
            signUp.destroy();
            super.removeChild(signUp);
        }
        signUp = null;
    }
}

}