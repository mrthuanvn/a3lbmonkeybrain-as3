package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.Set;
	
	public interface Operation extends Set
	{
		function apply(args:Array):Object;
	}
}