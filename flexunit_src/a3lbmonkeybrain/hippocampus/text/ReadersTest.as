package a3lbmonkeybrain.hippocampus.text
{
	import flexunit.framework.TestCase;
	
	import a3lbmonkeybrain.hippocampus.domain.TestEntity;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class ReadersTest extends TestCase
	{
		public function testRead():void
		{
			const s:String = "  Primates: Lemuriformes; Tarsiiformes; Simiiformes  ";
			const entity:TestEntity = Readers.read(s, TestEntity) as TestEntity;
			assertEquals("Primates", entity.name);
			assertEquals(3, entity.children.length);
			assertEquals("Lemuriformes", TestEntity(entity.children.getItemAt(0)).name);
			assertEquals("Tarsiiformes", TestEntity(entity.children.getItemAt(1)).name);
			assertEquals("Simiiformes", TestEntity(entity.children.getItemAt(2)).name);
		}
	}
}