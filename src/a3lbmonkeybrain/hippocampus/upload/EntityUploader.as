package a3lbmonkeybrain.hippocampus.upload
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;

	[Bindable]
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "ioError", type = "flash.events.IOErrorEvent")]
	[Event(name = "open", type = "flash.events.Event")]
	[Event(name = "progess", type = "flash.events.ProgressEvent")]
	[Event(name = "securityError", type = "flash.events.SecurityErrorEvent")]
	[Event(name = "uploadError", type = "a3lbmonkeybrain.hippocampus.upload.EntityUploadErrorEvent")]
	[Event(name = "uploadResult", type = "a3lbmonkeybrain.hippocampus.upload.EntityUploadResultEvent")]
	public class EntityUploader extends EventDispatcher
	{
		public static const TOTAL_TYPE_FILTER:FileFilter = new FileFilter("All files", "*.*");
		private const _fileRef:FileReference = createFileRef();
		private var _typeFilter:Array = [TOTAL_TYPE_FILTER];
		private var _request:URLRequest = new URLRequest();
		public function EntityUploader()
		{
			super();
		}
		public function get fileRef():FileReference
		{
			return _fileRef;
		}
		public function get typeFilter():Array
		{
			return _typeFilter;
		}
		public function set typeFilter(value:Array):void
		{
			_typeFilter = [];
			for each (var item:Object in value)
			{
				if (value is FileFilter)
					_typeFilter.push(value);
			}
		}
		public function get request():URLRequest
		{
			return _request;
		}
		public function set request(value:URLRequest):void
		{
			_request = value ? value : new URLRequest();
		}
		private function createFileRef():FileReference
		{
			const ref:FileReference = new FileReference();
			ref.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onUploadDataComplete);
			ref.addEventListener(Event.OPEN, dispatchEvent);
			ref.addEventListener(Event.COMPLETE, dispatchEvent);
			ref.addEventListener(Event.SELECT, start);
			ref.addEventListener(IOErrorEvent.IO_ERROR, dispatchEvent);
			ref.addEventListener(ProgressEvent.PROGRESS, dispatchEvent);
			ref.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchEvent);
			ref.addEventListener(Event.SELECT, start);
			return ref;
		}
		private static function handleError(detail:XML):void
		{
			if (!detail.hasOwnProperty("@message"))
				throw new Error("No message in error response.");
			throw new Error(detail.@message);
		}
		private function handleResult(detail:XML, isDuplicate:Boolean):void
		{
			if (!detail.hasOwnProperty("@id"))
				throw new Error("No ID in response.");
			const id:uint = parseInt(detail.@id);
			if (!(id > 0))
				throw new Error("Invalid ID in response: " + detail.@id);
			dispatchEvent(new EntityUploadResultEvent(id, isDuplicate));
		}
		private function onUploadDataComplete(event:DataEvent):void
		{
			try
			{
				const response:XML = new XML(event.data);
				if (response.name().toString() != "response")
					throw new Error("Expected <response/> element.");
				if (response.children().length() < 1)
					throw new Error("Insufficient data in response.");
				if (response.children().length() > 1)
					throw new Error("Unexpected data in response.");
				const detail:XML = response.children()[0];
				switch (detail.name().toString())
				{
					case "new" :
					{
						handleResult(detail, false);
						break;
					}
					case "duplicate" :
					{
						handleResult(detail, true);
						break;
					}
					case "exception" :
					{
						handleError(detail);
						break;
					}
					default :
					{
						XML.prettyPrinting = false;
						throw new Error("Unrecognized response detail: " + detail);
					}
				}
			}
			catch (e:Error)
			{
				dispatchEvent(new EntityUploadErrorEvent(e));
			}
		}
		public function start(event:Event = null):void
		{
			try
			{
				_fileRef.size;
			}
			catch (e:Error)
			{
				_fileRef.browse(typeFilter);
				return;
			}
			_fileRef.upload(_request);
		}
	}
}