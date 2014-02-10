/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceTypes;
import gameplataform.model.MovementModel;

public class Knight extends BasePiece {

    public function Knight(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceTypes.WHITE_KNIGHT : PieceTypes.BLACK_KNIGHT, data, alignment);
    }
}
}
