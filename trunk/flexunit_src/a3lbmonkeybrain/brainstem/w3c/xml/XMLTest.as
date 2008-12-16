package a3lbmonkeybrain.brainstem.w3c.xml
{
	import a3lbmonkeybrain.brainstem.w3c.xml.extractText;
	
	import flexunit.framework.TestCase;
	
	/**
	 * @private
	 */
	public final class XMLTest extends TestCase
	{
		public function testAppendAsChildren():void
		{
			var xml:XML = <root/>;
			var parent:XML = <parent><child name = "1"/><child name = "2">text</child></parent>;
			appendAsChildren(xml, parent.children());
			assertEquals(xml.children().length(), 2);
			assertEquals(xml.children()[0].name(), "child");
			assertEquals(xml.children()[0].@name, "1");
			assertEquals(xml.children()[1].name(), "child");
			assertEquals(xml.children()[1].@name, "2");
			assertEquals(xml.children()[1].text(), "text");
			assertEquals(xml.children()[1].children().length(), 1);
		}
		public function testDeleteNonElements():void
		{
			XML.prettyPrinting = false;
			const xml:XML = <parent><child/>text<child>text</child><?instruction?><!--comment--></parent>;
			deleteNonElements(xml);
			assertEquals("<parent><child/><child/></parent>", xml.toXMLString());
		}
		public function testExtractText():void
		{
			XML.ignoreWhitespace = false;
			var xml:XML;
			xml = <p>Hello, world!</p>;
			assertEquals(extractText(xml.children()), "Hello, world!");
			assertEquals(extractText(xml), "Hello, world!");
			xml = <list><item>Hello</item>, <item>world</item>!</list>;
			assertEquals(extractText(xml.children()), "Hello, world!");
			assertEquals(extractText(xml), "Hello, world!");
			xml = <list><item>Hel<empty/>lo</item>, <item>wo<r>r</r>ld</item>!</list>;
			assertEquals(extractText(xml.children()), "Hello, world!");
			assertEquals(extractText(xml), "Hello, world!");
		}
		public function testRemoveFirst():void
		{
			var xml:XML = <apply><sin/><cn>0</cn></apply>;
			var list:XMLList = removeFirst(xml.children());
			assertEquals(list.length(), 1);
			assertEquals(list[0].name(), "cn");
			assertEquals(list[0].text(), "0");
			list = removeFirst(xml.children(), 2);
			assertEquals(list.length(), 0);
			list = removeFirst(xml.children(), 3);
			assertEquals(list.length(), 0);
			list = removeFirst(xml.children(), 0);
			assertEquals(list.length(), 2);
		}
		public function testRemoveLast():void
		{
			var xml:XML = <apply><sin/><cn>0</cn></apply>;
			var list:XMLList = removeLast(xml.children());
			assertEquals(list.length(), 1);
			assertEquals(list[0].name(), "sin");
			assertEquals(list[0].children().length(), 0);
			list = removeLast(xml.children(), 2);
			assertEquals(list.length(), 0);
			list = removeLast(xml.children(), 3);
			assertEquals(list.length(), 0);
			list = removeLast(xml.children(), 0);
			assertEquals(list.length(), 2);
		}
	}
}