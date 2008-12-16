package a3lbmonkeybrain.brainstem.w3c.xml
{
	/**
	 * Deletes all descendant nodes of an XML element which are not elements.
	 * 
	 * @param xml
	 * 		XML element.
	 */
	public function deleteNonElements(xml:XML):void
	{
		for (var i:int = xml.children().length() - 1; i >= 0; --i)
		{
			if (xml.children()[i].nodeKind() == "element")
				deleteNonElements(xml.children()[i]);
			else
				delete xml.children()[i];
		}
	}
}
