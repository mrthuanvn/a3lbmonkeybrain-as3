package a3lbmonkeybrain.brainstem.collections
{
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;

	/**
	 * Implementation of a mutable set which uses an internal hash table (<code>Dictionary</code> object).
	 * <p>
	 * As an alternative to using functions, bracket notation can be used if the elements are strings or
	 * convert to unique strings using <code>toString()</code> (e.g., booleans, numbers, arrays of strings or
	 * numbers, etc.):
	 * <pre>
	 * trace(hashSet[someString]); // Traces someString if it is a member, "undefined" otherwise.
	 * delete hashSet[someString]; // Removes someString from the set.
	 * hashSet[someString] = undefined; // Removes someString from the set.
	 * hashSet[someString] = someString; // Adds someString to the set.
	 * hashSet[someString] = otherString; // Throws an error.
	 * </pre>
	 * <p>
	 * It is also possible to iterate over the set using <code>for..in</code> or <code>for each..in</code>.
	 * Both do the same thing if all elements are strings or convert to unique strings, but, in general, 
	 * <code>for each..in</code> should be used.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Dictionary.html
	 * 		flash.utils.Dictionary
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/utils/Proxy.html
	 * 		flash.utils.Proxy
	 * @see http://livedocs.adobe.com/flex/3/langref/Object.html#toString()
	 * 		Object.toString()
	 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
	 * 		for each..in
	 */
	public class HashSet extends AbstractProxyCollection implements MutableSet
	{
		/**
		 * The hash table that stores data for this set. Keys and values must be the same.
		 * Any key or value is a member of the set; anything else is not.
		 */
		protected const hash:Dictionary = new Dictionary();
		/**
		 * The number of members in this set. This is maintained separately and must always be
		 * synchronized. 
		 * 
		 * @see #empty
		 * @see #size
		 */
		protected var _size:uint = 0;
		/**
		 * Creates a new, empty instance. 
		 * 
		 * @see #empty
		 * @see #clone()
		 * @see #fromObject()
		 */		
		public function HashSet()
		{
			super();
		}
		/**
		 * Tells whether this set is empty.
		 * <p>
		 * This set is empty if and only if <code>size == 0</code>.
		 * </p>
		 * 
		 * @see #size
		 */
		public function get empty():Boolean
		{
			return _size == 0;
		}
		/**
		 * The only member of this set, if this set is a singleton.
		 * 
		 * @throws flash.errors.IllegalOperationError
		 * 		<code>flash.errors.IllegalOperationError</code> - If <code>size</code> is not 1.
		 * @see #size
		 * @see #createSingleton()
		 */		
		public function get singleMember():Object
		{
			if (_size == 1)
			{
				for each (var member:* in hash)
					return member;
			}
			throw new IllegalOperationError("Set is not a singleton.");
		}
		/**
		 * The number of members in this set. 
		 * 
		 * @see #empty
		 */
		public function get size():uint
		{
			return _size;
		}
		/**
		 * Adds an element as a member of this set. If it is already a member, does nothing.
		 *  
		 * @param element
		 * 		New member to add.
		 * @see #addMembers()
		 * @see #has()
		 * @see #remove()
		 */
		public function add(element:Object):void
		{
			if (element == this)
				throw new IllegalOperationError("Collection cannot be a member of itself.");
			if (hash[element] != element)
			{
				hash[element] = element;
				++_size;
			}
		}
		/**
		 * Adds the members of another collection.
		 *  
		 * @param value
		 * 		Another collection. Can be a <code>HashSet</code>, an <code>Array</code>, a <code>Vector</code>, or any
		 * 		object that allows <code>for each..in</code> iteration.
		 * @see #add()
		 */
		public function addMembers(value:Object):void
		{
			for each (var element:Object in value)
			{
				if (element == this)
					throw new IllegalOperationError("Collection cannot be a member of itself.");
				add(element);
			}
		}
		/**
		 * @inheritDoc
		 */
		public function clear():void
		{
			for (var member:Object in hash)
			{
				delete hash[member];
			}
			_size = 0;
		}
		/**
		 * Creates a copy of a set.
		 *  
		 * @param value
		 * 		The set to copy.
		 * @return 
		 * 		A new set with the same membership as <code>value</code>.
		 * @see #fromObject()
		 */
		public static function clone(value:HashSet):HashSet
		{
			const clone:HashSet = new HashSet();
			clone._size = value._size;
			for (var member:Object in value.hash)
			{
				clone.hash[member] = member;
			}
			return clone;
		}
		/**
		 * Creates a singleton set (a set with one member).
		 *  
		 * @param member
		 * 		The solitary member of the new set.
		 * @return 
		 * 		A new set with a <code>size</code> of <code>1</code> and <code>member</code> as the only member.
		 * @see #singleMember
		 * @see #clone()
		 * @see #fromObject()
		 */
		public static function createSingleton(member:Object):HashSet
		{
			const singleton:HashSet = new HashSet();
			singleton.hash[member] = member;
			singleton._size = 1;
			return singleton;
		}
		/**
		 * Removes an object from this set.
		 * <p>
		 * Works much like <code>remove()</code>. The following are equivalent:
		 * </p>
		 * <pre>
		 * delete hashSet[element];
		 * hashSet.remove(element);
		 * </pre>
		 * 
		 * @param name
		 * 		The member to remove.
		 * @return
		 * 		A value of <code>true</code> if the object was removed; <code>false</code> otherwise.
		 * @see #remove()
		 */		
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			if (hash[name] == undefined)
				return false;
			delete hash[name];
			--_size;
			return true;
		}
		/**
		 * Returns the difference between this set and another object.
		 *  
		 * @param subtrahend
		 * 		Set to subtract from this set. This function is optimized for a <code>HashSet</code>
		 * 		object, but can use any type of object that can be iterated over using
		 * 		<code>for each..in</code>.
		 * @return 
		 * 		A set that includes all members of this set that are not in <code>subtrahend</code>.
		 * 		Under some circumstances, may simply return this set.
		 */
		public function diff(subtrahend:Object):Set
		{
			if (subtrahend is Collection)
			{
				var member:Object;
				var result:HashSet;
				if (subtrahend.empty)
					return this;
				if (subtrahend is HashSet)
				{
					if (_size == 0)
						return this;
					result = new HashSet();
					for (member in hash)
					{
						if (subtrahend.hash[member] == undefined)
						{
							result.hash[member] = member;
							++result._size;
						}
					}
					return result;
				}
				result = new HashSet();
				for (member in this)
				{
					if (!subtrahend.has(member))
						result.add(member);
				}
				return result;
			}
			return diff(fromObject(subtrahend));
		}
		/**
		 * Checks if this set is equivalent to another set.
		 *  
		 * @param value
		 * 		Set to check against. If not a <code>HashSet<code>, returns <code>false<code>
		 * @return 
		 * 		A value of <code>true</code> if <code>value</code> has the same membership as this set;
		 * 		<code>false</code> otherwise.
		 */
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is HashSet)
			{
				if (_size != value._size)
					return false;
				for (var member:Object in hash)
				{
					if (value.hash[member] == undefined)
						return false;
				}
				return true;
			}
			else if (value is FiniteSet)
			{
				if (_size != value.size)
					return false;
				for (member in hash)
				{
					if (!value.has(member))
						return false;
				}
				return true;
			}
			return false;
		}
		/**
		 * Checks whether all members of the set satisfy a criterion.
		 * <p>
		 * If this set is empty, this will always return <code>true</code>.
		 * <p>
		 *  
		 * @param test
		 * 		The criterion to test for. Must take a single argument and return a
		 * 		<code>Boolean</code> value.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the test function.
		 * @return 
		 * 		A value of <code>true</code> is at least one member causes <code>test</code> to return
		 * 		<code>true</code>; <code>false</code> otherwise.
		 * @see #exists()
		 * @see #empty
		 */
		public function every(test:Function, thisObject:* = null):Boolean
		{
			for (var member:Object in hash)
			{
				if (!test.apply(thisObject, [member]))
					return false;
			}
			return true;
		}
		/**
		 * Executes a test function on each member of this set and constructs a new set for all members that return
		 * <code>true</code> for the specified function. If a member returns <code>false</code>, it is not included in
		 * the new set. 
		 *  
		 * @param test
		 * 		The criterion to test for. Must take a single argument and return a
		 * 		<code>Boolean</code> value.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the test function.
		 * @return 
		 * 		A new set including only the elements of this set which <code>test</code> returns <code>true</code> for.
		 */
		public function filter(test:Function, thisObject:* = null):FiniteCollection
		{
			const filtered:HashSet = new HashSet();
			for each (var member:Object in hash)
			{
				if (test.apply(thisObject, [member]))
				{
					filtered.hash[member] = member;
					++filtered._size;
				}
			}
			return filtered._size == 0 ? EmptySet.INSTANCE : filtered;
		}
		/**
		 * Executes a function on each member of this set.  
		 *  
		 * @param callback
		 * 		The function to run on each member. Must take a single argument.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the test function.
		 */
		public function forEach(test:Function, thisObject:* = null):void
		{
			for each (var member:Object in hash)
			{
				test.apply(thisObject, [member])
			}
		}
		/**
		 * Creates a new set and populates with the the elements in another object.
		 * <p>
		 * If the other object is a <code>HashSet</code>, then using <code>clone()</code> is
		 * recommended.
		 * </p>
		 *
		 * @param value
		 * 		Object containing the items to add to the end of the list. Uses a <code>for each..in</code> loop to iterate over
		 * 		the members of <code>value</code>.
		 * 		Duplicated elements will be added only once.
		 * @return 
		 * 		A new <code>HashSet</code> instance with the same members as <code>value</code>.
		 * @throws ArgumentError
		 * 		<code>ArgumentError</code> - If <code>value</code> is a nonfinite collection.
		 * @see #clone()
		 * @see #createSingleton
		 * @see Collection
		 * @see FiniteCollection
		 */
		public static function fromObject(value:Object):HashSet
		{
			if (value is Collection && !(value is FiniteCollection))
				throw new ArgumentError("Cannot create a finite collection from a nonfinite collection: " + value);
			const hashSet:HashSet = new HashSet();
			hashSet.addMembers(value);
			return hashSet;
		}
		/**
		 * Allows the use of bracket notation to check membership. If <code>hashSet[x] == x</code>,
		 * then <code>x</code> is a member of the set. If <code>hashSet[x] == undefined</code>, then
		 * <code>x</code> is not a member.
		 * 
		 * @param name
		 * 		Element to look up.
		 * @return 
		 * 		A value of <code>undefined</code> if <code>name</code> is not a member. Returns
		 * 		<code>name</code> if <code>name</code> is a member.
		 */
		override flash_proxy function getProperty(name:*):*
		{
			if (hash[name] != undefined)
				return name;
			return undefined;
		}
		/**
		 * Checks if this set has a certain member.
		 *  
		 * @param element
		 * 		Element to check for.
		 * @return 
		 * 		A value of <code>true</code> if <code>element</code> is a member of this set;
		 * 		<code>false</code> otherwise.
		 */
		public function has(element:Object):Boolean
		{
			return hash[element] != undefined;
		}
		/**
		 * Checks if this set has a certain member.
		 *  
		 * @param name
		 * 		Element to check for.
		 * @return 
		 * 		A value of <code>true</code> if <code>element</code> is a member of this set;
		 * 		<code>false</code> otherwise.
		 */
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return hash[name] != undefined;
		}
		/**
		 * Returns the intersection of this set and another object.
		 *  
		 * @param value
		 * 		Object to calculate intersection with. May be a <code>HashSet</code>, an
		 * 		<code>Array</code>, a <code>Vector</code>, or any type of object which can be iterated over using
		 * 		<code>for each..in</code>. (This function is optimized for <code>HashSet</code>
		 * 		objects.)
		 * @return
		 * 		A set containing all elements that are members of this set and members of
		 * 		<code>value</code>. In some circumstances this function may simply return this set or
		 * 		<code>value</code>.
		 */
		public function intersect(value:Object):Set
		{
			if (value is Collection)
			{
				if (value.empty)
					return EmptySet.INSTANCE;
				if (value is HashSet)
				{
					if (value._size == 0)
						return value as HashSet;
					if (_size == 0)
						return this;
					const result:HashSet = new HashSet();
					for (var member:Object in hash)
					{
						if (value.hash[member] != undefined)
						{
							result.hash[member] = member;
							++result._size;
						}
					}
					return result;
				}
			}
			return fromObject(value).intersect(this);
		}
		/**
		 * Converts a finite collection into a mutable set.
		 *  
		 * @param value
		 * 		A finite collection.
		 * @return 
		 * 		If <code>value</code> already is a mutable set, returns <code>value</code>. Otherwise creates a new
		 * 		<code>HashSet</code> instance with the same members as <code>value</code>.
		 */
		public static function makeMutable(value:FiniteCollection):MutableSet
		{
			if (value is MutableSet)
				return value as MutableSet;
			return fromObject(value.toVector());
		}
		/**
		 * Executes a function on each member of this set, and constructs a new set of elements corresponding to the
		 * results of the function on each member of the original set. 
		 * 
		 * @param mapper
		 * 		The function to run on each member of the set. Must take a single argument and return something.
		 * 		If it returns <code>undefined</code>, that result is not added to the new set.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the test function.
		 * @return 
		 * 		New set containing all mapped elements.
		 */
		public function map(mapper:Function, thisObject:* = null):FiniteCollection
		{
			const mapped:HashSet = new HashSet();
			for each (var member:Object in hash)
			{
				var mappedMember:* = mapper.apply(thisObject, [member]);
				if (mappedMember != undefined)
					mapped.add(mappedMember);
			}
			return mapped._size == 0 ? EmptySet.INSTANCE : mapped;
		}
		/**
		 * Tells whether this is a proper subset (that is, a subset that is not identical)
		 * of another object.
		 * <p>
		 * Empty sets are considered subsets of all nonempty sets.
		 * </p>
		 * 
		 * @param value
		 * 		Set to check against. Optimized for <code>HashSet</code> objects, but can use any type
		 * 		of object whose elements can be iterated over using <code>for each..in</code>.
		 * @return 
		 * 		A value of <code>true</code> if this set is a subset of <code>value</code> and not
		 * 		identical to it; <code>false</code> otherwise.
		 * @see #equals()
		 * @see #subsetOf()
		 */
		public function prSubsetOf(value:Object):Boolean
		{
			if (value is HashSet)
			{
				if (value._size == 0)
					return false;
				if (_size == 0)
					return value._size != 0;
				if (_size >= value._size)
					return false;
				for each (var member:Object in hash)
				{
					if (value.hash[member] != member)
						return false;
				}
				return true;
			}
			return prSubsetOf(fromObject(value));
		}
		/**
		 * @inheritDoc
		 */		
		public function remove(element:Object):void
		{
			if (hash[element] != undefined)
			{
				delete hash[element];
				--_size;
			}
		}
		/**
		 * @inheritDoc
		 */		
		public function removeMembers(value:Object):void
		{
			for each (var member:Object in value)
			{
				remove(member);
			}
		}
		/**
		 * Allows members to be added or removed using bracket notation.
		 * <p>
		 * This is equivalent to <code>hashSet.add(x)</code>: <code>hashSet[x] = x;</code>
		 * </p>
		 * <p>
		 * This is equivalent to <code>hashSet.remove(x)</code>: <code>hashSet[x] = undefined;</code>
		 * </p>
		 * 
		 * @param name
		 * 		Member to set the value of.
		 * @param value
		 * 		A value of <code>undefined</code> to remove the member, or <code>name</code> to
		 * 		add it. If <code>value</code> is anything else, this function throws an error.
		 * @throws ArgumentError
		 * 		If <code>value</code> is not <code>undefined</code> or the same as <code>name</code>.
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			if (value == this)
				throw new IllegalOperationError("Collection cannot be a member of itself.");
			if (name == undefined)
				return;
			if (value == undefined)
				remove(name as Object);
			if (name != value)
				throw new ArgumentError("Improper usage of bracket notation to add a set member. Try HashSet.add() instead.");
			add(name as Object);
		}
		/**
		 * Checks whether at least one member of the set satisfies a criterion.
		 * <p>
		 * If this set is empty, this will always return <code>false</code>.
		 * <p>
		 * 
		 * @param test
		 * 		The criterion to test for. Must take a single argument and return a
		 * 		<code>Boolean</code> value.
		 * @param thisObject
		 * 		An object to use as <code>this</code> for the test function.
		 * @return 
		 * 		A value of <code>true</code> is at least one member causes <code>test</code> to return
		 * 		<code>true</code>; <code>false</code> otherwise.
		 * @see #forAll()
		 * @see #empty
		 */
		public function some(test:Function, thisObject:* = null):Boolean
		{
			for (var member:Object in hash)
			{
				if (test.apply(thisObject, [member]))
					return true;
			}
			return false;
		}
		/**
		 * Tells whether this is a subset of another set.
		 * <p>
		 * Identical sets are considered subsets of each other. Empty sets are subsets of all other
		 * sets.
		 * </p>
		 * 
		 * @param value
		 * 		Set to check against. Optimized for <code>HashSet</code> objects, but can use any type
		 * 		of object whose elements can be iterated over using <code>for each..in</code>.
		 * @return 
		 * 		A value of <code>true</code> if this set is a subset of <code>value</code>;
		 * 		<code>false</code> otherwise.
		 * @see #equals()
		 * @see #prSubsetOf()
		 */
		public function subsetOf(value:Object):Boolean
		{
			if (value is HashSet)
			{
				if (this == value)
					return true;
				if (_size == 0)
					return true;
				if (value._size == 0)
					return false;
				for (var member:Object in hash)
				{
					if (value.hash[member] == undefined)
						return false;
				}
				return true;
			}
			return subsetOf(fromObject(value));
		}
		/**
		 * Converts this set into an array with the same membership.
		 *  
		 * @return 
		 * 		A new <code>Array</code> instance.
		 */
		public function toArray():Array
		{
			const array:Array = new Array(_size);
			var i:uint = 0;
			for each (var member:Object in hash)
				array[i++] = member;
			return array;
		}
		/**
		 * @inheritDoc 
		 */
		public final function toString():String
		{
			return "{" + toVector().join(", ") + "}";
		}
		/**
		 * Converts this set into a vector with the same membership.
		 *  
		 * @return 
		 * 		A new <code>Vector.&lt;Object&gt;</code> instance.
		 */
		override public function toVector():Vector.<Object>
		{
			const v:Vector.<Object> = new Vector.<Object>(_size);
			var i:uint = 0;
			for each (var member:Object in hash)
				v[i++] = member;
			return v;
		}
		/**
		 * Returns the union of this set and another set.
		 *  
		 * @param value
		 * 		Set to calculate union with. Optimized for <code>HashSet</code> objects, but can use any type
		 * 		of object whose elements can be iterated over using <code>for each..in</code>.
		 * @return
		 * 		A set containing all elements that are members of this set or members of
		 * 		<code>value</code>. In some circumstances this function may simply return this set or
		 * 		<code>value</code>.
		 */
		public function union(value:Object):Set
		{
			if (value is HashSet)
			{
				if (value._size == 0 || value == this)
					return this;
				if (_size == 0)
					return value as HashSet;
				const result:HashSet = clone(this);
				for each (var member:Object in value)
				{
					if (result.hash[member] == undefined)
					{
						result.hash[member] = member;
						++result._size;
					}
				}
				return result;
			}
			return union(fromObject(value));
		}
	}
}