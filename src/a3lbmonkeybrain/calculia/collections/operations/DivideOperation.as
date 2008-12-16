package a3lbmonkeybrain.calculia.collections.operations
{
	public final class DivideOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 2, 2))
				return getUnresolvableArgument(args);
			if (args[1] == 0)
				return null;
			return args[0] / args[1];
		}
		public function toString():String
		{
			return "/";
		}
	}
}