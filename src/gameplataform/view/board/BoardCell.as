/**
 * Created by William on 2/5/14.
 */
package gameplataform.view.board {
import flash.display.MovieClip;
import flash.geom.Point;
import flash.text.TextField;

import gameplataform.constants.Frame;
import gameplataform.view.piece.BasePiece;

public class BoardCell extends MovieClip {

    public static const SIZE:Number = 60;

    public var txtDebug:TextField;

    private var _target:BasePiece;

    private var _isWhite:Boolean;

    private var _position:Point = new Point(0,0);

    public function BoardCell(isWhite:Boolean, x:uint, y:uint) {
        _isWhite = isWhite;
        _position.setTo(x, y);
        super();
        super.gotoAndStop(_isWhite? Frame.WHITE: Frame.BLACK);
    }


    public function select():void {
        this.gotoAndStop(Frame.SELECTED);
    }

    public function deselect():void {
        super.gotoAndStop(_isWhite? Frame.WHITE: Frame.BLACK);
    }

    public function highlight():void {
        super.gotoAndStop(Frame.HIGHLIGHT);
    }

    public function dehighlight():void {
        super.gotoAndStop(_isWhite? Frame.WHITE : Frame.BLACK);
    }

    public function set text(v:String):void {
        txtDebug.text = v;
    }

    public function get text():String {
        return txtDebug.text;
    }

    public function get target():BasePiece {
        return _target;
    }

    public function set target(value:BasePiece):void {
        _target = value;
    }

    public function get positionX():uint { return _position.x; }
    public function get positionY():uint { return _position.y; }
}
}
