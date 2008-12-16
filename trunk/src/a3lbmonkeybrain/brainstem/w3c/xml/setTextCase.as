package a3lbmonkeybrain.brainstem.w3c.xml
{
	public function setTextCase(x:*, upper:Boolean = true, locale:Boolean = true):void
	{
		var child:XML;
		if (x is XML)
		{
			const xml:XML = x as XML;
			const n:int = xml.children().length();
			if (n == 0)
				return;
			XML.ignoreWhitespace = false;
			XML.prettyPrinting = false;
			for (var i:int = 0; i < n; ++i)
			{
				child = xml.children()[i];
				switch (child.nodeKind())
				{
					case XMLNodeKind.ELEMENT :
					{
						setTextCase(child, upper, locale);
						break;
					}
					case XMLNodeKind.TEXT :
					{
						xml.children()[i] = upper
							? (locale ? child.toXMLString().toLocaleUpperCase() : child.toXMLString().toUpperCase())
							: (locale ? child.toXMLString().toLocaleLowerCase() : child.toXMLString().toLowerCase());
						break;
					}
				}
			}
		}
		else if (x is XMLList)
		{
			for each (child in x)
			{
				setTextCase(child, upper, locale);
			}
		}
		else
		{
			throw new ArgumentError("Not an XML or XMLList object: " + xml);
		}
	}
}
