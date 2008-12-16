package a3lbmonkeybrain.hippocampus.upload
{
	import flash.events.Event;
	
	public final class EntityUploadResultEvent extends Event
	{
		public static const UPLOAD_RESULT:String = "uploadResult";
		private var _id:uint;
		private var _isDuplicate:Boolean;
		public function EntityUploadResultEvent(id:uint, isDuplicate:Boolean)
		{
			super(UPLOAD_RESULT, false, false);
			_id = id;
			_isDuplicate = isDuplicate;
		}
		public function get id():int
		{
			return _id;
		}
		public function get isDuplicate():Boolean
		{
			return _isDuplicate;
		}
		public function get isNew():Boolean
		{
			return !_isDuplicate;
		}
		override public function clone():Event
		{
			return new EntityUploadResultEvent(_id, _isDuplicate);
		}
		override public function toString():String
		{
			return formatToString("EntityUploadResultEvent", "identity", "isDuplicate");
		}
	}
}