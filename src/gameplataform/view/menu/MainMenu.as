/**
 * Created by William on 2/11/14.
 */
package gameplataform.view.menu {
import flash.display.MovieClip;
import flash.text.TextField;

import gameplataform.constants.GameSignals;

import utils.managers.event.MultipleSignal;

import utilsDisplay.managers.buttons.ButtonManager;

public class MainMenu extends MovieClip {

    public var txtUser      :TextField;
    public var txtPassword  :TextField;
    public var txtError     :TextField;

    public var btnLogin:MovieClip;
    public var btnSignup:MovieClip;

    public var dispatcher:MultipleSignal;

    private var _buttons:Vector.<MovieClip>;

    public function MainMenu() {
        super();

        txtError.text = "";

        dispatcher = new MultipleSignal(this);

        _buttons = new <MovieClip>[btnLogin, btnSignup];
        ButtonManager.add(btnLogin, {onClick:onClickOnline}); ButtonManager.disable(btnLogin);
        ButtonManager.add(btnSignup, {onClick:onClickSignup}); ButtonManager.disable(btnSignup);

        enable();
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
    private function canProceedWithLogin():Boolean {
        var user:String = txtUser.text, pw:String = txtPassword.text;
        return (user != "" && pw != "");
    }

    private function onClickOnline(btn:MovieClip):void {
        if(canProceedWithLogin()) {
            dispatcher.dispatch(GameSignals.LOGIN, txtUser.text, txtPassword.text);
        } else {
            txtError.text = "Preencher os campos de usuário e senha";
        }
    }

    private function onClickSignup(btn:MovieClip):void {
        dispatcher.dispatch(GameSignals.SIGNUP);
    }



}
}
