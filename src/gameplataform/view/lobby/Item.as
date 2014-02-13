/**
 * Created by William on 2/13/14.
 */
package gameplataform.view.lobby {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.text.TextField;

public class Item extends Sprite {

    private var _status:uint;
    private var _id:uint;
    private var _name:String;

    private var txtBody:TextField;

    public function Item(id:uint, name:String, status:uint) {
        super();

        _id = id;
        _name = name;
        _status = status;

        txtBody = new TextField();
        txtBody.width = 230;
        txtBody.height = 30;
        txtBody.text = "id: " + _id + ", name: " + _name + ', status:' + _status;

        update();
    }

    public function update():void {
        render();
    }


    private function render():void {
        var g:Graphics = this.graphics;
        g.beginFill(0xfe8311);
        g.drawRect(0, 0, 230, 30);
    }
}
}
