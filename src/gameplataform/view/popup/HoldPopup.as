/**
 * Created by William on 2/11/14.
 */
package gameplataform.view.popup {
import flash.display.MovieClip;
import flash.text.TextField;

public class HoldPopup extends MovieClip {


    public var txtMessage:TextField;

    public function HoldPopup() {
        super();
    }

    public function set text(t:String):void {
        txtMessage.text = t;
    }
}
}
