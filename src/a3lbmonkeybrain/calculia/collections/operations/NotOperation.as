package a3lbmonkeybrain.calculia.collections.operations
{
	public final class NotOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Boolean, 1, 1))
				return getUnresolvableArgument(args);
			return !args[0];
		}
		public function toString():String
		{
			return "\u00AC";
		}
	}
}