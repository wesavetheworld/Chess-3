/**
 * Created with IntelliJ IDEA.
 * User: William
 * Date: 10/18/13
 * Time: 11:07 AM
 * To change this template use File | Settings | File Templates.
 */
package gameplataform.controller.state {
import gameplataform.constants.GameStates;
import gameplataform.controller.Game;
import gameplataform.controller.GameMechanics;
import gameplataform.controller.data.ChessSocket;
import gameplataform.view.menu.MainMenu;

public class StateMainMenu extends BaseState {

    private var mainMenu:MainMenu;

    public function StateMainMenu(game:Game) {
        super(game, GameStates.MAIN_MENU, null, onEnter, onExit);
    }

    private function onEnter():void {
        mainMenu = new MainMenu();
        mainMenu.dispatcher.add(MainMenu.GO_ONLINE, onGoOnline);
        game.mapController.addChild(mainMenu, "mainmenu");
    }

    private function onExit():void {

    }


    //==================================
    //
    //==================================
    private function onGoOnline():void {
        mainMenu.disable();

        game.popupController.showSearching();

        GameMechanics.socket.dispatcher.add(ChessSocket.CONNECTED, onConnected);
        GameMechanics.socket.connect();
    }

    private function onConnected():void {
        GameMechanics.socket.dispatcher.remove(ChessSocket.CONNECTED, onConnected);

        game.popupController.hideSearching();
    }

}
}
