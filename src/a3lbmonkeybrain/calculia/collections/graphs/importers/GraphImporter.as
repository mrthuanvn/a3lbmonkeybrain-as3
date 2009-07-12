package a3lbmonkeybrain.calculia.collections.graphs.importers
{
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	
	import flash.utils.ByteArray;

	public interface GraphImporter
	{
		function matches(bytes:ByteArray):Boolean;
		function importGraph(bytes:ByteArray):Graph;
	}
}