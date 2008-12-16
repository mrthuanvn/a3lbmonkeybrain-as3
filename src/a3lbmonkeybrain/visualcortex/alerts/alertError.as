package a3lbmonkeybrain.visualcortex.alerts
{
	import a3lbmonkeybrain.brainstem.strings.camelToSpaced;
	
	import flash.errors.IOError;
	
	import mx.controls.Alert;
	
	public function alertError(error:Error):Alert
	{
		const title:String = camelToSpaced(error.name);
		const text:String = "An error occurred:\n\n\t" + error.message;
		return Alert.show(text, title);
	}
}