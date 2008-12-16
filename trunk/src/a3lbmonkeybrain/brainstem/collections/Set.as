package a3lbmonkeybrain.brainstem.collections
{
	/**
	 * A collection that contains each member only once. Sets are unordered by default.
	 * 
	 * @author T. Michael Keesey
	 */
	public interface Set extends Collection
	{
		/**
		 * Returns a set including all members of this set which are not members of a given object.
		 *  
		 * @param subtrahend
		 * 		Object containing members to be excluded from the result. May use a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @return
		 * 		A <code>Set</code> containing all members of this set which are not members of <code>value</code>.
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 */
		function diff(subtrahend:Object):Set;
		/**
		 * Collects all members of this set and another object.
		 *  
		 * @param operand
		 * 		Object containing members. May use a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @return
		 * 		A <code>Set</code> containing all members of this set which are also members of <code>value</code>.
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 */
		function intersect(operand:Object):Set;
		/**
		 * Tells whether this set is a proper subset of another object. (A proper subset is a subset which is not equal to the
		 * superset).
		 * <p>
		 * This must be implemented in such a way that if <code>equals(value)</code> is <code>true</code>, then
		 * <code>prSubsetOf(value)</code> is <code>false</code>. If <code>equals(value)</code> is <code>false</code>, then
		 * <code>prSubsetOf(value)</code> must equal <code>subsetOf(value)</code>.
		 * </p>
		 *  
		 * @param value
		 * 		Object containing members. May use a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @return
		 * 		If this is a proper subset of <code>value</code>, <code>true</code>; otherwise <code>false</code>.
		 * @see #equals()
		 * @see #subsetOf()
		 */
		function prSubsetOf(value:Object):Boolean;
		/**
		 * Tells whether this set is a subset of another object. (A subset may be equal to the superset).
		 * <p>
		 * This must be implemented in such a way that if <code>equals(value)</code> is <code>true</code>, then
		 * <code>subsetOf(value)</code> is <code>true</code>.
		 * </p>
		 *  
		 * @param value
		 * 		Object containing members. May use a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @return
		 * 		If all memebrs of this set are also members of <code>value</code>, <code>true</code>; otherwise <code>false</code>.
		 * @see #equals()
		 * @see #prSubsetOf()
		 */
		function subsetOf(value:Object):Boolean;
		/**
		 * Collects all members of this set and another object.
		 *  
		 * @param operand
		 * 		Object containing members. May use a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @return 
		 * 		A <code>Set</code> which contains all elements that are members of this set or of <code>operand</code>.
		 */
		function union(operand:Object):Set;
	}
}