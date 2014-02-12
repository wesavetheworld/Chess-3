/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.errors.IllegalOperationError;
import flash.geom.Point;

import gameplataform.constants.Alignment;
import gameplataform.constants.MovementType;
import gameplataform.constants.PieceType;
import gameplataform.controller.GameData;
import gameplataform.model.BoardConfiguration;
import gameplataform.model.Variables;
import gameplataform.view.piece.BasePiece;
import gameplataform.view.piece.Bishop;
import gameplataform.view.piece.King;
import gameplataform.view.piece.Knight;
import gameplataform.view.piece.Pawn;
import gameplataform.view.piece.Queen;
import gameplataform.view.piece.Rook;

import utils.managers.event.MultipleSignal;
import utils.toollib.ToolMath;

import utilsDisplay.managers.buttons.ButtonManager;

public class Board extends MovieClip {

    public static const MOVE_MADE:String = "move.made";

    public static const SIZE:uint = 8;

    private var _cells:Vector.<Vector.<BoardCell>>;
    private var _pieces:Vector.<BasePiece>;

    private var cellLayer:Sprite;
    private var pieceLayer:Sprite;

    private var _selectedCell:BoardCell;
    private var _possibleMoves:Vector.<BoardCell>;

    public var dispatcher:MultipleSignal;

    public function Board() {
        cellLayer = new Sprite();
        pieceLayer = new Sprite();
        super.addChild(cellLayer);
        super.addChild(pieceLayer);
        createNewBoard(SIZE);
        dispatcher = new MultipleSignal(this);
    }

    //==================================
    //  Public
    //==================================
    public function resetBoard(configuration:BoardConfiguration):void {
        while(pieceLayer.numChildren > 0)
            pieceLayer.removeChildAt(0);

        _pieces = new Vector.<BasePiece>();

        for (var i:int = 0; i < SIZE; i++) {
            for (var j:int = 0; j < SIZE; j++) {
                if(i < configuration.pieces.length && j < configuration.pieces[i].length && configuration.pieces[i][j] != 0) {
                    var piece:BasePiece = getPieceByType(configuration.pieces[i][j]);
                    var cell:BoardCell = _cells[i][j];
                    cell.target = piece;
                    piece.setPosition(i,j);
                    piece.x = cell.x;
                    piece.y = cell.y;
                    _pieces.push(piece);
                    pieceLayer.addChild(piece);
                    ButtonManager.add(piece, { useDefault:false, onClick:onClickPiece});
                    ButtonManager.disable(piece);
                }
            }
        }
    }

    public function movePieceTo(piece:BasePiece, x:uint, y:uint):void {
        if(piece.positionX == x && piece.positionY == y)
            throw new IllegalOperationError("Cannot move piece to same place: (" + x + "," + y + ").");

        var cell:BoardCell;
        var captured:int = 0;
        var lastPositionX:uint = piece.positionX, lastPositionY:uint = piece.positionY;

        //removing from current cell
        cell = _cells[piece.positionX][piece.positionY];
        cell.target = null;

        //moving to new cell
        cell = _cells[x][y];
        if(cell.target != null) { //checking if it is capturing something
            if(cell.target.alignment == piece.alignment)
                throw new IllegalOperationError("Cannot capture piece of same alignment: \"" + piece.alignment + "\".");
            captured = cell.target.type;
            removePieceFrom(cell);
        }
        cell.target = piece;
        piece.setPosition(x, y);
        piece.x = cell.x;
        piece.y = cell.y;

        dispatcher.dispatch(MOVE_MADE, piece.type, lastPositionX, lastPositionY, x, y, captured);
    }

    public function enable():void {
        for each (var piece:BasePiece in _pieces) {
            ButtonManager.enable(piece);
        }
        for each (var vCell:Vector.<BoardCell> in _cells) {
            for each (var cell:BoardCell in vCell) {
                ButtonManager.enable(cell);
            }
        }
    }

    public function disable():void {
        for each (var piece:BasePiece in _pieces) {
            ButtonManager.disable(piece);
        }
        for each (var vCell:Vector.<BoardCell> in _cells) {
            for each (var cell:BoardCell in vCell) {
                ButtonManager.disable(cell);
            }
        }
    }

    //==================================
    //  Private
    //==================================
    private function createNewBoard(size:uint):void {
        _cells = new Vector.<Vector.<BoardCell>>();
        _cells.length = size;
        _cells.fixed = true;
        for (var i:int = 0; i < size; i++) {
            _cells[i] = new Vector.<BoardCell>();
            _cells[i].length = size;
            _cells[i].fixed = true;
            for (var j:int = 0; j < size; j++) {
                _cells[i][j] = new BoardCell(!((i % 2) == (j % 2)), i, j);
                _cells[i][j].x = i * BoardCell.SIZE;
                _cells[i][j].y = j * BoardCell.SIZE;
                _cells[i][j].text = "(" + i + "," + j + ")";
                cellLayer.addChild(_cells[i][j]);
                ButtonManager.add(_cells[i][j], { useDefault:false, onClick:onClickCell});
                ButtonManager.disable(_cells[i][j]);
            }
        }
    }

