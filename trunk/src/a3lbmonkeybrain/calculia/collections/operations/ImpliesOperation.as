package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.math.implies;
	
	public final class ImpliesOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Boolean, 2, 2))
				return getUnresolvableArgument(args);
			return implies(args[0] as Boolean, args[1] as Boolean);
		}
		public function toString():String
		{
			return "\u22A2";
		}
	}
}