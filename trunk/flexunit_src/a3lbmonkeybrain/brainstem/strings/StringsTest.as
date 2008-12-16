package a3lbmonkeybrain.brainstem.strings
{
	import a3lbmonkeybrain.brainstem.assert.assert;
	
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class StringsTest extends TestCase
	{
		public function testCamelToSpaced():void
		{
			assertEquals(camelToSpaced(""), "");
			assertEquals(camelToSpaced("fooBar"), "foo Bar");
			assertEquals(camelToSpaced("URLUtil"), "URL Util");
			assertEquals(camelToSpaced("no caps"), "no caps");
		}	
		public function testCapitalize():void
		{
			assertEquals("Mike Keesey", capitalize("Mike Keesey"));
			assertEquals("Mike Keesey", capitalize("mike Keesey"));
			assertEquals("Mike Keesey", capitalize("mike keesey"));
			assertEquals("Mike Keesey", capitalize("Mike keesey"));
			assertEquals("Keesey", capitalize("Keesey"));
			assertEquals("Keesey", capitalize("keesey"));
			assertEquals("Øyvind", capitalize("øyvind"));
			assertEquals("", capitalize(""));
			assertEquals("33", capitalize("33"));
		}
		public function testClean():void
		{
			assertEquals("foo", clean("foo"));
			assertEquals("foo", clean("   foo"));
			assertEquals("foo", clean("foo   "));
			assertEquals("foo bar", clean("foo bar"));
			assertEquals("foo bar", clean("   foo bar"));
			assertEquals("foo bar", clean("foo bar   "));
			assertEquals("foo bar", clean("foo   bar"));
			assertEquals("foo bar", clean("      foo   bar         "));
			assertEquals("foo bar", clean("\t\nfoo\f\tbar\t\t"));
		}
		public function testIsCased():void
		{
			assert(isCased("A"), "A");
			assert(isCased("A123"), "A123");
			assert(!isCased("1123"), "1123");
			assert(isCased("1123a"), "1123a");
			assert(isCased("    1123a"), "    1123a");
		}
		public function testPadLeft():void
		{
			assertEquals("1", padLeft(1, 1));
			assertEquals("001", padLeft(1, 3));
			assertEquals("0800", padLeft(800, 4));
			assertEquals("800", padLeft(800, 1));
			assertEquals("**800", padLeft(800, 5, "*"));
			assertEquals("**800", padLeft(800, 4, "**"));
		}
		public function testPadRight():void
		{
			assertEquals("1", padRight(1, 1));
			assertEquals("100", padRight(1, 3));
			assertEquals("8000", padRight(800, 4));
			assertEquals("800", padRight(800, 1));
			assertEquals("800**", padRight(800, 5, "*"));
			assertEquals("800**", padRight(800, 4, "**"));
		}
		public function testTrim():void
		{
			assertEquals("x", trim("x"));
			assertEquals("x", trim("   x"));
			assertEquals("x", trim("x   "));
			assertEquals("x", trim("   x   "));
			assertEquals("x", trim("\t\tx\n\f\r"));
			assertEquals("x y", trim("\t\tx y\n\f\r"));
			assertEquals("x\t\ty", trim("\t\tx\t\ty\n\f\r"));
		}
	}
}