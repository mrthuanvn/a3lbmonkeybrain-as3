package a3lbmonkeybrain.calculia.collections.operations
{
	public final class AbsOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 1, 1))
				return getUnresolvableArgument(args);
			return Math.abs(args[0]);
		}
		public function toString():String
		{
			return "abs";
		}
	}
}