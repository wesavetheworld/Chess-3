package gameplataform.controller.layer {

import flash.display.DisplayObjectContainer;

import gameplataform.view.lobby.Lobby;

import gameplataform.view.menu.MainMenu;

public class MapController extends LayerControllerBase {

    public var mainMenu:MainMenu;

    public var lobby:Lobby;

    public function MapController(inPlaceHolder:DisplayObjectContainer) {
        super(inPlaceHolder, "MapController");
    }

    public function showMainMenu():void {
        mainMenu = new MainMenu();
        super.addChild(mainMenu, "mainMenu");
    }

    public function hideMainMenu():void {
        if(mainMenu != null && super.placeHolder.contains(mainMenu)) {
            mainMenu.destroy();
            super.removeChild(mainMenu);
        }
        mainMenu = null;
    }


    public function showLobby():void {
        lobby = new Lobby();
        super.addChild(lobby, "lobby");
    }

    public function hideLobby():void {
        if(lobby != null && super.placeHolder.contains(lobby)) {
            lobby.destroy();
            super.removeChild(lobby);
        }
        lobby = null;
    }
}

}