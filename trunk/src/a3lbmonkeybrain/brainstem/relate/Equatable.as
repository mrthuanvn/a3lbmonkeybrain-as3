package a3lbmonkeybrain.brainstem.relate
{
	/**
	 * Interface for an object which can check if it is qualitatively equal to another object.
	 * 
	 * @author T. Michael Keesey
	 * @see Equality
	 * @see a3lbmonkeybrain.brainstem.assert.Assertion#equal()
	 */
	public interface Equatable
	{
		/**
		 * Checks if this is qualitatively equal to another object.
		 * <p>
		 * If <code>this == x</code> (i.e., if this object and <code>x</code> are identical), then
		 * <code>this.equals(x)</code> must return <code>true</code>.
		 * </p>
		 * 
		 * @param value
		 * 		Object to test for qualitative equality.
		 * @return
		 * 		A value of <code>true</code> if this object and <code>value</code> are qualitatively equal;
		 * 		<code>false</code> if not.
		 */
		function equals(value:Object):Boolean;
	}
}