/**
 * Created by William on 2/13/14.
 */
package gameplataform.view.lobby {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

import gameplataform.constants.GameSignals;
import gameplataform.controller.GameData;

import utils.managers.event.MultipleSignal;

import utilsDisplay.managers.buttons.ButtonManager;
import utilsDisplay.view.scroll.Scroll;

public class Lobby extends MovieClip {

    public var txtUser:TextField;

    public var btnRefresh:MovieClip;

    public var dispatcher:MultipleSignal;

    public var scrollContainer:MovieClip;
    public var scrollTracker:MovieClip;
    public var scrollTrack:MovieClip;

    private var scrollContent:Sprite;
    private var scroll:Scroll;

    private var players:Vector.<Item>;

    public function Lobby() {
        super();

        dispatcher = new MultipleSignal(this);

        scrollContent = new Sprite();
        scroll = new Scroll(GameData.stage, scrollContainer, scrollContent, null);
        scroll.setVerticalComponents(scrollTrack, scrollTracker);

        ButtonManager.add(btnRefresh, {onClick:onClickRefresh});
    }

    public function setData(user:String):void {
        txtUser.text = user;
    }

    public function refresh(data:Array):void {
        while(scrollContent.numChildren > 0) {
            scrollContent.removeChildAt(0);
        }

        players = new Vector.<Item>();

        for (var i:int = 0; i < data.length; i++) {
            var item:Item = new Item(data.id, data.name, data.status);
            scrollContainer.addChild(item);
            item.x = 0;
            item.y = i * item.height;

            players.push(item);
        }

        scroll.update();
    }

    public function destroy():void {

    }



    private function onClickRefresh(btn:MovieClip):void {
        dispatcher.dispatch(GameSignals.REFRESH);
    }
}
}
