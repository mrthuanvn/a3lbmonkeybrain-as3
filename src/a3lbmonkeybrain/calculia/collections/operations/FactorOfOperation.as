package a3lbmonkeybrain.calculia.collections.operations
{

	public final class FactorOfOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, uint, 2, 2))
				return getUnresolvableArgument(args);
			if (args[0] == 0)
				return false;
			var d:Number = args[1] / args[0];
			return d == Math.floor(d);
		}
		public function toString():String
		{
			return "\u007C";
		}
	}
}