package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.brainstem.strings.clean;
	import a3lbmonkeybrain.calculia.collections.graphs.AcyclicGraph;
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public final class NewickExporter extends AbstractExporter
	{
		private static const QUOTE_NEEDED:RegExp = /[\s,\(\):]/g;
		private var bytes:ByteArray;
		private var dag:AcyclicGraph;
		private var nameVertexMap:Dictionary;
		private var vertexNameMap:Dictionary;
		private var writtenVertices:MutableSet;
		public function NewickExporter()
		{
			super();
		}
		public static function quote(s:String):String
		{
			if (QUOTE_NEEDED.test(s))
				return "\"" + s.replace("\"", "\"\"") + "\"";
			return s;
		}
		private function writeTree(v:Object):void
		{
			if (!writtenVertices.has(v))
			{
				writtenVertices.add(v);
				const childrenArcs:FiniteSet = dag.arcsFrom(v);
				if (!childrenArcs.empty)
				{
					bytes.writeUTFBytes("(");
					var first:Boolean = true;
					for each (var childArc:FiniteList in childrenArcs)
					{
						if (first)
							first = false;
						else
							bytes.writeUTFBytes(",");
						writeTree(childArc.getMember(1));
						if (childArc.size >= 3)
						{
							bytes.writeUTFBytes(":");
							bytes.writeUTFBytes(String(childArc.getMember(2)));
						}
					}
					bytes.writeUTFBytes(")");
				}
			}
			var approvedName:Boolean = false;
			var name:* = vertexNameMap[v];
			if (name == undefined)
				name = clean(applyStringFunction(vertexLabelFunction, v));
			else
				approvedName = true;
			if (name == "")
				name = null;
			if (name == null && dag.arcsTo(name).size > 1)
				name = "innom";
			if (name != null)
			{
				if (!approvedName)
				{
					var original:String = name as String;
					var index:uint = 2;
					while (nameVertexMap.hasOwnProperty(name))
						name = original + "#" + (index++);
					nameVertexMap[name] = v;
					vertexNameMap[v] = name;
				}
				bytes.writeUTFBytes(quote(name as String));
			}
		}
		override public function export(g:Graph) : ByteArray
		{
			if (!(g is AcyclicGraph))
				throw new ArgumentError("Only acyclic graphs can be written as Newick tree strings.");
			var result:ByteArray = new ByteArray();
			try
			{
				bytes = result;
				dag = g as AcyclicGraph;
				writtenVertices = new HashSet();
				nameVertexMap = new Dictionary();
				vertexNameMap = new Dictionary();
				const minimal:FiniteSet = dag.minimal(dag.vertices);
				if (!minimal.empty)
				{
					if (minimal.size > 1)
						bytes.writeUTFBytes("(");
					var first:Boolean = true;
					for each (var v:Object in minimal)
					{
						if (first)
							first = false;
						else
							bytes.writeUTFBytes(",");
						writeTree(v);
					}
					if (minimal.size > 1)
						bytes.writeUTFBytes(")");
				}
			}
			catch (e:Error)
			{
				result.clear();
				throw e;
			}
			finally
			{
				dag = null;
				bytes = null;
				nameVertexMap = null;
				vertexNameMap = null;
				writtenVertices = null;
			}
			return result;
		}
	}
}