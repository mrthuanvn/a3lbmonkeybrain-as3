package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Collection;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathMLError;
	
	public final class NotInOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Object, 2, 2))
				return getUnresolvableArgument(args);
			if (!(args[1] is Collection))
				throw new MathMLError(toString() + " requires a collection as the second operand; found: " + args[1]);
			return !Collection(args[1]).has(args[0]);
		}
		public function toString():String
		{
			return "\u8713";
		}
	}
}