package a3lbmonkeybrain.hippocampus.ui.search
{
	import a3lbmonkeybrain.brainstem.core.nullEventHandler;
	import a3lbmonkeybrain.brainstem.test.UITestUtil;
	
	import flexunit.framework.TestCase;
	
	import mx.controls.TextInput;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class EntitySearcherTest extends TestCase
	{
		public function EntitySearcherTest()
		{
			super();
		}
		public function testSearcher():void
		{
			const textInput:TextInput = new TextInput();
			textInput.width = 400;
			const searcher:EntitySearcher = new EntitySearcher();
			searcher.textInput = textInput;
			// :TODO: operation
			UITestUtil.createTestWindow(textInput, "EntitySearcher", addAsync(nullEventHandler, int.MAX_VALUE));
		}
	}
}