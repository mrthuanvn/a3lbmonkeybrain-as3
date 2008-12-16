package a3lbmonkeybrain.calculia.collections.operations
{
	public final class PlusOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 2))
				return getUnresolvableArgument(args);
			var sum:Number = args[0];
			var n:int = args.length;
			for (var i:int = 1; i < n; ++i)
			{
				sum += args[i];
			}
			return sum;
		}
		public function toString():String
		{
			return "+";
		}
	}
}