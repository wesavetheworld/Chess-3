/**
 * Created with IntelliJ IDEA.
 * User: William
 * Date: 10/18/13
 * Time: 11:07 AM
 * To change this template use File | Settings | File Templates.
 */
package gameplataform.controller.state {
import gameplataform.constants.GameSignals;
import gameplataform.constants.GameState;
import gameplataform.constants.SocketType;
import gameplataform.controller.Game;
import gameplataform.controller.GameData;
import gameplataform.controller.GameMechanics;

public class StateMainMenu extends BaseState {


    public function StateMainMenu(game:Game) {
        super(game, GameState.MAIN_MENU, null, onEnter, onExit);
    }

    private function onEnter():void {
        game.mapController.showMainMenu();
        game.mapController.mainMenu.dispatcher.add(GameSignals.LOGIN, onLogin);
        game.mapController.mainMenu.dispatcher.add(GameSignals.SIGNUP, onSignUp);

        GameMechanics.socket.dispatcher.add(SocketType.CONNECTED, onConnected);
        GameMechanics.socket.connect();
    }

    private function onExit():void {
        game.mapController.hideMainMenu();
    }

    //==================================
    //
    //==================================
    private function onConnected():void {
        GameMechanics.socket.dispatcher.remove(SocketType.CONNECTED, onConnected);
    }

    //==================================
    //  Login
    //==================================
    private function onLogin(user:String, password:String):void {
        game.mapController.mainMenu.disable();
        game.popupController.showHold();

        GameData.user = user;

        GameMechanics.socket.dispatcher.add(SocketType.DATA, onDataReceived);
        GameMechanics.socket.send({
            type: SocketType.LOGIN,
            user: user,
            password: password
        })
    }

    //==================================
    //  Sign Up
    //==================================
    private function onSignUp():void {
        game.mapController.mainMenu.disable();
        game.popupController.showSignup();
        game.popupController.signUp.dispatcher.add(GameSignals.SIGNUP, onConfirmSignUp);
        game.popupController.signUp.dispatcher.add(GameSignals.BACK, onBackSignup);
    }

    private function onConfirmSignUp(user:String, password:String):void {
        game.popupController.signUp.disable();
        GameMechanics.socket.dispatcher.add(SocketType.DATA, onDataReceived);
        GameMechanics.socket.send({
            type: SocketType.SIGNUP,
            user: user,
            password: password
        });
    }

    private function onBackSignup():void {
        game.popupController.hideSignup();

        game.mapController.mainMenu.enable();
    }

    //==================================
    //
    //==================================
    private function onDataReceived(dataString:String):void {
        GameMechanics.socket.dispatcher.remove(SocketType.DATA, onDataReceived);
        var data:Object = JSON.parse(dataString);
        switch(data.type) {
            case SocketType.LOGIN: {
                game.popupController.hideHold();
                if(data.hasOwnProperty("exists") && data.exists) {
                    super.machine.changeTo(GameState.LOBBY);
                } else {
                    game.mapController.mainMenu.enable();
                    game.mapController.mainMenu.errorMessage = "Usuário e/ou senha não encontrados.";
                }
                break;
            }
            case SocketType.SIGNUP: {
                if(data.hasOwnProperty("successful") && data.successful) {
                    game.mapController.mainMenu.enable();
                    game.popupController.hideSignup();
                } else {
                    game.popupController.signUp.enable();
                    game.popupController.signUp.errorMessage = "Usuário já existente, escolha outro nome";
                }
                break;
            }
        }
    }

}
}
