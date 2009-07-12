package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.brainstem.collections.ArrayList;
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.collections.MutableSet;
	import a3lbmonkeybrain.brainstem.strings.clean;
	import a3lbmonkeybrain.calculia.collections.graphs.AcyclicGraph;
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	
	import flash.utils.ByteArray;

	public final class TextCladogramExporter extends AbstractExporter
	{
		private const siblingsLeft:Vector.<Boolean> = new Vector.<Boolean>();
		private var bytes:ByteArray;
		private var dag:AcyclicGraph;
		private var unnamedIndex:uint;
		public var vertexCompareFunction:Function;
		private var writtenVertices:MutableSet;
		public function TextCladogramExporter()
		{
			super();
		}
		override public function export(g:Graph) : ByteArray
		{
			if (!(g is AcyclicGraph))
				throw new ArgumentError("Only acyclic graphs can be written as text cladograms.");
			var result:ByteArray = new ByteArray();
			unnamedIndex = 1;
			try
			{
				bytes = result;
				dag = g as AcyclicGraph;
				writtenVertices = new HashSet();
				const minimal:FiniteSet = dag.minimal(dag.vertices);
				if (!minimal.empty)
					for each (var v:Object in minimal)
						writeTree(ArrayList.fromObject([null, v]));
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
				writtenVertices = null;
			}
			return result;
		}
		private function writeStructure():void
		{
			const n:uint = siblingsLeft.length;
			if (n == 0)
				return;
			if (n > 1)
			{
				for (var i:uint = 0; i < n - 1; ++i)
					if (siblingsLeft[i])
						bytes.writeUTFBytes("|  ");
					else
						bytes.writeUTFBytes("   ");
			}
			if (siblingsLeft[n - 1])
				bytes.writeUTFBytes("|--");
			else
				bytes.writeUTFBytes("`--");
		}
		private function writeTree(arc:FiniteList):void
		{
			const ancestor:Object = arc.getMember(1);
			var name:String = clean(applyStringFunction(vertexLabelFunction, ancestor));
			if (name == "") name = null;
			const multipleParents:Boolean = dag.arcsTo(ancestor).size > 1;
			if (name == null && multipleParents)
				name = "cl. innom. #" + (unnamedIndex++);
			var childArcs:Vector.<Object> = dag.arcsFrom(ancestor).toVector();
			if (name == null)
			{
				if (childArcs.length == 0)
					bytes.writeUTFBytes("\n");
				else
					bytes.writeUTFBytes("+--");
			}
			else
			{
				if (multipleParents)
					bytes.writeUTFBytes("#");
				bytes.writeUTFBytes(name);
				if (arc.size >= 3 && !isNaN(Number(arc.getMember(2))))
				{
					bytes.writeUTFBytes(" (");
					bytes.writeUTFBytes(Number(arc.getMember(2)).toString());
					bytes.writeUTFBytes(")");
				}
				bytes.writeUTFBytes("\n");
			}
			if (writtenVertices.has(ancestor))
				return;
			writtenVertices.add(ancestor);
			const n:uint = childArcs.length;
			if (n != 0)
			{
				if (vertexCompareFunction != null)
				{
					var children:Vector.<Object> = new Vector.<Object>();
					for each (var childArc:FiniteList in childArcs)
						children.push(childArc.getMember(1)); 
					children = children.sort(vertexCompareFunction);
					var newChildArcs:Vector.<Object> = new Vector.<Object>();
					for each (var child:Object in children)
						for each (childArc in childArcs)
							if (childArc.getMember(1) == child)
								newChildArcs.push(childArc);
					childArcs = newChildArcs;
				}
				siblingsLeft.push(true);
				for (var i:uint = 0; i < n; ++i)
				{
					if (i == n - 1)
						siblingsLeft[siblingsLeft.length - 1] = false;
					if (i != 0 || name != null)
						writeStructure();
					writeTree(childArcs[i] as FiniteList);
				}
				siblingsLeft.pop();
			}
		}
	}
}