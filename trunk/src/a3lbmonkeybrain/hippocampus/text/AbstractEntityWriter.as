package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	import a3lbmonkeybrain.brainstem.w3c.xml.extractText;
	import a3lbmonkeybrain.brainstem.w3c.xml.setTextCase;
	
	public class AbstractEntityWriter implements EntityWriter
	{
		public function AbstractEntityWriter()
		{
			super();
		}
		public function get entityClass():Class
		{
			throw new AbstractMethodError();
		}
		public function writeHTML(value:Object):XML
		{
			throw new AbstractMethodError();
		}
		public function writeText(value:Object, format:String = "text"):String
		{
			const xml:XML = writeHTML(value);
			if (xml == null)
				return "";
			XML.ignoreWhitespace = false;
			XML.prettyPrinting = false;
			if (format == Format.HTML_TEXT)
				return xml.toXMLString();
			setTextCase(xml..i);
			return extractText(xml);
		}
	}
}