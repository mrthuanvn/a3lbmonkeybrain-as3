package a3lbmonkeybrain.brainstem.w3c.xml
{
	public final class XMLNodeKind
	{
		/**
		 * Value of <code>XML.nodeKind()</code> for attributes.
		 * 
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/XML.html#nodeKind() XML.nodeKind()
		 */
		public static const ATTRIBUTE:String = "attribute";
		/**
		 * Value of <code>XML.nodeKind()</code> for comments.
		 * 
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/XML.html#nodeKind() XML.nodeKind()
		 */
 	 	public static const COMMENT:String = "comment";
		/**
		 * Value of <code>XML.nodeKind()</code> for elements.
		 * 
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/XML.html#nodeKind() XML.nodeKind()
		 */
 	 	public static const ELEMENT:String = "element";
		/**
		 * Value of <code>XML.nodeKind()</code> for processing instructions.
		 * 
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/XML.html#nodeKind() XML.nodeKind()
		 */
 	 	public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
		/**
		 * Value of <code>XML.nodeKind()</code> for text.
		 * 
		 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/XML.html#nodeKind() XML.nodeKind()
		 */
 	 	public static const TEXT:String = "text";
 	 	/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function XMLNodeKind()
		{
			throw new TypeError();
		}
	}
}