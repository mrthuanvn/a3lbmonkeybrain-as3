package a3lbmonkeybrain.brainstem.w3c.xml
{
	/**
	 * Removes a number of elements from the beginning of an XML list.
	 *  
	 * @param list
	 * 		XML list to remove elements from. This object is not modified.
	 * @param amount
	 * 		The number of elements to remove from the beginning of the list.
	 * @return 
	 * 		A modified XML list with elements removed. If <code>list</code> is <code>null</code> or if
	 * 		<code>list</code> has <code>amount</code> elements or less, the result will be an empty list.
	 */
	public function removeFirst(list:XMLList, amount:uint = 1):XMLList
	{
		const xml:XML = <xml/>;
		if (list != null)
		{
			const n:int = list.length();
			for (var i:int = amount; i < n; ++i)
			{
				xml.appendChild(list[i].copy());
			}
		}
		return xml.children();
	}
}
