/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceTypes;
import gameplataform.model.MovementModel;

public class Pawn extends BasePiece {

    public function Pawn(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceTypes.WHITE_PAWN : PieceTypes.BLACK_PAWN, data, alignment);
    }
}
}
