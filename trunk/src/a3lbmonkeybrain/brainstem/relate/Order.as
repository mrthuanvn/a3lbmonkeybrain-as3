package a3lbmonkeybrain.brainstem.relate
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.core.Property;
	
	/**
	 * Static class with utilities for object comparison.
	 * 
	 * @author T. Michael Keesey
	 */
	public final class Order
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
		public function Order()
		{
			throw new TypeError();
		}
		/**
		 * Compares two objects to determine their relation in a linear order.
		 * <p>
		 * The null value (<code>null</code>) always precedes objects.
		 * </p>
		 * 
		 * @param a
		 * 		Object to compare.
		 * @param b
		 * 		Object to compare.
		 * @param properties
		 * 		List of properties to use for comparison. If set to <code>null</code>, this is not used. If
		 * 		<code>properties</code> is a nonempty array, then <code>useOrdereds</code> will be ignored for
		 * 		comparing <code>a</code> and <code>b</code>, but will be used when comparing their properties. If set to
		 * 		<code>Property.AUTO_PROPERTIES</code>, then this will automatically choose all shared properties (that
		 * 		is, properties which are present in both objects). If there are none, then this method will behave as
		 * 		if <code>properties</code> were set to <code>null</code>.
		 * @param useOrdereds
		 * 		If set to <code>true</code> and either <code>a</code> or <code>b</code> implement <code>Ordered</code>,
		 * 		then this method may use <code>Ordered.findOrder()</code> to determine order.
		 * @param useFindOrderOfArrays
		 * 		If set to <code>true</code> and both <code>a</code> and <code>b</code> are arrays or <code>FiniteList</code>
		 * 		objects, then this method may use <code>findOrderOfArrays()</code>.
		 * @return
		 * 		A negative value if <code>a</code> precedes <code>b</code>, a positive value if <code>a</code> succeeds
		 * 		<code>b</code>, or <code>0</code> if both are equal or incomparable.
		 * @see	#findOrderOfArrays()
		 * @see	Ordered
		 * @see	Ordered#findOrder()
		 * @see	mx.collections.FiniteList
		 * @see	mx.collections.FiniteList#toArray()
		 * @see	a3lbmonkeybrain.core.Property#AUTO_PROPERTIES
		 */
		public static function findOrder(a:Object, b:Object, properties:Array = null, useOrdereds:Boolean = true,
			useFindOrderOfArrays:Boolean = true):int
		{
			if (a === null && b === null)
				return 0;
			if (a === null)
				return -1;
			if (b === null)
				return 1;
			if (a == b)
				return 0;
			const autoProperties:Boolean = properties === Property.AUTO_PROPERTIES;
			if (autoProperties)
				properties = Property.findSharedPropertyNames(a, b);
			const useProperties:Boolean = properties != null && properties.length >= 1;
			if (useProperties || useOrdereds || useFindOrderOfArrays)
			{
				if (stack.contains(a, b))
				{
					trace("WARNING: Recursion in comparison (Order.findOrder): " + a + " <=> " + b);
					return 0;
				}
				stack.add(a, b);
				if (useProperties)
				{
					const n:int = properties.length;
					for (var i:int = 0; i < n; ++i) {
						const propertyName:* = properties[i]; 
						if (propertyName is String && a.hasOwnProperty(propertyName as String)
							&& b.hasOwnProperty(propertyName as String))
						{
							const aProperty:Object = a[propertyName as String];
							const bProperty:Object = b[propertyName as String];
							const c:int = findOrder(aProperty, bProperty, autoProperties ? Property.AUTO_PROPERTIES :
								null, useOrdereds, useFindOrderOfArrays);
							if (c != 0)
							{
								stack.remove(a, b);
								return c;
							}
						}
					}
				}
				if (useOrdereds)
				{
					if (a is Ordered)
					{
						stack.remove(a, b);
						return Ordered(a).findOrder(b);
					}
					if (b is Ordered)
					{
						stack.remove(a, b);
						return Ordered(b).findOrder(a) * -1;
					}
				}
				if (useFindOrderOfArrays)
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
						const d:int = findOrderOfArrays(aArray, bArray, useOrdereds);
						stack.remove(a, b);
						return d;
					}
				}
				stack.remove(a, b);
			}
			if (isValueOfType(a))
			{
				if (isValueOfType(b))
					return findOrder(a.valueOf(), b.valueOf(), null, false, false);
				return findOrder(a.valueOf(), b, null, false, false);
			}
			if (isValueOfType(b))
				return findOrder(a, b.valueOf(), null, false, false);
			return (a < b) ? -1 : ((b < a) ? 1 : 0);
		}
		/**
		 * Compares two arrays to determine their relation in a linear order.
		 * 
		 * @param a
		 * 		Array to compare.
		 * @param b
		 * 		Array to compare
		 * @param useOrdereds
		 * 		If <code>true</code> and either array includes any <code>Ordered</code> objects, this method may use
		 * 		<code>Ordered.findOrder</code> to determine order.
		 * @return
		 * 		A negative value if <code>a</code> precedes <code>b</code>, a positive value if <code>a</code>
		 * 		succeeds <code>b</code>, or <code>0</code> if both are equal.
		 */
		public static function findOrderOfArrays(a:Array, b:Array, useOrdereds:Boolean = true):int
		{
			if (a == b)
				return 0;
			if (a == null)
				return -1;
			if (b == null)
				return 1;
			const n:int = a.length > b.length ? b.length : a.length;
			if (n)
			{
				if (arrayStack.contains(a, b))
				{
					trace("WARNING: Recursion in comparison (Order.findOrderOfArrays): " + a + " <=> " + b);
					return 0;
				}
				arrayStack.add(a, b);
				for (var i:int = 0; i < n; ++i)
				{
					var c:int = findOrder(a[i], b[i], null, useOrdereds, true);
					if (c != 0)
					{
						arrayStack.remove(a, b);
						return c;
					}
				}
				arrayStack.remove(a, b);
				if (a.length == b.length)
					return 0;
				if (a.length)
					return -1;
				return 1;
			}
			return a.length ? 1 : (b.length ? -1 : 0);
		}
	}
}