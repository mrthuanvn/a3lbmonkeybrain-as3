package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.hippocampus.domain.EntityClassAssociate;
	
	public interface EntityWriter extends EntityClassAssociate
	{
		function writeHTML(value:Object):XML;
		function writeText(value:Object, format:String = "text"):String;
	}
}