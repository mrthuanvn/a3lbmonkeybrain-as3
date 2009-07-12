package a3lbmonkeybrain.brainstem.collections
{
	/**
	 * A collection with a finite number of members.
	 * <p>
	 * In general, <code>FiniteCollection</code> implementations should extend <code>flash.utils.Proxy</code> in such a way that
	 * all members can be iterated over using <code>for each..in</code>.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html
	 *		flash.utils.Proxy
	 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
	 * 		for each..in
	 */
	public interface FiniteCollection extends Collection
	{
		/**
		 * If this is a singleton, returns the solitary member of this collection.
		 * <p>
		 * Should throw an <code>IllegalOperationError</code> if <code>size</code> is not <code>1</code>.
		 * </p>
		 * 
		 * @return 
		 * 		The only member of this collection.
		 * @throws flash.errors.IllegalOperationError
		 * 		<code>flash.errors.IllegalOperationError</code> - If <code>size</code> is not <code>1</code>.
		 */
		function get singleMember():Object;
		/**
		 * The number of members in this collection.
		 * <p>
		 * If <code>size</code> is <code>0</code>, then <code>empty</code> must be <code>true</code>. If <code>size</code> is not
		 * <code>0</code>, then <code>empty</code> must be <code>false</code>.
		 * </p>
		 * 
		 * @return 
		 * 		An integer from <code>0</code> to <code>uint.MAX_VALUE</code>.
		 * @see #empty
		 * @see http://livedocs.adobe.com/flex/3/langref/uint.html#MAX_VALUE
		 * 		uint.MAX_VALUE
		 */		
		function get size():uint;
		/**
		 * Checks whether all members of this collection return <code>true</code> when passed as an argument to a specified function.
		 * 
		 * @param test
		 * 		The function to run on each member of this collection. (May quit upon reaching a member that yields
		 * 		<code>false</code>.)
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the function.
		 * @return 
		 * 		A value of <code>true</code> if all members of this collection return <code>true</code> for the specified function;
		 * 		otherwise, <code>false</code>.
		 * @see #some()
		 */
		function every(test:Function, thisObject:* = null):Boolean;
		/**
		 * Returns a finite collection composed of all members of this collection which return <code>true</code> when
		 * passed as an argument to a specified function.
		 *  
		 * @param test
		 * 		The function to run on each member of this collection.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the function.
		 * @return 
		 * 		A finite collection composed of all members of this collection which return <code>true</code> when
		 * 		passed as an argument to a <code>test</code>.
		 */
		function filter(test:Function, thisObject:* = null):FiniteCollection;
		/**
		 * Executes a specified function on every member of this collection.
		 * 
		 * @param callback
		 * 		The function to run on each member of this collection.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the function.
		 */
		function forEach(callback:Function, thisObject:* = null):void;
		/**
		 * Returns a finite collection composed of the results of passing all members of this collection as arguments to a specified
		 * function. 
		 *  
		 * @param mapper
		 * 		The function to run on each member of this collection.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the function.
		 * @return 
		 * 		A finite collection containing all the results of passing all members of this collection as arguments to
		 * 		<code>test</code>.
		 */
		function map(mapper:Function, thisObject:* = null):FiniteCollection;
		/**
		 * Checks whether any member of this collection returns <code>true</code> when passed as an argument to a specified function.
		 * 
		 * @param test
		 * 		The function to run on each member of this collection. (May quit upon reaching a member that yields
		 * 		<code>true</code>.)
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the function.
		 * @return 
		 * 		A value of <code>true</code> if any member of this collection returns <code>true</code> for the specified function;
		 * 		otherwise, <code>false</code>.
		 * @see #every()
		 */
		function some(test:Function, thisObject:* = null):Boolean;
		/**
		 * Converts this collection to an array.
		 *  
		 * @return 
		 * 		An array containing all members of this collection.
		 */
		function toArray():Array;
		/**
		 * Converts this collection to a vector.
		 *  
		 * @return 
		 * 		A vector containing all members of this collection.
		 */
		function toVector():Vector.<Object>;
	}
}