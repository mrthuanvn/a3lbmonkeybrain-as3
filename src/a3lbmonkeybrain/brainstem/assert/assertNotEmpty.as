package a3lbmonkeybrain.brainstem.assert
{
	/**
	 * Asserts that a string value is not <code>null</code> or empty (<code>""</code>).
	 *  
	 * @param value
	 * 		String.
	 * @param message
	 * 		Message to use in any error thrown.
	 * @throws a3lbmonkeybrain.brainstem.assert.AssertionError
	 * 		<code>AssertionError</code>: If <code>value</code> empty (<code>""</code>).
	 * @throws TypeError
	 * 		<code>TypeError</code>: If <code>value</code> is <code>null</code>.
	 * @see AssertionError
	 * @see TypeError
	 */
	public function assertNotEmpty(value:String, message:String = null):void
	{
		assertNotNull(value, message);
		if (value.length == 0)
			throw new AssertionError((message == null) ? "Value is empty." : message);
	}
}