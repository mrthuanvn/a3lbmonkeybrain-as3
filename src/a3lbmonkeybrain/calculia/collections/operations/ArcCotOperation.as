package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.math.acot;
	
	public final class ArcCotOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 1, 1))
				return getUnresolvableArgument(args);
			return acot(args[0] as Number);
		}
		public function toString():String
		{
			return "arccot";
		}
	}
}