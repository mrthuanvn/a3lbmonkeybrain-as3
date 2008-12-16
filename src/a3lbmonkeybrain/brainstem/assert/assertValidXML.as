package a3lbmonkeybrain.brainstem.assert
{
	/**
	 * Asserts that a string value represents valid XML.
	 *  
	 * @param value
	 * 		String.
	 * @throws a3lbmonkeybrain.brainstem.assert.AssertionError
	 * 		<code>AssertionError</code>: If <code>value</code> is empty (<code>&quot;quot;</code>).
	 * @throws TypeError
	 * 		<code>TypeError</code>: If <code>value</code> is <code>null</code> or not valid XML.
	 * @see	XML
	 * @see AssertionError
	 * @see TypeError
	 */
	public function assertValidXML(value:String):void
	{
		assertNotEmpty(value);
		new XML(value);
	}
}
