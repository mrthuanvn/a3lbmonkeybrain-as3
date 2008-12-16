package a3lbmonkeybrain.visualcortex.alerts
{
	import mx.controls.Alert;
	import mx.rpc.Fault;
	
	public function alertFault(fault:Fault):Alert
	{
		const title:String = "Error: " + fault.faultCode.replace(".", " ");
		const text:String = "An error occurred:\n\n\t" + fault.faultString;
		return Alert.show(text, title);
	}
}