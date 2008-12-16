package a3lbmonkeybrain.calculia.collections.operations
{
	public final class MinusOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 2, 2))
				return getUnresolvableArgument(args);
			return args[0] - args[1];
		}
		public function toString():String
		{
			return "\u2212";
		}
	}
}