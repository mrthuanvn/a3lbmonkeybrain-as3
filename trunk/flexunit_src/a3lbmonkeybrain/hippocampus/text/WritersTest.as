package a3lbmonkeybrain.hippocampus.text
{
	import flexunit.framework.TestCase;
	
	import a3lbmonkeybrain.hippocampus.domain.TestEntity;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class WritersTest extends TestCase
	{
		public function testWrite():void
		{
			const entity:TestEntity = createEntity("Primates");
			entity.children.addItem(createEntity("Lemuriformes"));
			entity.children.addItem(createEntity("Tarsiiformes"));
			entity.children.addItem(createEntity("Simiiformes"));
			XML.ignoreWhitespace = false;
			XML.prettyPrinting = false;
			const html:XML = <span><i>Primates</i>: <span><i>Lemuriformes</i></span>; <span><i>Tarsiiformes</i></span>; <span><i>Simiiformes</i></span></span>;
			assertEquals(html.toXMLString(), Writers.writeHTML(entity));
			assertEquals(html.toXMLString(), Writers.writeText(entity, Format.HTML_TEXT));
			assertEquals("PRIMATES: LEMURIFORMES; TARSIIFORMES; SIMIIFORMES",
				Writers.writeText(entity));
		}
		private static function createEntity(name:String):TestEntity
		{
			const entity:TestEntity = new TestEntity();
			entity.name = name;
			return entity;
		}
	}
}