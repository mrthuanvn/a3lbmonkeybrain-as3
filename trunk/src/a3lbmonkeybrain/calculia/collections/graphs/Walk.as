package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;

	public interface Walk extends FiniteList
	{
		function get edges():FiniteList;
		function get vertices():FiniteList;
	}
}