package a3lbmonkeybrain.hippocampus.text
{
	import flexunit.framework.TestCase;
	
	import a3lbmonkeybrain.hippocampus.domain.TestEntity;
	import a3lbmonkeybrain.hippocampus.text.Format;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class DescriptionTest extends TestCase
	{
		public function testFindLabelForClass():void
		{
			assertEquals("Test Entity", Description.findLabelForClass(TestEntity));
			assertEquals("Test Entities", Description.findLabelForClass(TestEntity, LabelType.PLURAL));
			assertEquals("a test entity", Description.findLabelForClass(TestEntity,
				LabelType.WITH_ARTICLE).toLowerCase());
		}
		public function testFindTextForClass():void
		{
			assertEquals("This is a test implementation of <code>Entity</code>.",
				Description.findTextForClass(TestEntity, Format.HTML_TEXT));
			assertEquals("This is a test implementation of Entity.",
				Description.findTextForClass(TestEntity));
		}
	}
}