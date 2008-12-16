package a3lbmonkeybrain.hippocampus.text
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;
	
	public final class Readers
	{
		private static const hash:Dictionary = new Dictionary();
		public function Readers()
		{
			super();
			throw new TypeError();
		}
		public static function findReader(entityClass:Class):EntityReader
		{
			if (entityClass == null)
				return null;
			const r:* = hash[entityClass];
			if (r is EntityReader || r === null)
				return r as EntityReader;
			try
			{
				const type:XML = describeType(new entityClass());
				const readers:XMLList = type.metadata.(@name == "Reader");
				if (readers.length() == 1)
				{
					const reader:EntityReader = MetadataUtil.createObject(readers[0] as XML,
						"type", EntityReader, Object) as EntityReader;
					if (reader is EntityReader)
					{
						hash[entityClass] = reader;
						return reader;
					}
				}
			}
			catch (e:Error)
			{
				trace("[WARNING]", e.name + ": " + e.message);
			}
			hash[entityClass] = null;
			return null;
		}
		public static function read(s:String, entityClass:Class):Object
		{
			if (s != null && s.length > 0)
			{
				const reader:EntityReader = findReader(entityClass);
				if (reader is EntityReader)
					return reader.read(s);
			}
			try
			{
				return new entityClass();
			}
			catch (e:Error)
			{
				trace("[WARNING]", e.name + ": " + e.message);
			}
			return null;
		}
	}
}