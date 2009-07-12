package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	import a3lbmonkeybrain.calculia.collections.graphs.Graph;
	
	import flash.utils.ByteArray;

	public class AbstractExporter implements GraphExporter
	{
		public var vertexLabelFunction:Function;
		public function AbstractExporter()
		{
			super();
		}
		protected static function applyStringFunction(f:Function, o:Object):String
		{
			try
			{
				if (f != null)
					return String(f.apply(null, [o]));
				return String(o);
			}
			catch (e:Error)
			{
				return e.name + ": " + e.message;
			}
			return null;
		}
		protected static function stringToBytes(s:String):ByteArray
		{
			const bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(s, "us-ascii");
			return bytes;
		}
		public function export(g:Graph):ByteArray
		{
			throw new AbstractMethodError();
		}
	}
}