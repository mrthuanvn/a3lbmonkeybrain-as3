package a3lbmonkeybrain.visualcortex.alerts
{
	import a3lbmonkeybrain.brainstem.strings.camelToSpaced;
	
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	
	import mx.controls.Alert;
	
	public function alertErrorEvent(event:ErrorEvent):Alert
	{
		const title:String = (event.type == "ioError") ? "I/O Error" : camelToSpaced(event.type);
		const text:String = "An error occurred:\n\n\t" + event.text;
		return Alert.show(text, title);
	}
}