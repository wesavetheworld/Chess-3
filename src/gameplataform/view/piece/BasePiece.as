/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.piece {
import flash.display.MovieClip;
import flash.geom.Point;

import gameplataform.constants.Frame;
import gameplataform.constants.MovementType;
import gameplataform.model.MovementModel;

public class BasePiece extends MovieClip {

    private var _type:int;
    private var _position:Point = new Point(-1,-1);

    private var _model:MovementModel;
    private var _alignment:String;

    public function BasePiece(type:int, model:MovementModel, alignment:String) {
        super();
        super.gotoAndStop(type > 0? Frame.WHITE : Frame.BLACK);

        _type = type;
        _model = model;
        _alignment = alignment;
    }

    public function setPosition(x:uint, y:uint):void {
        _position.setTo(x, y);
    }

    public function get positionX():int {
        return _position.x;
    }

    public function get positionY():int {
        return _position.y;
    }

    public function get type():int {
        return _type;
    }

    public function get model():MovementModel {
        return _model;
    }

    public function get alignment():String {
        return _alignment;
    }

}
}
