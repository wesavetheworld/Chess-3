/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import flash.display.MovieClip;

import gameplataform.constants.Frame;
import gameplataform.view.piece.BasePiece;

public class BoardCell extends MovieClip {

    public static const SIZE:Number = 60;

    private var _target:BasePiece;

    public function BoardCell(isWhite:Boolean) {
        super();
        super.gotoAndStop(isWhite? Frame.WHITE: Frame.BLACK);
    }

    public function get target():BasePiece {
        return _target;
    }

    public function set target(value:BasePiece):void {
        _target = value;
    }
}
}
