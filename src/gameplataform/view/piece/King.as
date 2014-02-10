/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceTypes;
import gameplataform.model.MovementModel;

public class King extends BasePiece {
    public function King(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceTypes.WHITE_KING : PieceTypes.BLACK_KING, data, alignment);
    }
}
}
