package a3lbmonkeybrain.brainstem.assert
{
	/**
	 * Makes a basic assertion.
	 *  
	 * @param value
	 * 		Value to assert.
	 * @param message
	 * 		Message to use in any error thrown.
	 * @throws a3lbmonkeybrain.brainstem.assert.AssertionError
	 * 		<code>AssertionError</code>: If <code>value</code> does not evaluate as <code>true</code>.
	 * @see AssertionError
	 */		
	public function assert(value:*, message:String = null):void
	{
		if (value)
			return;
		throw new AssertionError((message == null) ? "Failed assertion." : message);
	}
}