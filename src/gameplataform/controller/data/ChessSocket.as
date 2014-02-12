/**
 * Created by William on 2/11/14.
 */
package gameplataform.controller.data {
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;

import gameplataform.view.Console;

import utils.managers.event.MultipleSignal;

import utils.managers.serializer.SerializerManager;

public class ChessSocket {

    public static const CONNECTED:String = "connected";

    public static const READ:String = "read";

    public var host:String = "";
    public var port:uint = 0;

    public var dispatcher:MultipleSignal;

    private var _socket:Socket;
    private var _lastDataReceived:String;

    public function ChessSocket(host:String = null, port:uint = 0) {
        super();
        this.host = host;
        this.port = port;
        this.dispatcher = new MultipleSignal(this);
    }

    //==================================
    //  Public
    //==================================
    public function connect():void {
        _socket = new Socket(host, port);
        _socket.addEventListener(Event.CONNECT                      , onConnect);
        _socket.addEventListener(Event.CLOSE                        , onClose);
        _socket.addEventListener(IOErrorEvent.IO_ERROR              , onIOError);
        _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR  , onSecurityError);
        _socket.addEventListener(ProgressEvent.SOCKET_DATA          , onData);
    }

    public function disconnect():void {

    }

    public function send(data:Object):void {
        try {
            _socket.writeUTFBytes(SerializerManager.JSONstringfy(data));
        } catch(e:IOError) {
            trace(e);
        }
        _socket.flush();
    }

    public function get lastDataReceived():String {
        return _lastDataReceived;
    }

    //==================================
    //  Private
    //==================================
    private function addReport(report:String):void {
        Console.log(report);
    }

    //==================================
    //  Events
    //==================================
    private function onClose(e:Event):void {
        addReport("<Close>\n\t<event>" + e + "</event>\n</Close>");
    }

    private function onConnect(e:Event):void {
        addReport("<Connection>\n\t<event>" + e + "</event>\n</Connection>");
        dispatcher.dispatch(CONNECTED);
    }

    private function onIOError(e:IOErrorEvent):void {
        addReport("<Error>\n\t<event>" + e + "</event>\n</Error>");
    }

    private function onSecurityError(e:SecurityErrorEvent):void {
        addReport("<Security>\n\t<event>" + e + "</event>\n</Security>");
    }

    private function onData(e:ProgressEvent):void {
        _lastDataReceived = _socket.readUTFBytes(_socket.bytesAvailable);
        addReport("<Data>\n\t<message>" + _lastDataReceived + "</message>\n\t<event>"+e+"</event>\n</Data>");
        dispatcher.dispatch(READ, _lastDataReceived);
    }


}
}
