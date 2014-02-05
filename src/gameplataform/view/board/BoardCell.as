/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import flash.display.Graphics;
import flash.display.MovieClip;

import gameplataform.view.piece.BasePiece;

public class BoardCell extends MovieClip {

    public static const SIZE:Number = 50;

    private var _target:BasePiece;

    public function BoardCell() {

    }

    public function render(color:uint):void {
        var g:Graphics = this.graphics;
        g.beginFill(color);
        g.drawRect(0, 0, SIZE, SIZE);
        g.endFill();
    }


    public function get target():BasePiece {
        return _target;
    }

    public function set target(value:BasePiece):void {
        _target = value;
    }
}
}
