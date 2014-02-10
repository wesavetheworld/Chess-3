/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import com.greensock.TweenMax;
import com.greensock.easing.Linear;

import flash.display.MovieClip;

import gameplataform.constants.PieceTypes;

import gameplataform.model.BoardConfiguration;
import gameplataform.view.piece.BasePiece;
import gameplataform.view.piece.Bishop;
import gameplataform.view.piece.King;
import gameplataform.view.piece.Knight;
import gameplataform.view.piece.Pawn;
import gameplataform.view.piece.Queen;
import gameplataform.view.piece.Rook;

import utils.managers.event.MultipleSignal;

public class Board extends MovieClip {

    public static const SIZE:uint = 8;

    private var _cells:Vector.<Vector.<BoardCell>>;
    private var _pieces:Vector.<BasePiece>;

    public var dispatcher:MultipleSignal;

    public function Board() {
        createNewBoard(this);
        dispatcher = new MultipleSignal(this);
    }

    public function resetBoard(configuration:BoardConfiguration):void {
        var piece:BasePiece;

        for each (piece in _pieces) {
            super.removeChild(piece);
        }

        _pieces = new Vector.<BasePiece>();

        for (var i:int = 0; i < SIZE && i < configuration.pieces.length; i++) {
            for (var j:int = 0; j < SIZE && j < configuration.pieces[i].length; j++) {
                if(configuration.pieces[i][j] != 0) {
                    piece = getPieceByType(configuration.pieces[i][j]);
                    setPieceAt(piece, i, j);
                    _pieces.push(piece);
                    super.addChild(piece);
                }
            }
        }
    }

    public function movePieceTo(col:uint, row:uint):void {

    }

    public function canMovePieceTo(col:uint, row:uint):Boolean {
        return true;
    }

    public function calculatePossiblePositions(piece:BasePiece):Vector.<BoardCell> {
        var positions:Vector.<BoardCell> = new Vector.<BoardCell>();
        switch(piece.type) {
            case PieceTypes.WHITE_PAWN: {

            }
        }

        return positions;
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
            case PieceTypes.BLACK_KNIGHT  : return new Knight(isWhite);
            case PieceTypes.WHITE_BISHOP  : isWhite = true;
            case PieceTypes.BLACK_BISHOP  : return new Bishop(isWhite);
            case PieceTypes.WHITE_ROOK    : isWhite = true;
            case PieceTypes.BLACK_ROOK    : return new Rook(isWhite);
            case PieceTypes.WHITE_QUEEN   : isWhite = true;
            case PieceTypes.BLACK_QUEEN   : return new Queen(isWhite);
            case PieceTypes.WHITE_KING    : isWhite = true;
            case PieceTypes.BLACK_KING    : return new King(isWhite);
            default: throw new ArgumentError("Invalid type received : \"" + type + "\".");
        }
    }

    private function setPieceAt(piece:BasePiece, x:uint, y:uint):void {
        var cell:BoardCell = _cells[x][y];
        cell.target = piece;
        piece.setPosition(x, y);
        TweenMax.to(piece, 0.5, {x:cell.x, y:cell.y, ease:Linear.easeNone});
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
                instance._cells[i][j] = new BoardCell((i % 2) == (j % 2));
                instance._cells[i][j].x = i * BoardCell.SIZE;
                instance._cells[i][j].y = j * BoardCell.SIZE;
                instance.addChild(instance._cells[i][j]);
            }
        }
    }
}
}
