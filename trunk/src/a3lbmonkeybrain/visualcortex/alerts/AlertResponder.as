package a3lbmonkeybrain.visualcortex.alerts
{
	import a3lbmonkeybrain.brainstem.assert.assertNotNull;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class AlertResponder implements IResponder
	{
		private var onFault:Function;
		private var onResult:Function;
		
		public function AlertResponder(onResult:Function = null, onFault:Function = null)
		{
			super();
			assertNotNull(onResult, "Null result handler for alert responder.");
			this.onFault = onFault;
			this.onResult = onResult;
		}

		public function fault(info:Object):void
		{
			if (info is FaultEvent)
				alertFault(FaultEvent(info).fault);
			else
				alertError(new Error(String(info)));
			if (onFault != null)
				onFault(info);
		}
		public function result(data:Object):void
		{
			try
			{
				if (onResult != null)
					onResult(data);
			}
			catch (e:Error)
			{
				alertError(e);
			}
		}
	}
}