    private function getPieceByType(type:int):BasePiece {
        var variables:Variables = GameData.variables;
        switch(type) {
            case PieceType.WHITE_PAWN    : return new Pawn(variables.defaultPawn_white, Alignment.WHITE); break;
            case PieceType.BLACK_PAWN    : return new Pawn(variables.defaultPawn_black, Alignment.BLACK); break;
            case PieceType.WHITE_KNIGHT  : return new Knight(variables.defaultKnight, Alignment.WHITE); break;
            case PieceType.BLACK_KNIGHT  : return new Knight(variables.defaultKnight, Alignment.BLACK); break;
            case PieceType.WHITE_BISHOP  : return new Bishop(variables.defaultBishop, Alignment.WHITE); break;
            case PieceType.BLACK_BISHOP  : return new Bishop(variables.defaultBishop, Alignment.BLACK); break;
            case PieceType.WHITE_ROOK    : return new Rook(variables.defaultRook, Alignment.WHITE); break;
            case PieceType.BLACK_ROOK    : return new Rook(variables.defaultRook, Alignment.BLACK); break;
            case PieceType.WHITE_QUEEN   : return new Queen(variables.defaultQueen, Alignment.WHITE); break;
            case PieceType.BLACK_QUEEN   : return new Queen(variables.defaultQueen, Alignment.BLACK); break;
            case PieceType.WHITE_KING    : return new King(variables.defaultKing, Alignment.WHITE); break;
            case PieceType.BLACK_KING    : return new King(variables.defaultKing, Alignment.BLACK); break;
            default: throw new ArgumentError("Invalid type received : \"" + type + "\".");
        }
    }

    private function selectPiece(piece:BasePiece):void {
        var cell:BoardCell = _cells[piece.positionX][piece.positionY];

        deHighlightMovementCells();
        if(_selectedCell == null) { //selecting
            _selectedCell = cell;
            _selectedCell.select();
            _possibleMoves = calculatePossibleMoves(piece);
            highlightMovementCells();
        } else if(_selectedCell == cell) { //de-selecting
            _selectedCell.deselect();
            _selectedCell = null;
        } else {
            _selectedCell.deselect();
            if(isCellInPossibleMoves(cell)) { //attacking or moving
                movePieceTo(_selectedCell.target, cell.positionX, cell.positionY);
                _selectedCell = null;
            } else { //selecting another piece
                _selectedCell = cell;
                _selectedCell.select();
                _possibleMoves = calculatePossibleMoves(piece);
                highlightMovementCells();
            }
        }
    }

    private function selectCell(cell:BoardCell):void {
        if(_selectedCell == null || !isCellInPossibleMoves(cell))
            return;

        deHighlightMovementCells();
        movePieceTo(_selectedCell.target, cell.positionX, cell.positionY);
        _selectedCell.deselect();
        _selectedCell = null;
        _possibleMoves = null;
    }

    private function removePieceFrom(cell:BoardCell):void {
        var piece:BasePiece = cell.target;
        cell.target = null;
        ButtonManager.remove(piece);
        _pieces.splice(_pieces.indexOf(piece), 1);
        pieceLayer.removeChild(piece);
    }

    private function calculatePossibleMoves(piece:BasePiece):Vector.<BoardCell> {
        var mov:Vector.<BoardCell> = new Vector.<BoardCell>();
        var p:Point;
        var cell:BoardCell;
        var rx:uint, ry:uint;

        var range:uint;
        switch(piece.model.type) {
            case MovementType.POSITIONAL: range = 1;     break;
            case MovementType.DIRECTIONAL: range = SIZE - 1; break;
            default: throw new ArgumentError("Invalid model type found for piece: \"" + piece.model.type + "\".");
        }

        for each (p in piece.model.movements) {
            for (var i:int = 1; i <= range; i++) {
                rx = piece.positionX + p.x * i;
                ry = piece.positionY + p.y * i;
                if(!(ToolMath.isInRange(rx, 0, SIZE - 1) && ToolMath.isInRange(ry, 0, SIZE - 1)))
                    continue;

                cell = _cells[rx][ry];
                if(cell.target == null) {
                    mov.push(cell);
                } else {
                    if(!(piece.model.hasAttackPattern) && !(piece.alignment == cell.target.alignment)) { //is enemy
                        mov.push(cell);
                    }
                    break;
                }
            }
        }

        if(piece.model.hasAttackPattern) {
            for each (p in piece.model.attack) {
                for(i = 1; i <= range; i++) {
                    rx = piece.positionX + p.x * i;
                    ry = piece.positionY + p.y * i;
                    if(!(ToolMath.isInRange(rx, 0, SIZE - 1) && ToolMath.isInRange(ry, 0, SIZE - 1)))
                        continue;

                    cell = _cells[rx][ry];
                    if(cell.target != null ) {
                        if(!(piece.alignment == cell.target.alignment)) { //is enemy
                            mov.push(cell);
                        }
                    }
                }
            }
        }

        return mov;
    }

    private function highlightMovementCells():void {
        for each (var cell:BoardCell in _possibleMoves) {
            cell.highlight();
        }
    }

    private function deHighlightMovementCells():void {
        for each (var cell:BoardCell in _possibleMoves) {
            cell.dehighlight();
        }
    }

    private function isCellInPossibleMoves(cell:BoardCell):Boolean {
        if(_possibleMoves == null) return false;
        return (_possibleMoves.indexOf(cell) != -1);
    }

    //==================================
    //  Events
    //==================================
    private function onClickCell(cell:BoardCell):void {
        selectCell(cell);
    }

    private function onClickPiece(piece:BasePiece):void {
        selectPiece(piece);
    }


}
}
