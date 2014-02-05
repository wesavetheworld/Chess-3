/**
 * Created by William on 2/5/14.
 */
package gameplataform.controller.data {
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.Socket;
import flash.system.Security;

public class CustomSocket extends Socket {

    private var response:String = "";
    private var log:String = "";

    public function CustomSocket(host:String = null, port:uint = 0) {
        super();
        Security.allowDomain("*");
        configureListeners();
        if(host && port) {
            super.connect(host, port);
        }
    }

    private function configureListeners():void {
        addEventListener(Event.CLOSE, closeHandler);
        addEventListener(Event.CONNECT, connectHandler);
        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityHandler);
        addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
    }


    private function write(str:String):void {
        try {
            super.writeUTFBytes(str);
        } catch(e:IOError) {
            trace(e);
        }
    }

    public function sendData(str:String):void {
        trace("sending : \"" + str + "\"");
        write(str);
        flush();
    }

    private function readResponse():String {
        return readUTFBytes(bytesAvailable);
    }

    private function closeHandler(e:Event):void {
        addReport("<Close>\n\t<event>" + e + "</event>\n</Close>");
    }

    private function connectHandler(e:Event):void {
        addReport("<Connection>\n\t<event>" + e + "</event>\n</Connection>");
    }

    private function ioErrorHandler(e:IOErrorEvent):void {
        addReport("<Error>\n\t<event>" + e + "</event>\n</Error>");
    }

    private function securityHandler(e:SecurityErrorEvent):void {
        addReport("<Security>\n\t<event>" + e + "</event>\n</Security>");
    }

    private function socketDataHandler(e:ProgressEvent):void {
        response = readResponse();
        addReport("<Data>\n\t<message>" + readResponse() + "</message>\n\t<event>"+e+"</event>\n</Data>");
    }

    private function addReport(report:String):void {
        log += report + "\n";
    }

    public function getReport():String {
        return log;
    }

}
}
