package a3lbmonkeybrain.visualcortex.xhtml
{
	public final class XHTMLUtil
	{
		private static function convertXML(html:XML, xhtml:XML):void
		{
			var newXHTML:XML;
			switch (html.nodeKind())
			{
				case "element" :
				{
					switch (html.name().toString())
					{
						case "A" :
						{
							if (html.hasOwnProperty("@HREF"))
							{
								newXHTML = <a target="_blank" style="text-decoration:underline;"/>;
								newXHTML.@href = html.@HREF;
							}
							else
							{
								newXHTML = xhtml;
							}
							break;
						}
						case "B" :
						{
							newXHTML = <span style="font-weight:bold;"/>;
							break;
						}
						case "FONT" :
						case "HTML" :
						case "TEXTFORMAT" :
						{
							newXHTML = xhtml;
							break;
						}
						case "I" :
						{
							newXHTML = <span style="font-style:italic;"/>;
							break;
						}
						case "LI" :
						{
							if (xhtml.name() != "ul")
							{
								newXHTML = <ul/>;
								xhtml.appendChild(newXHTML);
								xhtml = newXHTML;
							}
							newXHTML = <li/>;
							break;
						}
						case "P" :
						{
							convertXMLList(html.children(), xhtml);
							xhtml.appendChild(<br/>);
							xhtml.appendChild("\t");
							return;
						}
						case "U" :
						{
							newXHTML = <span style="text-decoration:underline;"/>;
							break;
						}
						case "UL" :
						{
							newXHTML = <ul/>;
							break;
						}
						default :
						{
							trace("WARNING: Unrecognized HTML tag: " + html.name());
							newXHTML = xhtml;
						}
					}
					convertXMLList(html.children(), newXHTML);
					if (newXHTML != xhtml)
						xhtml.appendChild(newXHTML);
					break;
				}
				case "text" :
				{
					xhtml.appendChild(html.toXMLString().replace(/\s+/, " "));
				}
			}
		}
		private static function convertXMLList(htmlList:XMLList, xhtml:XML):void
		{
			for each (var html:XML in htmlList)
			{
				convertXML(html, xhtml);
			}
		}
		public static function htmlTextToXHTML(htmlText:String):XML
		{
			XML.ignoreWhitespace = false;
			const html:XML = new XML(htmlText);
			const xhtml:XML = <span/>;
			convertXML(html, xhtml);
			return xhtml.normalize();
		}
	}
}