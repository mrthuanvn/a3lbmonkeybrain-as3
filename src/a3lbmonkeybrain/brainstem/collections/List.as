package a3lbmonkeybrain.brainstem.collections
{
	/**
	 * An ordered collection of elements. Each member corresponds to one or more nonnegative integer indices.
	 * 
	 * @author T. Michael Keesey
	 */
	public interface List extends Collection
	{
		/**
		 * Gets the member at a given index.
		 *  
		 * @param index
		 * 		A nonnegative integer index.
		 * @return
		 * 		The member specified by <code>index</code>.
		 * @throws RangeError
		 * 		<code>RangeError</code> - If <code>index</code> does not correspond to a member of this list.
		 */		
		function getMember(index:uint):Object;
	}
}