/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceTypes;
import gameplataform.model.MovementModel;

public class Bishop extends BasePiece {

    public function Bishop(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceTypes.WHITE_BISHOP : PieceTypes.BLACK_BISHOP, data, alignment);
    }
}
}
