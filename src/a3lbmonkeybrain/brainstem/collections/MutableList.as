package a3lbmonkeybrain.brainstem.collections
{
	/**
	 * A finite list whose content can be changed.
	 *  
	 * @author T. Michael Keesey
	 */
	public interface MutableList extends FiniteList, MutableCollection
	{
		function addToStart(element:Object):void;
		function addMembersToStart(collection:Object):void;
		function removeAt(index:uint):void;
	}
}