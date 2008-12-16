package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.calculia.collections.domains.CartesianProductSet;

	public final class CartesianProductOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Set, 2))
				return getUnresolvableArgument(args);
			return new CartesianProductSet(args);
		}
		public function toString():String
		{
			return "×";
		}
	}
}