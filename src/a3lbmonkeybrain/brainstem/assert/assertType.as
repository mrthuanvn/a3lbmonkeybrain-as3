package a3lbmonkeybrain.brainstem.assert
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Assert that a value is of a certain class or interface.
	 *  
	 * @param value
	 * 		Object.
	 * @param assertedClass
	 * 		Class or interface.
	 * @throws TypeError
	 * 		<code>TypeError</code>: If <code>value</code> is not of the specified class or interface.
	 * @see TypeError
	 */
	public function assertType(value:Object, assertedClass:Class):void
	{
		if (!(value is assertedClass))
		{
			try
			{
				var message:String = "Value is not of class " + getQualifiedClassName(assertedClass) + ": "
					+ value;
			}
			catch (e:Error)
			{
				message = "Value is not of the correct class.";
			}
			throw new TypeError(message);
		}
	}
}
