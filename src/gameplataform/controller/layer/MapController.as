package gameplataform.controller.layer {

import flash.display.DisplayObjectContainer;

import gameplataform.controller.GameData;

import gameplataform.view.board.Board;

import gameplataform.view.lobby.Lobby;

import gameplataform.view.menu.MainMenu;

public class MapController extends LayerControllerBase {

    public var mainMenu:MainMenu;
    public var lobby:Lobby;
    public var board:Board;

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


    public function showBoard():void {
        board = new Board();
        board.x = GameData.stageWidth - board.width >> 1;
        board.y = GameData.stageHeight - board.height >> 1;
        super.addChild(board, "board");
    }

    public function hideBoard():void {
        if(board != null && super.placeHolder.contains(board)) {

            super.removeChild(board);
        }
        board = null;
    }
}

}