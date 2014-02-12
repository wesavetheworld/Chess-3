/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceType;
import gameplataform.model.MovementModel;

public class Rook extends BasePiece {

    public function Rook(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceType.WHITE_ROOK : PieceType.BLACK_ROOK, data, alignment);
    }
}
}
