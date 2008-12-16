package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Set;

	public final class SetDiffOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Set, 2, 2))
				return getUnresolvableArgument(args);
			return Set(args[0]).diff(args[1] as Set);
		}
		public function toString():String
		{
			return "\u2212";
		}
	}
}