package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Set;
	
	public final class IntersectOperation extends AbstractOperation
	{
		override public function apply(args:Array):Object
		{
			if (!checkArguments(args, Set, 2))
				return getUnresolvableArgument(args);
			var result:Set = Set(args[0]).intersect(args[1] as Set);
			const n:int = args.length;
			if (n)
			{
				for (var i:int = 2; i < n; ++i)
					result = result.intersect(args[i] as Set);
			}
			return result;
		}
		public function toString():String
		{
			return "\u2229";
		}
	}
}