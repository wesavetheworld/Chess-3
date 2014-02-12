/**
 * Created by William on 2/6/14.
 */
package gameplataform.view.piece {
import gameplataform.constants.Alignment;
import gameplataform.constants.PieceType;
import gameplataform.model.MovementModel;

public class King extends BasePiece {
    public function King(data:MovementModel, alignment:String) {
        super(alignment == Alignment.WHITE? PieceType.WHITE_KING : PieceType.BLACK_KING, data, alignment);
    }
}
}
