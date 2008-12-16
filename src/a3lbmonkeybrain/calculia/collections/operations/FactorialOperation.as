package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.math.factorial;
	
	public final class FactorialOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, uint, 1, 1))
				return getUnresolvableArgument(args);
			return factorial(uint(args[0]));
		}
		public function toString():String
		{
			return "!";
		}
	}
}