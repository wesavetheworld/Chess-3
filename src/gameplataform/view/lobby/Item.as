/**
 * Created by William on 2/13/14.
 */
package gameplataform.view.lobby {
import flash.display.Sprite;
import flash.text.TextField;

public class Item extends Sprite {

    public var txtID:TextField;
    public var txtName:TextField;

    private var _status:uint;
    private var _id:uint;
    private var _name:String;

    public function Item(id:uint, name:String, status:uint) {
        super();

        update(id, name, status);
    }

    public function update(id:uint, name:String, status:uint):void {
        _id = id;
        _name = name;
        _status = status;

        txtID.text = id.toString();
        txtName.text = name;
    }

    public function select():void {

    }

    public function deSelect():void {

    }


    public function get status():uint {
        return _status;
    }

    public function get id():uint {
        return _id;
    }

    public function get playerName():String {
        return _name;
    }
}
}
