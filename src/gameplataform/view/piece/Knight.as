/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.PieceTypes;

public class Knight extends BasePiece {

    public function Knight(isWhite:Boolean) {
        super(isWhite? PieceTypes.WHITE_KNIGHT : PieceTypes.BLACK_KNIGHT);
    }
}
}
