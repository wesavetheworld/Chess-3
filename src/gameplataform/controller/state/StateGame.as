/**
 * Created by William on 2/5/14.
 */
package gameplataform.controller.state {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldType;

import gameplataform.constants.GameStates;
import gameplataform.controller.Game;
import gameplataform.controller.GameData;
import gameplataform.controller.data.CustomSocket;
import gameplataform.view.board.Board;

import utils.managers.serializer.SerializerManager;

import utils.toollib.ToolColor;

import utilsDisplay.managers.buttons.ButtonManager;

public class StateGame extends BaseState {

    private var board:Board;

    public function StateGame(game:Game) {
        super(game, GameStates.GAME, null, onEnter, onExit);
    }

    private function onEnter():void {
        trace(SerializerManager.encodeAndStringfy(new Point(0,0)));
        board = new Board();
        board.resetBoard(GameData.variables.defaultConfiguration);
        board.x = GameData.stageWidth - board.width >> 1;
        board.y = GameData.stageHeight - board.height >> 1;
        game.mapController.addChild(board, "board");
    }

    private function onExit():void {

    }







    //==================================
    //      Socket Testing
    //==================================
    private var _buttons:Vector.<Sprite>;
    private var txt:TextField;

    private var socket:CustomSocket;

    private function setup():void {
        txt = new TextField();
        txt.type = TextFieldType.INPUT;
        txt.x = 100;
        txt.y = 300;
        txt.width = 400;
        txt.height = 200;
        txt.border = true;
        game.mapController.addChild(txt, "txt");

        _buttons = new Vector.<Sprite>();
        var btn:Sprite;
        btn = createButton("btn1",{onClick:onClick1}); btn.x = 50; btn.y = 50; _buttons.push(btn);
        btn = createButton("btn2",{onClick:onClick1}); btn.x = 220; btn.y = 50; _buttons.push(btn);

        socket = new CustomSocket("localhost", 9001);
    }

    private function createButton(btnName:String, btnParameters:Object):Sprite {
        var btn:Sprite = new Sprite();
        var color:uint = ToolColor.random();
        var g:Graphics = btn.graphics;

        g.lineStyle(3, color);
        g.beginFill(ToolColor.opposite(color));
        g.drawRect(0,0, 120, 70);
        g.endFill();

        ButtonManager.add(btn, btnParameters);

        game.mapController.addChild(btn, btnName);
        return btn;
    }

    private function onClick1(bt:Sprite):void {
        var i:int = _buttons.indexOf(bt);
        if(i == -1) return;
        switch(i) {
            case 0: {
                var msg:String = txt.text;
                socket.send({
                    type: msg
                });
                break;
            }
            case 1: {
                break;
            }
        }
    }


}
}
