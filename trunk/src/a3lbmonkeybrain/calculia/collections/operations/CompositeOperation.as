package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.resolve.Unresolvable;
	
	public class CompositeOperation extends AbstractOperation
	{
		protected var f:Operation;
		protected var g:Operation;
		public function CompositeOperation(f:Operation, g:Operation)
		{
			super();
			this.f = f;
			this.g = g;
		}
		override public function apply(args:Array):Object
		{
			const gResult:Object = g.apply(args);
			if (gResult is Array)
				return f.apply(gResult as Array);
			else if (gResult is FiniteCollection)
				return f.apply(FiniteCollection(gResult).toArray());
			else if (gResult is Unresolvable)
				return gResult;
			return f.apply([gResult]);
		}
		public function toString():String
		{
			return "(" + String(f) + " \u2218 " + String(g) + ")";
		}
	}
}