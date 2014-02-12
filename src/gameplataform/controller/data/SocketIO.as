/**
 * Created by William on 2/11/14.
 */
package gameplataform.controller.data {
import flash.errors.IOError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;

import utils.managers.serializer.SerializerManager;

public class SocketIO extends EventDispatcher {

    public var host:String;
    public var options:Object;

    private var _socket:Socket;
    private var response:String;

    private var _connected:Boolean = false;
    private var _connecting:Boolean = false;

    public function SocketIO(host:String, options:Object) {
        super();
        this.host = host;
        this.options = {
            secure: options.secure || false,
            port: options.port || 80,
            resource: options.resource || "socket.io"
        };
    }

    public function connect():void {
        if(_connecting) {
            disconnect();
        }
        _connecting = true;
        _socket = new Socket(host, options.port);
        _socket.addEventListener(Event.CONNECT                      , onConnect);
        _socket.addEventListener(Event.CLOSE                        , onClose);
        _socket.addEventListener(IOErrorEvent.IO_ERROR              , onIOError);
        _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR  , onSecurityError);
        _socket.addEventListener(ProgressEvent.SOCKET_DATA          , onData);
    }

    public function disconnect():void {
        if(!_connected) {
            return;
        }
        _connected = false;
    }

    public function send(data:Object):void {
        write(SerializerManager.JSONstringfy(data));
        _socket.flush();
    }

    //==================================
    //
    //==================================
    private function readResponse():String {
        return _socket.readUTFBytes(_socket.bytesAvailable);
    }

    private function write(str:String):void {
        try {
            _socket.writeUTFBytes(str);
        } catch(e:IOError) {
            trace(e);
        }
    }

    //==================================
    //
    //==================================
    private function onClose(e:Event):void {
        trace("<Close>\n\t<event>" + e + "</event>\n</Close>");
    }

    private function onConnect(e:Event):void {
        trace("<Connection>\n\t<event>" + e + "</event>\n</Connection>");
    }

    private function onIOError(e:IOErrorEvent):void {
        trace("<Error>\n\t<event>" + e + "</event>\n</Error>");
    }

    private function onSecurityError(e:SecurityErrorEvent):void {
        trace("<Security>\n\t<event>" + e + "</event>\n</Security>");
    }

    private function onData(e:ProgressEvent):void {
        response = readResponse();
        trace("<Data>\n\t"+response+"\n</Data>");
        //trace("<Data>\n\t<message>" + response + "</message>\n\t<event>"+e+"</event>\n</Data>");
    }

}
}
