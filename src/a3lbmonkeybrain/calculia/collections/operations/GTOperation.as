package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.brainstem.relate.Order;

	public final class GTOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Object, 2))
				return getUnresolvableArgument(args);
			const n:int = args.length;
			for (var i:int = 1; i < n; ++i)
			{
				var a:Object = args[i - 1];
				var b:Object = args[i];
				if (Order.findOrder(a, b) <= 0)
					return false;
			}
			return true;
		}
		public function toString():String
		{
			return ">";
		}
	}
}