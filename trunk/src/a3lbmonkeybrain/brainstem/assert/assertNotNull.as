package a3lbmonkeybrain.brainstem.assert
{
	/**
	 * Asserts that a value is not <code>null</code>.
	 *  
	 * @param value
	 * 		Object.
	 * @param message
	 * 		Message to use in any error thrown.
	 * @throws TypeError
	 * 		<code>TypeError</code>: If <code>value</code> is <code>null</code>.
	 * @see TypeError
	 */
	public function assertNotNull(value:Object, message:String = null):void
	{
		if (value == null)
			throw new TypeError((message == null) ? "Value is null." : message);
	}
}