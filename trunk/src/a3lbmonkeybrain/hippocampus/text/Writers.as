package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.brainstem.core.findClass;
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	public final class Writers
	{
		private static const hash:Dictionary = new Dictionary();
		public function Writers()
		{
			super();
			throw new TypeError();
		}
		public static function findWriter(entity:Object):EntityWriter
		{
			if (entity == null)
				return null;
			const entityClass:Class = findClass(entity);
			const w:* = hash[entityClass];
			if (w is EntityWriter || w === null)
				return w as EntityWriter;
			try
			{
				const type:XML = describeType(entity);
				const writers:XMLList = type.metadata.(@name == "Writer");
				if (writers.length() == 1)
				{
					const writer:EntityWriter = MetadataUtil.createObject(writers[0] as XML,
						"type", EntityWriter, Object) as EntityWriter;
					if (writer is EntityWriter)
					{
						hash[entityClass] = writer;
						return writer;
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
		public static function writeHTML(entity:Object):XML
		{
			if (entity == null)
				return null;
			const writer:EntityWriter = findWriter(entity);
			if (writer is EntityWriter)
				return writer.writeHTML(entity);
			return new XML();
		}
		public static function writeText(entity:Object, format:String = "text"):String
		{
			if (entity == null)
				return null;
			const writer:EntityWriter = findWriter(entity);
			if (writer is EntityWriter)
				return writer.writeText(entity, format);
			return "";
		}
	}
}