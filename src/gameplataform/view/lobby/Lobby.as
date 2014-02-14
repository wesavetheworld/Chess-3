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
    public var btnConnect:MovieClip;

    public var dispatcher:MultipleSignal;

    public var scrollContainer:MovieClip;
    public var scrollTracker:MovieClip;
    public var scrollTrack:MovieClip;

    private var scrollContent:Sprite;
    private var scroll:Scroll;

    private var players:Vector.<Item>;

    private var _selectedItem:Item;

    public function Lobby() {
        super();

        dispatcher = new MultipleSignal(this);

        scrollContent = new Sprite();
        scroll = new Scroll(GameData.stage, scrollContainer, scrollContent, null);
        scroll.setVerticalComponents(scrollTrack, scrollTracker);

        ButtonManager.add(btnRefresh, {onClick:onClickRefresh});
        ButtonManager.add(btnConnect, {onClick:onClickConnect});

        ButtonManager.disable(btnConnect);
    }

    public function setData(user:String):void {
        txtUser.text = user;
    }

    public function refresh(data:Array):void {
        for each (var item:Item in players) {
            ButtonManager.remove(item);
            scrollContent.removeChild(item);
        }

        players = new Vector.<Item>();

        for (var i:int = 0; i < data.length; i++) {
            item = new Item(data[i].id, data[i].name, data[i].status);
            scrollContainer.addChild(item);
            item.x = 0;
            item.y = i * item.height;
            players.push(item);
            ButtonManager.add(item, {onClick:onClickItem});
        }

        scroll.update();

        setSelectedItem(null);
    }

    public function destroy():void {

    }

    private function setSelectedItem(item:Item):void {
        if(item == null) {
            if(_selectedItem != null)
                _selectedItem.deSelect();
            _selectedItem = null;
        } else if(_selectedItem == null) {
            _selectedItem = item;
            _selectedItem.select();
        } else if(_selectedItem == item) {
            _selectedItem.deSelect();
            _selectedItem = null;
        } else {
            _selectedItem.deSelect();
            _selectedItem = item;
            _selectedItem.select();
        }

        ButtonManager.setStatus(btnConnect, (_selectedItem != null));
    }

    private function onClickItem(item:Item):void {
         setSelectedItem(item);
    }

    private function onClickRefresh(btn:MovieClip):void {
        dispatcher.dispatch(GameSignals.REFRESH);
    }

    private function onClickConnect(btn:MovieClip):void {
        dispatcher.dispatch(GameSignals.CONNECT, _selectedItem.id);
    }
}
}
