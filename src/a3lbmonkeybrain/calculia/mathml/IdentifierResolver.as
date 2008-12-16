package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.brainstem.resolve.XMLResolver;
	
	public interface IdentifierResolver extends XMLResolver
	{
		function reset():void;
		function setEntity(ciNode:XML, value:Object):void;
	}
}