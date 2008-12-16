package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.math.asec;
	
	public final class ArcSecOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 1, 1))
				return getUnresolvableArgument(args);
			return asec(args[0] as Number);
		}
		public function toString():String
		{
			return "arcsec";
		}
	}
}