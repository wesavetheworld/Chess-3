/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import flash.display.MovieClip;

import gameplataform.constants.PieceTypes;

import gameplataform.model.BoardConfiguration;
import gameplataform.view.piece.BasePiece;
import gameplataform.view.piece.Pawn;

import utils.managers.event.MultipleSignal;

public class Board extends MovieClip {

    public static const SIZE:uint = 8;

    private var _cells:Vector.<Vector.<BoardCell>>;

    public var dispatcher:MultipleSignal;

    public function Board() {
        createNewBoard(this);
        dispatcher = new MultipleSignal(this);
    }

    public function rearrangePieces(configuration:BoardConfiguration):void {
        var piece:BasePiece;
        for (var i:int = 0; i < SIZE; i++) {
            for (var j:int = 0; j < SIZE; j++) {
                if(configuration.pieces[i][j] != 0) {

                }
            }
        }
    }

    public function movePieceTo(col:uint, row:uint):void {

    }

    public function canMovePieceTo(col:uint, row:uint):Boolean {
        return true;
    }

    //==================================
    //
    //==================================
    private function getPieceByType(type:int):BasePiece {
        var isWhite:Boolean = false;
        switch(type) {
            case PieceTypes.WHITE_PAWN    : isWhite = true;
            case PieceTypes.BLACK_PAWN    : return new Pawn(isWhite);
            case PieceTypes.WHITE_KNIGHT  : isWhite = true;
            case PieceTypes.BLACK_KNIGHT  : return new Pawn(isWhite);
            case PieceTypes.WHITE_BISHOP  : isWhite = true;
            case PieceTypes.BLACK_BISHOP  : return new Pawn(isWhite);
            case PieceTypes.WHITE_ROOK    : isWhite = true;
            case PieceTypes.BLACK_ROOK    : return new Pawn(isWhite);
            case PieceTypes.WHITE_QUEEN   : isWhite = true;
            case PieceTypes.BLACK_QUEEN   : return new Pawn(isWhite);
            case PieceTypes.WHITE_KING    : isWhite = true;
            case PieceTypes.BLACK_KING    : return new Pawn(isWhite);
            default: throw new ArgumentError("Invalid type received : \"" + type + "\".");
        }
    }

    //==================================
    //
    //==================================
    private static function createNewBoard(instance:Board):void {
        instance._cells = new Vector.<Vector.<BoardCell>>();
        instance._cells.length = SIZE;
        instance._cells.fixed = true;
        for (var i:int = 0; i < SIZE; i++) {
            instance._cells[i] = new Vector.<BoardCell>();
            instance._cells[i].length = SIZE;
            instance._cells[i].fixed = true;
            for (var j:int = 0; j < SIZE; j++) {
                instance._cells[i][j] = new BoardCell();
                instance._cells[i][j].render(((i % 2) == (j % 2))? 0xffffff : 0x000000);
                instance._cells[i][j].x = i * BoardCell.SIZE;
                instance._cells[i][j].y = j * BoardCell.SIZE;
                instance.addChild(instance._cells[i][j]);
            }
        }
    }
}
}
