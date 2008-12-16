package a3lbmonkeybrain.hippocampus.translate
{
	public interface DataTranslator
	{
		function read(text:String):Object;
		function write(entity:Object):String;
	}
}