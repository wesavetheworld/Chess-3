/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import flash.display.MovieClip;
import flash.geom.Point;

import gameplataform.constants.Alignment;
import gameplataform.constants.MovementType;
import gameplataform.constants.PieceTypes;
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

    public static const SIZE:uint = 8;

    private var _cells:Vector.<Vector.<BoardCell>>;
    private var _pieces:Vector.<BasePiece>;

    public var dispatcher:MultipleSignal;

    private var _selectedCell:BoardCell;
    private var _possibleMoves:Vector.<BoardCell>;

    public function Board() {
        createNewBoard(this, SIZE);
        dispatcher = new MultipleSignal(this);
    }

    //==================================
    //  Public
    //==================================
    public function resetBoard(configuration:BoardConfiguration):void {
        var piece:BasePiece;

        for each (piece in _pieces) {
            super.removeChild(piece);
        }

        _pieces = new Vector.<BasePiece>();

        for (var i:int = 0; i < SIZE; i++) {
            for (var j:int = 0; j < SIZE; j++) {
                ButtonManager.add(_cells[i][j], { useDefault:false, onClick:onClickCell});
                if(configuration.pieces[i][j] != 0) {
                    piece = getPieceByType(configuration.pieces[i][j]);
                    movePieceTo(piece, i, j);
                    _pieces.push(piece);
                    super.addChild(piece);
                    ButtonManager.add(piece, { useDefault:false, onClick:onClickPiece});
                }
            }
        }
    }

    //==================================
    //  Private
    //==================================
    private function getPieceByType(type:int):BasePiece {
        var variables:Variables = GameData.variables;
        switch(type) {
            case PieceTypes.WHITE_PAWN    : return new Pawn(variables.defaultPawn_white, Alignment.WHITE); break;
            case PieceTypes.BLACK_PAWN    : return new Pawn(variables.defaultPawn_black, Alignment.BLACK); break;
            case PieceTypes.WHITE_KNIGHT  : return new Knight(variables.defaultKnight, Alignment.WHITE); break;
            case PieceTypes.BLACK_KNIGHT  : return new Knight(variables.defaultKnight, Alignment.BLACK); break;
            case PieceTypes.WHITE_BISHOP  : return new Bishop(variables.defaultBishop, Alignment.WHITE); break;
            case PieceTypes.BLACK_BISHOP  : return new Bishop(variables.defaultBishop, Alignment.BLACK); break;
            case PieceTypes.WHITE_ROOK    : return new Rook(variables.defaultRook, Alignment.WHITE); break;
            case PieceTypes.BLACK_ROOK    : return new Rook(variables.defaultRook, Alignment.BLACK); break;
            case PieceTypes.WHITE_QUEEN   : return new Queen(variables.defaultQueen, Alignment.WHITE); break;
            case PieceTypes.BLACK_QUEEN   : return new Queen(variables.defaultQueen, Alignment.BLACK); break;
            case PieceTypes.WHITE_KING    : return new King(variables.defaultKing, Alignment.WHITE); break;
            case PieceTypes.BLACK_KING    : return new King(variables.defaultKing, Alignment.BLACK); break;
            default: throw new ArgumentError("Invalid type received : \"" + type + "\".");
        }
    }

    private function movePieceTo(piece:BasePiece, x:uint, y:uint):void {
        if(piece.positionX == x && piece.positionY == y)
            return;

        //removing from last cell
        if(piece.positionX != -1 && piece.positionY != -1) {
            var lastCell:BoardCell = _cells[piece.positionX][piece.positionY];
            lastCell.target = null;
        }

        //moving to new cell
        var cell:BoardCell = _cells[x][y];
        if(cell.target != null) { //checking if new cell has already a target
            var t:BasePiece = cell.target;
            cell.target = null;
            super.removeChild(t);
        }
        cell.target = piece;
        piece.setPosition(x, y);
        piece.x = cell.x;
        piece.y = cell.y;
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

    private function calculatePossibleMoves(piece:BasePiece):Vector.<BoardCell> {
        var mov:Vector.<BoardCell> = new Vector.<BoardCell>();
        var p:Point, rx:uint, ry:uint;
        var cell:BoardCell;

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

    //==================================
    //  Static
    //==================================
    private static function createNewBoard(instance:Board, size:uint):void {
        instance._cells = new Vector.<Vector.<BoardCell>>();
        instance._cells.length = size;
        instance._cells.fixed = true;
        for (var i:int = 0; i < size; i++) {
            instance._cells[i] = new Vector.<BoardCell>();
            instance._cells[i].length = size;
            instance._cells[i].fixed = true;
            for (var j:int = 0; j < size; j++) {
                instance._cells[i][j] = new BoardCell(!((i % 2) == (j % 2)), i, j);
                instance._cells[i][j].x = i * BoardCell.SIZE;
                instance._cells[i][j].y = j * BoardCell.SIZE;
                instance._cells[i][j].text = "(" + i + "," + j + ")";
                instance.addChild(instance._cells[i][j]);
            }
        }
    }
}
}
