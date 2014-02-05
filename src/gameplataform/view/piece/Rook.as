/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.PieceTypes;

public class Rook extends BasePiece {

    public function Rook(isWhite:Boolean) {
        super(isWhite? PieceTypes.WHITE_ROOK : PieceTypes.BLACK_ROOK);
    }
}
}
