/**
 * Created by William on 2/13/14.
 */
package gameplataform.view.popup {
import flash.display.MovieClip;
import flash.text.TextField;

import gameplataform.constants.GameSignals;

import utils.managers.event.MultipleSignal;

import utilsDisplay.managers.buttons.ButtonManager;

public class SignUp extends MovieClip {

    public var txtUser:TextField;
    public var txtPassword:TextField;
    public var txtError:TextField;

    public var btnSignUp:MovieClip;
    public var btnBack:MovieClip;

    public var dispatcher:MultipleSignal;

    private var _buttons:Vector.<MovieClip>;

    public function SignUp() {
        super();

        dispatcher = new MultipleSignal(this);

        _buttons = new <MovieClip>[btnSignUp, btnBack];

        ButtonManager.add(btnSignUp, {onClick:onClickSignup});
        ButtonManager.add(btnBack, {onClick:onClickBack});

        txtError.text = "";
    }

    public function enable():void {
        for each (var button:MovieClip in _buttons) {
            ButtonManager.enable(button);
        }
    }

    public function disable():void {
        for each (var button:MovieClip in _buttons) {
            ButtonManager.disable(button);
        }
    }

    public function set errorMessage(t:String):void {
        txtError.text = t;
    }

    public function destroy():void {
        dispatcher.removeAll();
        for each (var button:MovieClip in _buttons) {
            ButtonManager.remove(button);
        }
    }


    //==================================
    //
    //==================================
    private function canProceed():Boolean {
        var user:String = txtUser.text, pw:String = txtPassword.text;
        return (user != "" && pw != "");
    }

    private function onClickSignup(btn:MovieClip):void {
        if(canProceed()) {
            dispatcher.dispatch(GameSignals.SIGNUP, txtUser.text, txtPassword.text);
        }
    }

    private function onClickBack(btn:MovieClip):void {
        dispatcher.dispatch(GameSignals.BACK);
    }
}
}
