/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.PieceTypes;

public class Pawn extends BasePiece {

    public function Pawn(isWhite:Boolean) {
        super(isWhite? PieceTypes.WHITE_PAWN : PieceTypes.BLACK_PAWN);
    }

    override public function canMoveTo(x:uint, y:uint):Boolean {

        return true;
    }
}
}
