package a3lbmonkeybrain.calculia.collections.graphs.importers
{
	import a3lbmonkeybrain.brainstem.strings.clean;
	import a3lbmonkeybrain.calculia.collections.graphs.ArcFactory;
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	import a3lbmonkeybrain.calculia.collections.graphs.HashGraph;
	
	import flash.utils.ByteArray;

	public final class NewickImporter implements GraphImporter
	{
		public var arcFactory:ArcFactory;
		private var graph:HashGraph;
		private var vertices:Vector.<Object>;
		public function NewickImporter(arcFactory:ArcFactory = null)
		{
			super();
			this.arcFactory = arcFactory;
		}
		public function matches(bytes:ByteArray):Boolean
		{
			if (bytes == null || bytes.length < 2)
				return false;
			bytes.position = 0;
			var c:String;
			do
			{
				c = bytes.readUTFBytes(1);
			}
			while (bytes.position < bytes.length && /\s/.test(c));
			if (c != "(")
				return false;
			var openParens:int = 1;
			while (bytes.position < bytes.length)
			{ 
				c = bytes.readUTFBytes(1);
				if (c == "(")
					openParens++;
				else if (c == ")")
					openParens--;
			}
			return openParens == 0;
		}
		public function importGraph(bytes:ByteArray):Graph
		{
			var result:HashGraph = new HashGraph(); // :TODO: REstore //arcFactory);
			try
			{
				bytes.position = 0;
				graph = result;
				readVertex(bytes);
			}
			catch (e:Error)
			{
				throw e;
			}
			finally
			{
				graph = null;
				vertices = null;
			}
			return result;
		}
		private function readVertex(bytes:ByteArray):Object
		{
			do
			{
				var token:String = bytes.readUTFBytes(1);
			}
			while (/\s/.test(token));
			if (token == "(")
			{
				const children:Vector.<Object> = new Vector.<Object>();
				const weights:Vector.<Number> = new Vector.<Number>();
				do
				{
					children.push(readVertex(bytes));
					token = bytes.readUTFBytes(1);
					if (token == ":")
					{
						weights.push(readWeight(bytes));
						token = bytes.readUTFBytes(1);
					}
					else
						weights.push(NaN);
					if (token == ")")
						break;
					if (token != ",")
						throw new Error("Unexpected character '" + token
						        + "' in Newick tree string at position " + (bytes.position - 1) + ".");
				}
				while (true);
			}
			else bytes.position--;
			var vertex:Object = readVertexLabel(bytes);
			if (children)
				while (children.length != 0)
					null; // :TODO: REstore //graph.createWeightedEdge(vertex, children.pop(), weights.pop());
			return vertex;
		}
		private function readVertexLabel(bytes:ByteArray):Object
		{
			var name:String = "";
			var quoted:Boolean = false;
			const nameBytes:ByteArray = new ByteArray();
			while (bytes.position < bytes.length)
			{
				var byte:int = bytes.readByte();
				var token:String = String.fromCharCode(byte);
				if (token == "'")
				{
					if (!quoted && nameBytes.length != 0)
						nameBytes.writeByte(byte);
					quoted = !quoted;
					continue;
				}
				else if (!quoted)
				{
					if (token == ")" || token == "," || token == ":" || token == "(")
					{
						bytes.position--;
						break;
					}
				}
				if (nameBytes.length != 0 || !/\s/.test(token))
					nameBytes.writeByte(byte);
			}
			if (nameBytes.length == 0)
				return new Object();
			nameBytes.position = 0;
			name = clean(nameBytes.readUTFBytes(nameBytes.length)).replace(/;$/, "");
			if (name.length == 0)
				return new Object();
			return name;
		}
		private function readWeight(bytes:ByteArray):Number
		{
			var s:String = "";
			while (bytes.position < bytes.length)
			{
				var token:String = bytes.readUTFBytes(1);
				if (token == ")" || token == ",")
				{
					bytes.position--;
					break;
				}
				s += token;
			}
			return parseFloat(s);
		}
	}
}