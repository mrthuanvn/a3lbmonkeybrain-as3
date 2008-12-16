package a3lbmonkeybrain.brainstem.w3c.xml
{
	/**
	 * Appends copies of a list of XML nodes to a parent XML node.
	 * 
	 * @param xml
	 * 		Parent XML node to add children to. Must be an element.
	 * @param list
	 * 		List of children. Appends a copy of each <code>XML</code> node in this list as a child of
	 * 		<code>xml</code>.
	 * @return 
	 * 		The modified argument (<code>xml</code>).
	 * @throws ArgumentError
	 * 		If <code>xml</code> is not an XML element.
	 */
	public function appendAsChildren(xml:XML, list:XMLList):XML
	{
		if (xml == null || xml.nodeKind() != "element")
			throw new ArgumentError("Invalid argument: " + xml);
		const n:int = list.length();
		for (var i:int = 0; i < n; ++i)
		{
			xml.appendChild(list[i].copy());
		}
		return xml;
	}
}
