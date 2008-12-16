package a3lbmonkeybrain.hippocampus.upload
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	
	public final class EntityUploadErrorEvent extends ErrorEvent
	{
		public static const UPLOAD_ERROR:String = "uploadError";
		private var _error:Error;
		public function EntityUploadErrorEvent(e:Error)
		{
			super(UPLOAD_ERROR, false, false, e.message);
			_error = e;
		}
		public function get error():Error
		{
			return _error;
		}
		override public function clone():Event
		{
			return new EntityUploadErrorEvent(_error);
		}
		override public function toString():String
		{
			return formatToString("EntityUploadErrorEvent", "text");
		}
	}
}