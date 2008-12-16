package a3lbmonkeybrain.calculia.collections.operations
{
	public class ComposeOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Operation, 2, 2))
				return getUnresolvableArgument(args);
			return new CompositeOperation(Operation(args[0]), Operation(args[1]));
		}
		public function toString():String
		{
			return "\u2218";
		}
	}
}