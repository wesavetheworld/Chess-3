/**
 * Created by William on 2/11/14.
 */
package gameplataform.view.menu {
import flash.display.MovieClip;

import utils.managers.event.MultipleSignal;

import utilsDisplay.managers.buttons.ButtonManager;

public class MainMenu extends MovieClip {

    public static const GO_ONLINE:String = "go.online";

    public var btnOnline:MovieClip;

    public var dispatcher:MultipleSignal;

    private var _buttons:Vector.<MovieClip>;

    public function MainMenu() {
        super();

        _buttons = new <MovieClip>[btnOnline];

        dispatcher = new MultipleSignal(this);

        ButtonManager.add(btnOnline, {onClick:onClickOnline}); ButtonManager.disable(btnOnline);

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


    private function onClickOnline(btn:MovieClip):void {
        dispatcher.dispatch(GO_ONLINE);
    }



}
}
