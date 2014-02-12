/**
 * Created by William on 2/11/14.
 */
package gameplataform.controller.state {
import gameplataform.constants.GameStates;
import gameplataform.controller.Game;
import gameplataform.controller.data.SocketIO;

public class StateTest extends BaseState {

    public function StateTest(game:Game) {
        super(game, GameStates.TEST, null, onEnter, onExit);
    }

    private function onEnter():void {
        socket = new SocketIO("localhost", {port:9001});

        startConnection();
    }

    private function onExit():void {

    }

    //==================================
    //
    //==================================

    private var socket:SocketIO;

    private function startConnection():void {
        socket.connect();
    }
}
}
