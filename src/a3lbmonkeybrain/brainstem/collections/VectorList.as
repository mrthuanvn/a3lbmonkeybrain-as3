package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.brainstem.relate.Equatable;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.flash_proxy;

	use namespace flash_proxy;
	
	/**
	 * An implementation of a mutable list which uses an internal <code>Vector.&lt;Object&gt;</code>.
	 * <p>
	 * As an alternative to using functions, bracket notation can be used:
	 * <pre>
	 * trace(vectorList[0]); // Traces the first element in the list, or "undefined" if there are no elements.
	 * delete vectorList[0]; // Removes the first element in the list.
	 * vectorList[0] = undefined; // Removes the first element in the list.
	 * vectorList[0] = new Object(); // Sets the first element to a new object.
	 * </pre>
	 * <p>
	 * It is also possible to iterate over the set using <code>for..in</code> or <code>for each..in</code>.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see http://livedocs.adobe.com/flex/3/langref/Vector.html
	 * 		Vector
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html
	 * 		flash.utils.Proxy
	 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for..in
	 * 		for..in
	 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
	 * 		for each..in
	 */
	public class VectorList extends AbstractProxyCollection implements MutableList
	{
		/**
		 * Internal array used to keep track of members. 
		 */
		protected var members:Vector.<Object> = new Vector.<Object>();
		/**
		 * Creates a new instance. The list is empty upon instantiation. 
		 */
		public function VectorList()
		{
			super();
		}
		/**
		 * @inheritDoc
		 */
		public function get empty():Boolean
		{
			return members.length == 0;
		}
		/**
		 * @inheritDoc
		 */
		public function get singleMember():Object
		{
			if (members.length == 1)
				return members[0];
			throw new IllegalOperationError("List is not a singleton.");
		}
		/**
		 * @inheritDoc
		 */
		public function get size():uint
		{
			return members.length;
		}
		/**
		 * Adds an item to the end of this list.
		 * 
		 * @param member
		 * 		New item to add to this list.
		 */
		public function add(member:Object):void
		{
			if (member == this)
				throw new IllegalOperationError("Collection cannot be a member of itself.");
			members.push(member);
		}
		/**
		 * Adds a series of items to the end of this list. 
		 * 
		 * @param value
		 * 		Object containing the items to add to the end of the list. Uses a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 */
		public function addMembers(value:Object):void
		{
			for each (var element:Object in value)
			{
				if (element == this)
					throw new IllegalOperationError("Collection cannot be a member of itself.");
				members.push(element);
			}
		}
		/**
		 * @inheritDoc 
		 */
		public function addMembersToStart(collection:Object):void
		{
			var v:Vector.<Object> = new Vector.<Object>();
			for each (var element:Object in collection)
			{
				if (element == this)
					throw new IllegalOperationError("Collection cannot be a member of itself.");
				v.push(element);
			}
			v = v.reverse();
			for each (element in v)
				members.unshift(element);
		}
		/**
		 * @inheritDoc 
		 */
		public function addToStart(member:Object):void
		{
			if (member == this)
				throw new IllegalOperationError("Collection cannot be a member of itself.");
			members.unshift(member);
		}
		/**
		 * @inheritDoc 
		 */
		public function clear():void
		{
			members = new Vector.<Object>();
		}
		/**
		 * Creates a copy of another <code>VectorList</code> object.
		 * 
		 * @param value
		 * 		List to copy.
		 * @return 
		 * 		A copy of <code>value</code>.
		 */
		public static function clone(value:VectorList):VectorList
		{
			const clone:VectorList = new VectorList();
			clone.members = value.members.concat();
			return clone;
		}
		/**
		 * Removes the element at a given index from this list.
		 * <p>
		 * This is called using bracket notation. Example:
		 * </p>
		 * <pre>
		 * import a3lbmonkeybrain.brainstem.collections.VectorList;
		 * import a3lbmonkeybrain.brainstem.collections.MutableList;
		 * 
		 * var list:MutableList = VectorList.fromObject([1, 2, 3]);
		 * trace(list); // (1, 2, 3)
		 * delete list[1];
		 * trace(list); // (1, 3)
		 * delete list[&quot;x&quot;]; // Throws ArgumentError.
		 * delete list[100]; // Throws RangeError.
		 * </pre>
		 * 
		 * @param name
		 * 		Numerical index of the member to remove. This is rounded down to the nearest integer.
		 * @return
		 * 		If the element was removed, <code>true</code>; otherwise <code>false</code>.
		 * @throws ArgumentError
		 * 		<code>ArgumentError</code> - If <code>name</code> is not a number.
		 * @throws RangeError
		 * 		<code>ArgumentError</code> - If <code>name</code> does not indicate any membver of this list.
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html#deleteProperty()
		 * 		flash.utils.Proxy.deleteProperty()
		 */
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			var index:Number = Number(name);
			if (isNaN(index))
				throw new ArgumentError("Index is not a number: " + name);
			index = Math.floor(index);
			if (index < 0 || index > members.length)
				throw new RangeError("Index is out of range: " + index);
			members.splice(index, 1);
			return true;
		}
		/**
		 * @inheritDoc
		 */
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is FiniteList)
			{
				const l:FiniteList = value as FiniteList;
				const n:uint = members.length;
				if (l.size != n)
					return false;
				for (var i:uint = 0; i < n; ++i)
					if (!Equality.equal(members[i], l.getMember(i)))
						return false;
				return true;
			}
			return false;
		}
		/**
		 * Creates a list using the members of another object.
		 *  
		 * @param value
		 * 		Object containing the items to add to the end of the list. Uses a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * @return
		 * 		New <code>VectorList</code> instance, populated with the members of <code>value</code>.
		 * @throws ArgumentError
		 * 		<code>ArgumentError</code> - If <code>value</code> is a nonfinite collection.
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 * @see Collection
		 * @see FiniteCollection
		 */
		public static function fromObject(value:Object):VectorList
		{
			if (value is Collection && !(value is FiniteCollection))
				throw new ArgumentError("Cannot create a finite collection from a nonfinite collection: " + value);
			const list:VectorList = new VectorList();
			list.addMembers(value);
			return list;
		}
		/**
		 * @inheritDoc
		 */
		public function getMember(index:uint):Object
		{
			if (index >= members.length)
				throw new RangeError("Index is out of range: " + index);
			return members[index];
		}
		/**
		 * Gets the member at a given index in this list.
		 * <p>
		 * This is called using bracket notation. Example:
		 * </p>
		 * <pre>
		 * import a3lbmonkeybrain.brainstem.collections.VectorList;
		 * import a3lbmonkeybrain.brainstem.collections.MutableList;
		 * 
		 * var list:MutableList = VectorList.fromObject([&quot;x&quot;, &quot;y&quot;, &quot;z&quot;]);
		 * trace(list); // (1, 2, 3)
		 * trace(list[0]); // x
		 * trace(list[1]); // y
		 * trace(list[2]); // z
		 * trace(list[3]); // undefined
		 * </pre>
		 *  
		 * @param name
		 * 		An integer from <code>0</code> to <code>size - 1</code>.
		 * @return
		 * 		The member at the index specified by <code>name</code>. If <code>name</code> does not specific an index within the
		 * 		range of this list, this method returns <code>undefined</code>.
		 * @see #size
		 * @see getMember()
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html#getProperty()
		 * 		flash.utils.Proxy.getProperty()
		 */
		override flash_proxy function getProperty(name:*):*
		{
			return members[name];
		}
		/**
		 * Checks if this list has a given property.
		 *  
		 * @param name
		 * 		Name of the property. The only names that return <code>true</code> are integers from <code>0</code> to
		 * 		<code>size - 1</code>.
		 * @return
		 * 		If the property exists, <code>true</code>; otherwise <code>false</code>.
		 * @see #size
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html#hasProperty()
		 * 		flash.utils.Proxy.hasProperty()
		 */
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return members[name] != undefined;
		}
		/**
		 * @inheritDoc 
		 */
		public function every(test:Function, thisObject:*=null):Boolean
		{
			return members.every(test, thisObject);
		}
		/**
		 * @inheritDoc 
		 */
		public function has(element:Object):Boolean
		{
			var member:Object;
			if (element is Equatable)
			{
				for each (member in members)
				{
					if (element.equals(member))
						return true;
				}
			}
			else
			{
				for each (member in members)
				{
					if (member == element)
						return true;
				}
			}
			return false;
		}
		/**
		 * @inheritDoc 
		 */
		public function filter(test:Function, thisObject:*=null):FiniteCollection
		{
			if (empty)
				return EmptyList.INSTANCE;
			const list:FiniteCollection = fromObject(members.filter(test, thisObject));
			return list.empty ? EmptyList.INSTANCE : list;
		}
		/**
		 * @inheritDoc 
		 */
		public function forEach(test:Function, thisObject:*=null):void
		{
			return members.forEach(test, thisObject);
		}
		/**
		 * Converts a finite collection into a mutable list.
		 *  
		 * @param value
		 * 		A finite collection.
		 * @return 
		 * 		If <code>value</code> already is a mutable list, returns <code>value</code>. Otherwise creates a new
		 * 		<code>VectorList</code> instance with the same members as <code>value</code>.
		 */
		public static function makeMutable(value:FiniteCollection):MutableList
		{
			if (value is MutableList)
				return value as MutableList;
			if (value is VectorList)
				return clone(value as VectorList);
			return fromObject(value.toVector());
		}
		/**
		 * @inheritDoc 
		 */
		public function map(mapper:Function, thisObject:*=null):FiniteCollection
		{
			if (empty)
				return EmptyList.INSTANCE;
			// :KLUDGE: Needs to be converted to an array for some reason.
			return fromObject(toArray().map(mapper, thisObject));
		}
		/**
		 * @inheritDoc 
		 */
		public function remove(member:Object):void
		{
			if (member is Equatable)
			{
				for (var i:uint = members.length; i > 0; --i)
				{
					if (Equatable(member).equals(members[i - 1]))
						members.splice(i - 1, 1);
				}
			}
			else
			{
				for (i = members.length; i > 0; --i)
				{
					if (member == members[i - 1])
						members.splice(i - 1, 1);
				}
			}
		}
		/**
		 * @inheritDoc
		 */
		public function removeAt(index:uint):void
		{
			if (index >= members.length)
				throw new RangeError("Index is out of range: " + index);
			members.splice(index, 1);
		}
		/**
		 * @inheritDoc 
		 */
		public function removeMembers(value:Object):void
		{
			for each (var element:Object in value)
			{
				remove(element);
			}
		}
		/**
		 * @inheritDoc 
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if (value == this)
				throw new IllegalOperationError("Collection cannot be a member of itself.");
			if (name == undefined)
				return;
			if (value == undefined)
			{
				deleteProperty(name);
			}
			else
			{
				var index:Number = Number(name);
				if (isNaN(index))
					throw new ArgumentError("Index is not a number: " + name);
				index = Math.floor(index);
				if (index < 0)
					throw new RangeError("Negative index: " + name);
				members[index] = value;
			}
		}
		/**
		 * @inheritDoc 
		 */
		public function some(test:Function, thisObject:*=null):Boolean
		{
			return members.some(test, thisObject);
		}
		/**
		 * @inheritDoc 
		 */
		public function toArray():Array
		{
			const n:uint = members.length;
			const a:Array = new Array(n);
			for (var i:uint = 0; i < n; ++i)
				a[i] = members[i];
			return a;
		}
		/**
		 * Returns a string representation of this list.
		 * <p>
		 * Examples:
		 * </p>
		 * <pre>
		 * ()
		 * (1, 2)
		 * ([object Object])
		 * (string, another string)
		 * (<xml/>, [object Object], (another, list), {a, set})
		 * </pre>
		 * @return 
		 * 		A comma-separated list of the elements, in order, surrounded with parentheses.
		 */
		public function toString():String
		{
			return "(" + members.join(", ") + ")";
		}
		/**
		 * @inheritDoc 
		 */
		override public function toVector():Vector.<Object>
		{
			return members.concat();
		}
	}
}