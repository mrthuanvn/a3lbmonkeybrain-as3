package a3lbmonkeybrain.brainstem.resolve
{
	import a3lbmonkeybrain.brainstem.assert.assertNotNull;
	
	public final class UnresolvableXML implements Unresolvable
	{
		private var _xml:XML;
		public function UnresolvableXML(xml:XML):void
		{
			super();
			assertNotNull(xml);
			_xml = xml.copy();
		}
		public function get xml():XML
		{
			return _xml.copy();
		}
		public function toString():String
		{
			XML.prettyPrinting = false;
			return "[UnresolvableXML " + _xml.toXMLString() + "]";
		}
	}
}