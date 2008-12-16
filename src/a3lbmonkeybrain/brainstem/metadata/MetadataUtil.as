package a3lbmonkeybrain.brainstem.metadata
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	public final class MetadataUtil
	{
		public function MetadataUtil()
		{
			super();
		}
		public static function copyArgs(metadata:XML, object:Object, excludedKeys:Array = null):void
		{
			for each (var arg:XML in metadata.arg)
			{
				var key:String = arg.@key.toXMLString();
				if (excludedKeys == null || !Equality.arrayContains(excludedKeys, key, null, false, false))
					object[key] = interpretXMLList(arg.@value);
			}
		}
		public static function createObject(metadata:XML, classArgKey:String, requiredClass:Class,
			defaultClass:Class, argKeyIsDefault:Boolean = true):Object
		{
			var objClassName:String = getArgValue(metadata, classArgKey, argKeyIsDefault) as String;
			if (objClassName == null || objClassName == "")
				return new defaultClass();
			var objClass:Class = getDefinitionByName(objClassName) as Class;
			if (objClass == null)
				throw new MetadataError("Cannot find class: " + objClassName);
			var obj:Object = new objClass();
			if (!(obj is requiredClass))
				throw new MetadataError("Class does not extend " + getQualifiedClassName(requiredClass)
					+ ": " + objClassName);
			return obj;
		}
		public static function fixXMLTextValue(s:String):String
		{
			if (s == null)	
				return null;
			return s.replace(/&lt;/g, "<").replace(/&gt;/g, ">");
		}
		public static function getArgValue(metadata:XML, key:String = "",
			argKeyIsDefault:Boolean = false):Object
		{
			if (metadata == null)
				throw new ArgumentError("Null metadata XML.");
			if (key == null)
				key = "";
			const args:XMLList = metadata.arg.(@key == key || (argKeyIsDefault && @key == ""));
			return args.length() == 0 ? null : interpretXMLList(args[0].@value);
		}
		private static function interpretXMLList(value:XMLList):Object
		{
			var stringValue:String = value.toXMLString();
			if (stringValue == "true")
				return true;
			if (stringValue == "false")
				return false;
			var numberValue:Number = Number(stringValue);
			if (isNaN(numberValue))
				return stringValue;
			return numberValue;
		}
	}
}