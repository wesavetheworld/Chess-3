/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import flash.display.MovieClip;
import flash.geom.Point;

public class BasePiece extends MovieClip {

    private var _type:int;
    private var _position:Point = new Point(0,0);

    public function BasePiece(type:int) {
        _type = type;

    }

    public function setPosition(x:uint, y:uint):void {
        _position.setTo(x, y);

    }


    public function get positionX():uint {
        return _position.x;
    }

    public function get positionY():uint {
        return _position.y;
    }

    public function get type():int {
        return _type;
    }
}
}
