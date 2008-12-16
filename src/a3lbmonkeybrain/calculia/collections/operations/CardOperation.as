package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	
	public final class CardOperation extends AbstractOperation
	{
		public function CardOperation()
		{
			super();
		}
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, FiniteSet, 1, 1))
				return getUnresolvableArgument(args);
			return FiniteSet(args[0]).size;
		}
		public function toString():String
		{
			return "card";
		}
	}
}