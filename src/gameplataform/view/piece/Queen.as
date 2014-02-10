/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceTypes;
import gameplataform.model.MovementModel;

public class Queen extends BasePiece {

    public function Queen(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceTypes.WHITE_QUEEN : PieceTypes.BLACK_QUEEN, data, alignment);
    }
}
}
