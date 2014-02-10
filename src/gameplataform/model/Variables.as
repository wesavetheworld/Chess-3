/**
 * Created with IntelliJ IDEA.
 * User: William
 * Date: 9/12/13
 * Time: 2:46 PM
 * To change this template use File | Settings | File Templates.
 */
package gameplataform.model {

/**
 * This class should contain IN-GAME variables only
 */
public class Variables {

    public var volumeMain       :Number = 1.0;
    public var volumeSFX        :Number = 1.0;
    public var volumeBackground :Number = 1.0;

    public var defaultConfiguration:BoardConfiguration;

    public var defaultPawn_white:MovementModel;
    public var defaultPawn_black:MovementModel;
    public var defaultKnight :MovementModel;
    public var defaultRook   :MovementModel;
    public var defaultBishop :MovementModel;
    public var defaultQueen  :MovementModel;
    public var defaultKing   :MovementModel;
}
}
