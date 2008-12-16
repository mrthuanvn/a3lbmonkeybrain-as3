package a3lbmonkeybrain.calculia.collections.operations
{
	import flash.errors.IllegalOperationError;
	
	import a3lbmonkeybrain.brainstem.resolve.Unresolvable;
	
	public final class UnresolvableOperation extends AbstractOperation implements Unresolvable
	{
		private var _mathML:XML;
		public function UnresolvableOperation(mathML:XML):void
		{
			super();
			_mathML = mathML.copy();
		}
		public function get mathML():XML
		{
			return _mathML.copy();
		}
		override public function apply(args:Array):Object
		{
			throw new IllegalOperationError("Cannot apply an unresolvable operation.");
		}
		public function toString():String
		{
			XML.prettyPrinting = false;
			return "[UnresolvableOperation " + _mathML.toXMLString() + "]";
		}
	}
}