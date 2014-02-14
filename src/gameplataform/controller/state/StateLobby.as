/**
 * Created by William on 2/13/14.
 */
package gameplataform.controller.state {
import gameplataform.constants.GameSignals;
import gameplataform.constants.GameState;
import gameplataform.constants.SocketType;
import gameplataform.controller.Game;
import gameplataform.controller.GameData;
import gameplataform.controller.GameMechanics;

public class StateLobby extends BaseState {

    public function StateLobby(game:Game) {
        super(game, GameState.LOBBY, null, onEnter, onExit);
    }

    private function onEnter():void {
        game.mapController.showLobby();
        game.mapController.lobby.setData(GameData.user);
        game.mapController.lobby.dispatcher.add(GameSignals.REFRESH, onLobbyRefresh);

        GameMechanics.socket.dispatcher.add(SocketType.DATA, onDataReceived);

        onLobbyRefresh();
    }

    private function onExit():void {

    }

    //==================================
    //
    //==================================
    private function onDataReceived(dataString:String):void {
        var data:Object = JSON.parse(dataString);
        switch(data.type) {
            case SocketType.REFRESH: {
                game.mapController.lobby.refresh(data.data);
                break;
            }
        }
    }

    //==================================
    //
    //==================================
    private function onLobbyRefresh():void {
        GameMechanics.socket.send({type:SocketType.REFRESH});
    }

    private function onLobbyConnect(opponentID:uint):void {
        //check if both players are available
        //if so, change both player's status to playing
        //start game in both sides

    }
}
}
