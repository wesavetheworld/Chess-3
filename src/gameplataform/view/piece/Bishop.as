/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.PieceTypes;

public class Bishop extends BasePiece {



    public function Bishop(isWhite:Boolean) {
        super(isWhite? PieceTypes.WHITE_BISHOP : PieceTypes.BLACK_BISHOP);
    }

    public function movement():void {

    }
}
}
