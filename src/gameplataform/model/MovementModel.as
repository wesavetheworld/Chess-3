/**
 * Created by William on 09/02/14.
 */
package gameplataform.model {
import flash.geom.Point;

public class MovementModel {

    public var type:String;
    public var hasAttackPattern:Boolean = false;
    public var movements:Vector.<Point>;
    public var attack:Vector.<Point>;
}
}
