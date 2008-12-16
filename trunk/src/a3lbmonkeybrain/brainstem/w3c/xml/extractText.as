package a3lbmonkeybrain.brainstem.w3c.xml
{
	/**
	 * Extracts all text nodes in an <code>XML</code> node and concatenates them into one string.
	 * <p>
	 * Examples:
	 * </p>
	 * <table class="innertable">
	 * 	<tr>
	 * 		<th>Input</th>
	 * 		<th>Output</th>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><pre>&lt;p&gt;Hello, &lt;b&gt;world&lt;/b&gt;!</p&gt;</pre></td>
	 * 		<td><code>&quot;Hello, world!&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><pre>&lt;a href=&quot;about:blank&quot;&gt;Empty Link&lt;/a&gt;</pre></td>
	 * 		<td><code>&quot;Empty Link&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><pre>&lt;emptyTag/&gt;</pre></td>
	 * 		<td><code>&quot;&quot;</code></td>
	 * 	</tr>
	 * 	<tr>
	 * 		<td><pre>&lt;tag&gt;&lt;tag attr=&quot;No text&quot;/&gt;&lt;/tag&gt;</pre></td>
	 * 		<td><code>&quot;&quot;</code></td>
	 * 	</tr>
	 * </table>
	 * 
	 * @param x
	 * 		XML object or XML list.
	 * @return 
	 * 		If <code>XML</code> is a text node, returns it as a string. If it is an element node or a list, returns all
	 * 		of its descendant text nodes concatenated into a string. Otherwise, returns an empty string
	 * 		(<code>&quot;&quot;</code>).
	 * @throws ArgumentError
	 * 		If <code>x</code> is not an <code>XML</code> or <code>XMLList</code> object.
	 */
	public function extractText(x:*):String
	{
		XML.ignoreWhitespace = false;
		XML.prettyPrinting = false;
		if (x is XML)
		{
			switch (x.nodeKind())
			{
				case XMLNodeKind.ELEMENT :
				{
					return extractText(x.children());
				}
				case XMLNodeKind.TEXT :
				{
					return x.toXMLString();
				}
				default :
				{
					return "";
				}
			}
		}
		else if (x is XMLList)
		{
			var text:String = "";
			for each (var child:XML in x)
			{
				text += extractText(child);
			}
			return text;
		}
		else
		{
			throw new ArgumentError("Not an XML or XMLList object: " + x);
		}
	}
}
