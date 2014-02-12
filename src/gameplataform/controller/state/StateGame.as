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
import gameplataform.constants.PieceType;
import gameplataform.controller.Game;
import gameplataform.controller.GameData;
import gameplataform.controller.GameMechanics;
import gameplataform.controller.data.ChessSocket;
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
        board = new Board();
        board.x = GameData.stageWidth - board.width >> 1;
        board.y = GameData.stageHeight - board.height >> 1;
        game.mapController.addChild(board, "board");

        setupBoard();
        startGame();
    }

    private function onExit():void {

    }

    private function setupBoard():void {
        board.dispatcher.add(Board.MOVE_MADE, onPieceMoved);
        board.resetBoard(GameData.variables.defaultConfiguration);
    }

    private function startGame():void {
        var socket:ChessSocket = GameMechanics.socket;
        socket.dispatcher.add(ChessSocket.READ, onRead);
        socket.send({
            type: "startGame"
        });

        board.enable();
    }

    private function onRead(str:String):void {
        trace(str);
    }

    //==================================
    //
    //==================================
    private function onPieceMoved(type:int, x0:uint, y0:uint, x1:uint, y1:uint, captured:uint):void {
        var s:String = getSymbol(type);
        if(captured != 0) {
            s += "x" + getCoordinate(x0,y0) + " " + getSymbol(captured) + "x" + getCoordinate(x1,y1);
        } else {
            s += getCoordinate(x0,y0) + " " + getCoordinate(x1,y1);
        }
        trace(s);
        GameMechanics.socket.send({
            type: "move",
            position0: {x: x0, y: y0},
            position1: {x: x1, y: y1}
        })
    }

    private function getSymbol(type:int):String {
        switch(type) {
            case PieceType.WHITE_PAWN  :
            case PieceType.BLACK_PAWN  : return "P";
            case PieceType.WHITE_BISHOP:
            case PieceType.BLACK_BISHOP: return "B";
            case PieceType.WHITE_QUEEN :
            case PieceType.BLACK_QUEEN : return "Q";
            case PieceType.WHITE_KNIGHT:
            case PieceType.BLACK_KNIGHT: return "N";
            case PieceType.WHITE_ROOK  :
            case PieceType.BLACK_ROOK  : return "R";
            case PieceType.WHITE_KING  :
            case PieceType.BLACK_KING  : return "K";
        }
        return "";
    }

    private function getCoordinate(x:uint, y:uint):String {
        const h:String = "abcdefgh";
        const v:String = '12345678';
        return h.charAt(x) + v.charAt(y);
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
