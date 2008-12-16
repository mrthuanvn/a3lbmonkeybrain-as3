package a3lbmonkeybrain.brainstem.collections
{
	/**
	 * A finite collection whose content can be changed.
	 * 
	 * @author T. Michael Keesey
	 */
	public interface MutableCollection extends FiniteCollection
	{
		/**
		 * Adds an element as a member of this set.
		 *  
		 * @param element
		 * 		New element to add as a member.
		 * @see #addMembers()
		 * @see #has()
		 * @see #remove()
		 */
		function add(member:Object):void;
		/**
		 * Adds the members of another collection.
		 *  
		 * @param value
		 * 		Another collection. Can be a <code>Collection</code> or any object whose members can be retrieved using
		 * 		<code>for each..in</code>.
		 * @see #add()
		 * @see Collection
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 */
		function addMembers(value:Object):void;
		/**
		 * Removes all members.
		 * 
		 * @see #remove()
		 */
		function clear():void;
		/**
		 * Removes a member of this collection.
		 *  
		 * @param element
		 * 		Element to remove. If it is not a member, then this method does nothing.
		 */		
		function remove(member:Object):void;
		/**
		 * Removes the members of another collection.
		 *  
		 * @param value
		 * 		Another collection. Can be a <code>Collection</code> or any object whose members can be retrieved using
		 * 		<code>for each..in</code>.
		 * @see #remove()
		 * @see Collection
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 */
		function removeMembers(value:Object):void;
	}
}