/**
 * Created by William on 2/6/14.
 */
package gameplataform.view {
import com.greensock.TweenMax;

import flash.display.Graphics;

import flash.display.Sprite;
import flash.errors.IllegalOperationError;
import flash.text.TextField;
import flash.text.TextFieldType;

import gameplataform.controller.GameData;

public class Console extends Sprite {

    private static var _instance:Console;
    private static var _reports:Vector.<String> = new Vector.<String>();

    private var txtReports:TextField;
    private var _isHidden:Boolean = true;
    private var _animation:TweenMax;
    private var _w:Number, _h:Number;

    public function Console() {
        if(_instance != null)
            throw new IllegalOperationError("Console is a singleton class. Cannot be instantiated more than once.");
        _instance = this;

        _w = GameData.stageWidth;
        _h = GameData.stageHeight / 2;

        var g:Graphics = this.graphics;
        g.beginFill(0xf0f3ee);
        g.drawRect(0,0,_w, _h);
        g.endFill();

        txtReports = new TextField();
        txtReports.type = TextFieldType.DYNAMIC;
        txtReports.border = true;
        txtReports.selectable = true;
        txtReports.width = _w;
        txtReports.height = _h;
        txtReports.backgroundColor = 0xf3f3f3;
        txtReports.x = 0;
        txtReports.y = 0;
        addChild(txtReports);

        this.y = -_h;
    }

    //==================================
    //
    //==================================
    public function show(alpha:Number = 0.75, onComplete:Function = null, ...params):void {
        _isHidden = false;
        killAnimation();
        _animation = TweenMax.to(this, 0.5, {autoAlpha: alpha, y:0, onComplete:onComplete, onCompleteParams: params});
    }

    public function hide(onComplete:Function = null, ...params):void {
        _isHidden = true;
        killAnimation();
        _animation = TweenMax.to(this, 0.5, {autoAlpha: 0, y: -_h, onComplete:onComplete, onCompleteParams: params});
    }

    public function get isHidden():Boolean {
        return _isHidden;
    }

    private function killAnimation():void {
        if(_animation != null && _animation.totalProgress < 1.0) {
            _animation.kill();
        }
    }

    //==================================
    //
    //==================================
    public static function add(s:String):void {
        if(_instance != null) {
            _reports.push(s);
            _instance.txtReports.appendText("\n" + s);
        }
    }

}
}
