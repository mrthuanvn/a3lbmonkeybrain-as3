package a3lbmonkeybrain.calculia.collections.operations
{
	public final class OrOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Boolean, 2))
				return getUnresolvableArgument(args);
			var n:int = args.length;
			for (var i:int = 0; i < n; ++i)
			{
				if (args[i])
					return true;
			}			
			return false;
		}
		public function toString():String
		{
			return "\u2228";
		}
	}
}