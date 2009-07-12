package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	
	import flash.utils.ByteArray;

	public interface GraphExporter
	{
		function export(g:Graph):ByteArray;
	}
}