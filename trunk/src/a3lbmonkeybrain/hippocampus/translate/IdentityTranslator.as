package a3lbmonkeybrain.hippocampus.translate
{
	public final class IdentityTranslator implements DataTranslator
	{
		public static const INSTANCE:IdentityTranslator = new IdentityTranslator();
		public function read(text:String):Object
		{
			return text;
		}
		public function write(entity:Object):String
		{
			return entity == null ? null : String(entity);
		}
	}
}