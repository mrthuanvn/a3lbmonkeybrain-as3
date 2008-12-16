package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.relate.Equatable;
	
	/**
	 * A collection of elements, such as a set or a list. Member elements may be any type of object.
	 * <p>
	 * Typically classes should not directly implement this interface, but one of its subinterfaces.
	 * </p>
	 * <p>
	 * In general, <code>Collection</code> implementations should extend <code>flash.utils.Proxy</code> in such a way that all
	 * members can be iterated over using <code>for each..in</code>.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html
	 *		flash.utils.Proxy
	 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
	 * 		for each..in
	 */
	public interface Collection extends Equatable
	{
		/**
		 * Tells whether this collection has any members.
		 * <p>
		 * If this collection is empty, </code>equals()</code> should be implemented in such a way that this collection is
		 * considered equal to any other empty collections of the same <code>Collection</code> subinterface (for example,
		 * <code>List</code>, <code>Set</code>).
		 * </p>
		 * 
		 * @return 
		 * 		If this collection has no members, <code>true</code>; otherwise <code>false</code>.
		 * @see #equals()
		 * @see List
		 * @see Set
		 */
		function get empty():Boolean;
		/**
		 * Tells whether this collection contains a certain element.
		 *  
		 * @param element
		 * 		Element to check for.
		 * @return 
		 * 		If this collection contains <code>element</code>, <code>true</code>; otherwise <code>false</code>.
		 */
		function has(element:Object):Boolean;
	}
}