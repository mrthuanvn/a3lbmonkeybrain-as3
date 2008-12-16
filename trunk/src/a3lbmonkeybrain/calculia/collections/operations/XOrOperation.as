package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.math.xor;
	
	public final class XOrOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Boolean, 2))
				return getUnresolvableArgument(args);
			var result:Boolean = xor(Boolean(args[0]), Boolean(args[1]));
			const n:int = args.length;
			for (var i:int = 2; i < n; ++i)
				result = xor(result, Boolean(args[i]));
			return result;
		}
		public function toString():String
		{
			return "xor";
		}
	}
}