package a3lbmonkeybrain.motorcortex.control
{
	/**
	 * Constants relating to chirality (handedness).
	 * 
	 * @author T. Michael Keesey
	 */
	public final class Chirality
	{
		/**
		 * Instance of this class for the left side. Has the following properties:
		 * <table class="innertable">
		 * <tr><th>Property</th>			<th>value</th></tr>
		 * <tr><td><code>name</code></td>	<td><code>&quot;left&quot;</code></td></tr>
		 * <tr><td><code>value</code></td>	<td><code>-1</code></td></tr>
		 * </table>
		 */
		public static const LEFT:Chirality = new Chirality(new Lock(), "left", -1);
		/**
		 * Instance of this class for the right side. Has the following properties:
		 * <table class="innertable">
		 * <tr><th>Property</th>			<th>value</th></tr>
		 * <tr><td><code>name</code></td>	<td><code>&quot;right&quot;</code></td></tr>
		 * <tr><td><code>value</code></td>	<td><code>1</code></td></tr>
		 * </table>
		 */
		public static const RIGHT:Chirality = new Chirality(new Lock(), "right", 1);
		/**
		 * @private 
		 */
		private var _name:String;
		/**
		 * @private 
		 */
		private var _value:int;
		/**
		 * Creates a new instance. Cannot be instantiated except by this class.
		 * 
		 * @param lock
		 * 		Object that ensures that only this class can create instances.
		 * @param name
		 * 		Name, retrievable as <code><i>chirality</i>.name</code>.
		 * @param value
		 * 		Value, retrievable as <code><i>chirality</i>.value</code>.
		 * @see	#LEFT
		 * @see	#RIGHT
		 * @see	#name
		 * @see	#value
		 */
		public function Chirality(lock:Lock, name:String, value:int)
		{
			super();
			if (lock == null)
				throw new TypeError("Invalid instance of Chirality.");
			_name = name;
			_value = value;
		}
		/**
		 * Name of this object (<code>&quot;left&quot;</code> or <code>&quot;right&quot;</code>).
		 */
		public function get name():String
		{
			return _name;
		}
		/**
		 * Integer of this object (-1 or 1).
		 * 
		 * @see	#valueOf()
		 */
		public function get value():int
		{
			return _value;
		}
		/**
		 * @inheritDoc 
		 */
		public function toString():String
		{
			return "[Chirality " + name + "]";
		}
		/**
		 * Returns the primitive value of this object.
		 *  
		 * @return 
		 * 		The same integer as <code>value</code>.
		 * @see	#value
		 */
		override public function valueOf():Object
		{
			return value;
		}
	}
}
class Lock {
}