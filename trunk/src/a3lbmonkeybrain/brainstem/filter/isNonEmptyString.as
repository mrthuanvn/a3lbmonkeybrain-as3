package a3lbmonkeybrain.brainstem.filter
{
	/**
	 * Checks if an object is a non-empty string.
	 *  
	 * @param item
	 * 		Object to check.
	 * @returns
	 * 		A value of <code>true</code> if <code>item</code> is a non-empty string.
	 */
	public function isNonEmptyString(item:Object):Boolean
	{
		return item is String && String(item).length > 0;
	}
}
