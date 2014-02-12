/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceType;
import gameplataform.model.MovementModel;

public class Queen extends BasePiece {

    public function Queen(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceType.WHITE_QUEEN : PieceType.BLACK_QUEEN, data, alignment);
    }
}
}
