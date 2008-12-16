package a3lbmonkeybrain.hippocampus.translate
{
	public class DelegateTranslator implements DataTranslator
	{
		private var readFunction:Function;
		private var thisObject:Object;
		private var writeFunction:Function;
		public function DelegateTranslator(readFunction:Function = null, writeFunction:Function = null, thisObject:Object = null)
		{
			super();
			this.readFunction = (readFunction == null) ? identity : readFunction;
			this.writeFunction = (writeFunction == null) ? identity : writeFunction;
			this.thisObject = thisObject;
		}
		public static function identity(value:Object):Object
		{
			return value;
		}
		public function read(text:String):Object
		{
			return readFunction.apply(thisObject, [text]) as Object;
		}
		public function write(entity:Object):String
		{
			return writeFunction.apply(thisObject, [entity]) as String;
		}
	}
}