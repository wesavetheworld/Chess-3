/**
 * Created with IntelliJ IDEA.
 * User: William
 * Date: 10/7/13
 * Time: 10:01 AM
 * To change this template use File | Settings | File Templates.
 */
package gameplataform.controller {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.utils.getTimer;

import gameplataform.constants.GameState;
import gameplataform.controller.layer.HudController;
import gameplataform.controller.layer.MapController;
import gameplataform.controller.layer.PopupController;
import gameplataform.controller.state.StateGame;
import gameplataform.controller.state.StateLobby;
import gameplataform.controller.state.StateMainMenu;
import gameplataform.controller.state.StateTest;
import gameplataform.view.Console;

import utils.events.StateMachineEvent;
import utils.managers.sounds.SoundManager;
import utils.managers.state.StateMachine;

/**
 * This class:
 *  - controls the main game pipeline (NOT the individual state mechanics)
 */
public final class Game {

    /**
     * Layer controllers
     */
    public var mapController    :MapController;
    public var hudController    :HudController;
    public var popupController  :PopupController;

    /**
     * Controls the game flow
     */
    private var stateMachine:StateMachine;

    private var console:Console;

    public function Game(mapLayer:Sprite, hudLayer:Sprite, popupLayer:Sprite) {
        mapController   = new MapController     (mapLayer);
        hudController   = new HudController     (hudLayer);
        popupController = new PopupController   (popupLayer);
        stateMachine    = new StateMachine();
        console = new Console();
    }

    public function initialize():void {
        SoundManager.volume = GameData.variables.volumeMain;

        initializeStates();

        _lastTimeStamp = getTimer() / 1000.0;

        GameData.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        GameData.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }

    private function initializeStates():void {
        stateMachine.addEventListener(StateMachineEvent.TRANSITION_COMPLETE, onTransitionComplete);
        stateMachine.addEventListener(StateMachineEvent.TRANSITION_DENIED, onTransitionDenied);

        stateMachine.add(new StateTest(this));
        stateMachine.add(new StateMainMenu(this));
        stateMachine.add(new StateGame(this));
        stateMachine.add(new StateLobby(this));

        stateMachine.changeTo(GameState.MAIN_MENU);
    }

    //==================================
    //  State Management
    //==================================
    private static function onTransitionDenied    (e:StateMachineEvent):void { trace(e); }
    private static function onTransitionComplete  (e:StateMachineEvent):void { trace(e); }

    //==================================
    //  Mechanics Management
    //==================================
    private static var _lastTimeStamp:Number = 0;
    private static function onEnterFrame(e:Event):void {
        var t:Number = getTimer() / 1000.0;
        var dt:Number = t - _lastTimeStamp;
        _lastTimeStamp = t;
        GameMechanics.checkJobList();
        GameMechanics.checkClock(dt);
    }

    //==================================
    //  Console
    //==================================
    private function onKeyDown(e:KeyboardEvent):void {
        if(e.keyCode == 192) {
            GameData.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        }
    }

    private function onKeyUp(e:KeyboardEvent):void {
        GameData.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        if(e.keyCode == 192) {
            if(console.isHidden) {
                GameData.stage.addChild(console);
                console.show();
            } else {
                console.hide(GameData.stage.removeChild, console);
            }
        }
    }
}
}
