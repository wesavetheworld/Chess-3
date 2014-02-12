/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceType;
import gameplataform.model.MovementModel;

public class Knight extends BasePiece {

    public function Knight(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceType.WHITE_KNIGHT : PieceType.BLACK_KNIGHT, data, alignment);
    }
}
}
