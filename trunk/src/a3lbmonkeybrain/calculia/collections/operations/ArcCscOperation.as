package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.math.acsc;
	
	public final class ArcCscOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 1, 1))
				return getUnresolvableArgument(args);
			return acsc(args[0] as Number);
		}
		public function toString():String
		{
			return "arccsc";
		}
	}
}