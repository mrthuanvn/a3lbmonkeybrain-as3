package a3lbmonkeybrain.brainstem.collections
{
	/**
	 * A finite list whose content can be changed.
	 *  
	 * @author T. Michael Keesey
	 */
	public interface MutableList extends FiniteList, MutableCollection
	{
		function removeAt(index:int):void;
	}
}