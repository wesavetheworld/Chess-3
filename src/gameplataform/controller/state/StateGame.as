/**
 * Created by William on 2/5/14.
 */
package gameplataform.controller.state {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldType;

import gameplataform.constants.GameStates;
import gameplataform.controller.Game;
import gameplataform.controller.data.CustomSocket;
import gameplataform.view.board.Board;

import utils.toollib.ToolColor;

import utilsDisplay.managers.buttons.ButtonManager;

public class StateGame extends BaseState {

    private var board:Board;


    public function StateGame(game:Game) {
        super(game, GameStates.GAME, null, onEnter, onExit);
    }

    private function onEnter():void {

    }

    private function onExit():void {

    }


    private function onSelectPiece():void {

    }










    //==================================
    //  Socket
    //==================================
    private var txt:TextField;
    private var btn1:Sprite, btn2:Sprite;
    private var socket:CustomSocket;

    private function socketing():void {
        txt = new TextField();
        txt.type = TextFieldType.INPUT;
        txt.x = 100;
        txt.y = 300;
        txt.width = 400;
        txt.height = 200;
        txt.border = true;
        game.mapController.addChild(txt, "txt");

        btn1 = new Sprite(); btn1.x = 50; btn1.y = 50;
        btn2 = new Sprite(); btn2.x = 320; btn2.y = 50;
        createButton(btn1, "button1", {onClick:onClickBtn1});
        createButton(btn2, "button2", {onClick:onClickBtn2});

        socket = new CustomSocket("localhost", 9001);
    }

    private function createButton(btn:Sprite, btnName:String, btnParameters:Object):void {
        var color:uint = ToolColor.random();
        var g:Graphics = btn.graphics;

        g.lineStyle(3, color);
        g.beginFill(ToolColor.opposite(color));
        g.drawRect(0,0, 120, 70);
        g.endFill();

        ButtonManager.add(btn, btnParameters);

        game.mapController.addChild(btn, btnName);
    }

    private function onClickBtn1(button:Sprite):void {
        var msg:String = txt.text;

        socket.sendData(msg);
    }

    private function onClickBtn2(button:Sprite):void {

    }
}
}
