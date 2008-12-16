package a3lbmonkeybrain.brainstem.relate
{
	/**
	 * Interface for an object which can sort itself in relation to other objects in terms of linear
	 * precedence/succession (that is, an order relation).
	 * 
	 * @author T. Michael Keesey
	 * @see	Order
	 * @see	a3lbmonkeybrain.brainstem.assert.Assertion#equal()
	 */
	public interface Ordered extends Equatable
	{
		/**
		 * Compares this object to another one to determine their relative linear positions.
		 * <p>
		 * If <code>this.findOrder(x) == 0</code>, then <code>this.equals(x)</code> may be <code>true</code> (or there
		 * may simply be no point of comparison). Conversely, if <code>this.equals(x)</code> is <code>false</code>, then
		 * <code>this.findOrder(x)</code> must not be 0.
		 * </p>
		 * 
		 * @param value
		 * 		Value to compare to this object.
		 * @return
		 * 		A negative value if this object precedes <code>value</code>, a positive value if this object succeeds
		 * 		<code>value</code>, or <code>0</code> if both are equivalent or if there is no way to compare.
		 * @see	Equatable#equals()
		 */
		function findOrder(value:Object):int;
	}
}