/**
 * Created by William on 2/11/14.
 */
package gameplataform.controller.state {
import gameplataform.constants.GameState;
import gameplataform.controller.Game;

public class StateTest extends BaseState {

    public function StateTest(game:Game) {
        super(game, GameState.TEST, null, onEnter, onExit);
    }

    private function onEnter():void {

    }

    private function onExit():void {

    }
}
}
