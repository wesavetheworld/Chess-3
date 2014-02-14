/**
 * Created by William on 2/5/14.
 */
package gameplataform.controller.state {
import gameplataform.constants.GameState;
import gameplataform.constants.PieceType;
import gameplataform.controller.Game;
import gameplataform.controller.GameData;
import gameplataform.controller.GameMechanics;
import gameplataform.controller.data.ChessSocket;
import gameplataform.view.board.Board;

public class StateGame extends BaseState {

    public function StateGame(game:Game) {
        super(game, GameState.GAME, null, onEnter, onExit);
    }

    private function onEnter():void {
        setupBoard();
        startGame();
    }

    private function onExit():void {

    }

    private function setupBoard():void {
        game.mapController.board.dispatcher.add(Board.MOVE_MADE, onPieceMoved);
        game.mapController.board.resetBoard(GameData.variables.defaultConfiguration);
    }

    private function startGame():void {
        game.mapController.board.enable();
    }

    private function onRead(dataString:String):void {
        var data:Object = JSON.parse(dataString);
        switch(data.type) {

        }
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


}
}
