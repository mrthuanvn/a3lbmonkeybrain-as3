package a3lbmonkeybrain.calculia.collections.operations
{
	public final class TimesOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Number, 2))
				return getUnresolvableArgument(args);
			var product:Number = 1;
			var n:int = args.length;
			for (var i:int = 0; i < n; ++i) {
				if (args[i] == 0)
					return 0;
				product *= args[i];
			}
			return product;
		}
		public function toString():String
		{
			return "×";
		}
	}
}