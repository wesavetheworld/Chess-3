<?php 	
	//require_once 'services/include/login.php';

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<title>Aennova</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="js/swfobject.js"></script>
		<script type="text/javascript" src="js/jquery-1.7.js"></script>
		<script type="text/javascript">
		    var SWF_WIDTH=849;
		    var SWF_HEIGHT=600;
			<!-- //Set to minimum required Flash Player version or 0 for no version detection -->
			var swfVersionStr = "9.1.52";
			<!-- //xiSwfUrlStr can be used to define an express installer SWF. -->
			var xiSwfUrlStr = "";
			var flashvars = {};

			//flashvars.idJogador =   <?php //echo '"'.$idJogador.'"'?>;


			var params = {};
			params.quality = "high";
			params.bgcolor = "#111111";
			params.play = "true";
			params.loop = "true";
			params.wmode = "window";
			params.scale = "showall";
			params.menu = "true";
			params.devicefont = "false";
			params.salign = "";
			params.allowscriptaccess = "sameDomain";
			params.allowFullScreen = "true";
			var attributes = {};
			attributes.id = "main";
			attributes.name = "main";
			attributes.align = "middle";
			swfobject.embedSWF("main.swf?rnd=" + Math.floor(Math.random() * 999), "flashContent",SWF_WIDTH, SWF_HEIGHT,swfVersionStr, xiSwfUrlStr,flashvars, params,attributes);
		</script>
	</head>
	<body background="img/bg.png">
		<div id="main2"  style="width:100%;">
		<small><a href= "telaLogin.php"> Sair </a> </small>			
			<div id="container" >	
				<div id="flashContent">
					<a href="http://www.adobe.com/go/getflash">
						<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
					</a>
					<p>This page requires Flash Player version 9.1.52 or higher.</p>
				</div>
			</div>

		</div>

		<script>
		$(document).ready(function(){		  
		 centerSWF();		  
		});
		$(window).resize(function(){
		 centerSWF();
		})
		
		function centerSWF(){
			var t = $(window).height();
			 var d = 0;
			 if(t > SWF_HEIGHT){
			  d = (t - SWF_HEIGHT)/2
			 }
			 $("#container").css("margin", d+"px auto");

			 $("#container").width(SWF_WIDTH);

		}

		function traceWeb(msg) {
				var tracearea = $("#traceWebTextArea");
				var output = tracearea.val();
				output += msg;
				output += " \n--------------------------------------------------------------------\n";
				tracearea.val(output);
		}
		</script>
		<textarea id="traceWebTextArea" rows="20" cols="110" style="font: 12px courier new;"></textarea>
		
	</body>
</html>

