package a3lbmonkeybrain.brainstem.assert
{
	import a3lbmonkeybrain.brainstem.relate.Equatable;
	
	/**
	 * Asserts that two objects are equal.
	 * 
	 * @param a
	 * 		An object to comapre.
	 * @param b
	 * 		An object to comapre.
	 * @param useEquatables
	 * 		If set to <code>true</code> and either <code>a</code> or <code>b</code> implement
	 * 		<code>Equatable</code>, then this method may use <code>Equatable.equals</code> to determine equality.
	 * @throws a3lbmonkeybrain.brainstem.assert.AssertionError
	 * 		<code>AssertionError</code>: If <code>a</code> and <code>b</code> are not equal.
	 * @see	a3lbmonkeybrain.relate.Equatable
	 * @see	a3lbmonkeybrain.relate.Equatable#equals()
	 * @see AssertionError
	 */
	public function assertEqual(a:Object, b:Object, useEquatables:Boolean = false):void
	{
		if (a == b)
			return;
		if (useEquatables)
		{
			if (a is Equatable)
			{
				if (Equatable(a).equals(b))
					return;
			}
			else if (b is Equatable)
			{
				if (Equatable(b).equals(a))
					return;
			}
		}
		try
		{
			var message:String = "Values are not equal: " + a + ", " + b;
		}
		catch (e:Error)
		{
			message = "Values are not equal.";
		}
		throw new AssertionError(message);
	}
}