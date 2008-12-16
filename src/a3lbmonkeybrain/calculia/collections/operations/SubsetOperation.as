package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Set;

	public final class SubsetOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Set, 2, 2))
				return getUnresolvableArgument(args);
			return Set(args[0]).subsetOf(Set(args[1]));
		}
		public function toString():String
		{
			return "\u2286";
		}
	}
}