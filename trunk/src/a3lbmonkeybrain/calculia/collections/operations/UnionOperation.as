package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Set;

	public final class UnionOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Set, 2))
				return getUnresolvableArgument(args);
			var result:Set = Set(args[0]).union(args[1] as Set);
			var n:int = args.length;
			for (var i:int = 2; i < n; ++i)
			{
				result = result.union(args[i] as Set);
			}
			return result;
		}
		public function toString():String
		{
			return "\u222A";
		}
	}
}