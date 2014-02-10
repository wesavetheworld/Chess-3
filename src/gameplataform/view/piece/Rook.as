/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceTypes;
import gameplataform.model.MovementModel;

public class Rook extends BasePiece {

    public function Rook(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceTypes.WHITE_ROOK : PieceTypes.BLACK_ROOK, data, alignment);
    }
}
}
