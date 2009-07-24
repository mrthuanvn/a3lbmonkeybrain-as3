package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.filter.isNonEmptyString;
	import a3lbmonkeybrain.calculia.collections.graphs.Digraph;
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	
	import flash.utils.ByteArray;

	public final class DotExporter extends AbstractExporter
	{
		private static const QUOTE_NEEDED:RegExp = /[\s"']/g;
		public var edgeLabelFunction:Function;
		public var graphName:String;
		public var vertexIDFunction:Function;
		public function DotExporter()
		{
			super();
		}
		public static function quote(s:String):String
		{
			if (QUOTE_NEEDED.test(s))
				return "\"" + s.replace("\"", "\\\"") + "\"";
			return s;
		}
		override public function export(g:Graph):ByteArray
		{
			const bytes:ByteArray = new ByteArray();
			try
			{
				if (g is Digraph)
					bytes.writeUTFBytes("strict di");
				bytes.writeUTFBytes("graph");
				if (isNonEmptyString(graphName))
				{
					bytes.writeUTFBytes(" ");
					bytes.writeUTFBytes(graphName);
				}
				bytes.writeUTFBytes("\n{\n");
				for each (var vertex:Object in g.vertices)
				{
					bytes.writeUTFBytes("\t");
					bytes.writeUTFBytes(quote(applyStringFunction(vertexIDFunction, vertex)));
					bytes.writeUTFBytes(" [label=");
					bytes.writeUTFBytes(quote(applyStringFunction(vertexLabelFunction, vertex)));
					bytes.writeUTFBytes("];\n");
				}
				// :TODO: weights
				for each (var edge:FiniteCollection in g.edges)
				{
					bytes.writeUTFBytes("\t");
					if (edge is FiniteList)
					{
						var list:FiniteList = edge as FiniteList
						bytes.writeUTFBytes(quote(applyStringFunction(vertexIDFunction, list.getMember(0))));
						bytes.writeUTFBytes(" -> ");
						bytes.writeUTFBytes(quote(applyStringFunction(vertexIDFunction, list.getMember(1))));
					}
					else
					{
						var edgeArray:Array = edge.toArray();
						bytes.writeUTFBytes(quote(applyStringFunction(vertexIDFunction, edgeArray[0])));
						bytes.writeUTFBytes(" -- ");
						bytes.writeUTFBytes(quote(applyStringFunction(vertexIDFunction, edgeArray[1])));
					}
					bytes.writeUTFBytes(";\n");
				}
				bytes.writeUTFBytes("}");
			}
			catch (e:Error)
			{
				bytes.clear();
				throw e;
			}
			return bytes;
		}
	}
}