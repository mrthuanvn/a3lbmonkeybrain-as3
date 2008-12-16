package a3lbmonkeybrain.brainstem.relate
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.core.Property;
	
	/**
	 * Static class with utilities for determing qualitative equality.
	 * 
	 * @author T. Michael Keesey
	 */
	public final class Equality
	{
		private static const arrayStack:ComparisonStack = new ComparisonStack();
		private static const stack:ComparisonStack = new ComparisonStack();
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function Equality()
		{
			throw new TypeError();
		}
		/**
		 * Searches through an array for a specified member.
		 * 
		 * @param array
		 * 		Array to search.
		 * @param item
		 * 		Object to search for.
		 * @param properties
		 * 		List of properties to use for comparison. If set to <code>null</code>, this is not used. If
		 * 		<code>properties</code> is a nonempty array, then <code>useEquatables</code> will be ignored for
		 * 		comparing <code>item</code> and elements of <code>array</code>, but may be used when comparing their
		 * 		properties. If set to <code>Property.AUTO_PROPERTIES</code>, then this will automatically choose all
		 * 		shared properties (that is, properties which are present in both objects). If there are none, then this
		 * 		method will behave as if <code>properties</code> were set to <code>null</code>.
		 * @param useEquatables
		 * 		If <code>true</code> and either <code>item</code> or some member of <code>array</code> implements
		 * 		<code>Equatable</code>, then this method may use <code>Equatable.equals</code> to determine equality.
		 * @param useArraysEqual
		 * 		If <code>true</code> and either <code>item</code> or some member of <code>array</code> is an array or
		 * 		an <code>IList</code> object, then this method may use <code>arraysEqual()</code>.
		 * @return
		 * 		A value of <code>true</code> if some member of <code>array</code> is equal to <code>item</code>;
		 * 		<code>false</code> if not.
		 * @see	#arraysEqual()
		 * @see	#equal()
		 * @see	Equatable#equals()
		 */
		public static function arrayContains(array:Array, item:Object, properties:Array = null,
			useEquatables:Boolean = true, useArraysEqual:Boolean = true):Boolean
		{
			if (array == null)
				return false;
			for each (var object:Object in array)
			{
				if (equal(object as Object, item, properties, useEquatables, useArraysEqual))
					return true;
			}
			return false;
		}
		/**
		 * Compares two arrays to see if they have equal content.
		 * 
		 * @param a
		 * 		Array to compare.
		 * @param b
		 * 		Array to compare.
		 * @param useEquatables
		 * 		If <code>true</code> and either array includes any <code>Equatable</code> objects, this method may
		 * 		use <code>Equatable.equals</code> to determine equality.
		 * @param useArraysEqual
		 * 		If set to <code>true</code> and both <code>a</code> and <code>b</code> are arrays, then this method may
		 * 		use <code>arraysEqual()</code> for elements.
		 * @return
		 * 		A Boolean value telling whether the arrays have equal content.
		 * @see	Equatable
		 * @see	Equatable#equals()
		 */
		public static function arraysEqual(a:Array, b:Array, useEquatables:Boolean = true, useArraysEqual:Boolean =
			true):Boolean
		{
			if (a === b)
				return true;
			const n:int = a.length;
			if (n != b.length)
				return false;
			if (n)
			{
				if (arrayStack.contains(a, b))
				{
					trace("WARNING: Recursion in comparison (Equality.arraysEqual): " + a + " ?= " + b);
					return false;
				}
				arrayStack.add(a, b);
				for (var i:int = 0; i < n; ++i)
				{
					if (!equal(a[i], b[i], null, useEquatables, useArraysEqual))
					{
						arrayStack.remove(a, b);
						return false;
					}
				}
				arrayStack.remove(a, b);
			}
			return true;
		}
		/**
		 * Compares two objects to determine if they are equal.
		 * 
		 * @param a
		 * 		Object to compare.
		 * @param b
		 * 		Object to compare.
		 * @param properties
		 * 		List of properties to use for comparison. If set to <code>null</code>, this is not used. If
		 * 		<code>properties</code> is a nonempty array, then <code>useEquatables</code> will be ignored for
		 * 		comparing <code>a</code> and <code>b</code>, but may be used when comparing their properties. If set to
		 * 		<code>Property.AUTO_PROPERTIES</code>, then this will automatically choose all shared properties
		 * 		(that is, properties which are present in both objects). If there are none, then this method will
		 * 		behave as if <code>properties</code> were set to <code>null</code>.
		 * @param useEquatables
		 * 		If <code>true</code> and both arguments are arrays, at least one of which includes one or more
		 * 		<code>Equatable</code> members, this method may use <code>Equatable.equals</code> to determine equality.
		 * @param useArraysEqual
		 * 		If set to <code>true</code> and both <code>a</code> and <code>b</code> are arrays or <code>IList</code>
		 * 		objects, then this method may use <code>arraysEqual()</code> for elements.
		 * @return
		 * 		A Boolean value.
		 * @see	#arraysEqual()
		 * @see Array
		 * @see	Equatable
		 * @see	Equatable#equals()
		 * @see	mx.collections.IList
		 * @see	mx.collections.IList#toArray()
		 * @see	a3lbmonkeybrain.core.Property#AUTO_PROPERTIES
		 */
		public static function equal(a:Object, b:Object, properties:Array = null, useEquatables:Boolean = true,
			useArraysEqual:Boolean = true):Boolean
		{
			if (a == null && b == null)
				return true;
			if (a == b)
				return true;
			if (a == null || b == null)
				return false;
			if (a is Number)
			{
				if (isNaN(a as Number))
					return false;
				if (b is Number)
					return false;
			}
			else if (b is Number)
			{
				if (isNaN(b as Number))
					return false;
			}
			else if ((a is XML && b is XML) || (a is XMLList && b is XMLList))
			{
				return a.toXMLString() == b.toXMLString();
			}
			const autoProperties:Boolean = properties == Property.AUTO_PROPERTIES;
			if (autoProperties)
				properties = Property.findSharedPropertyNames(a, b);
			const useProperties:Boolean = properties != null && properties.length >= 1;
			if (useProperties || useEquatables || useArraysEqual)
			{
				if (stack.contains(a, b))
				{
					trace("WARNING: Recursion in comparison (Equality.equal): " + a + " ?= " + b);
					return false;
				}
				stack.add(a, b);
				if (useProperties)
				{
					const n:int = properties.length;
					for (var i:int = 0; i < n; ++i)
					{
						const field:* = properties[i]; 
						if (field is String && a.hasOwnProperty(field as String) && b.hasOwnProperty(field as String))
						{
							if (!equal(a[field as String], b[field as String], autoProperties ?
								Property.AUTO_PROPERTIES : null, useEquatables, useArraysEqual))
							{
								stack.remove(a, b);
								return false;
							}
						}
					}
					stack.remove(a, b);
					return true;
				}
				if (useEquatables)
				{
					if (a is Equatable)
					{
						stack.remove(a, b);
						return a.equals(b);
					}
					if (b is Equatable)
					{
						stack.remove(a, b);
						return b.equals(a);
					}
				}
				if (useArraysEqual && (a is Array || a is FiniteList) && (b is Array || b is FiniteList))
				{
					var aArray:Array;
					var bArray:Array;
					if (a is FiniteList)
						aArray = FiniteList(a).toArray();
					else
						aArray = a as Array;
					if (b is FiniteList)
						bArray = FiniteList(b).toArray();
					else
						bArray = b as Array;
					if (aArray is Array && bArray is Array)
					{
						const e:Boolean = arraysEqual(aArray, bArray, useEquatables);
						stack.remove(a, b);
						return e;
					}
				}
				stack.remove(a, b);
			}
			if (isValueOfType(a))
			{
				if (isValueOfType(b))
					return a.valueOf() == b.valueOf();
				return a.valueOf() == b;
			}
			if (isValueOfType(b))
				return b.valueOf() == a;
			return false;
		}
	}
}