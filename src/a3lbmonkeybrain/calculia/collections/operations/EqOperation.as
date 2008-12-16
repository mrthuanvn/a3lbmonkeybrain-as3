package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.relate.Equality;

	public final class EqOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Object, 2))
				return getUnresolvableArgument(args);
			const n:int = args.length;
			for (var i:int = 1; i < n; ++i)
			{
				if (!Equality.equal(args[0], args[i]))
					return false;
			}
			return true;
		}
		public function toString():String
		{
			return "=";
		}
	}
}