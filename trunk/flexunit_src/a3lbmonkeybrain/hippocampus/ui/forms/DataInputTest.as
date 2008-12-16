package a3lbmonkeybrain.hippocampus.ui.forms
{
	import a3lbmonkeybrain.brainstem.core.nullEventHandler;
	import a3lbmonkeybrain.brainstem.strings.clean;
	import a3lbmonkeybrain.brainstem.test.UITestUtil;
	import a3lbmonkeybrain.hippocampus.translate.DelegateTranslator;
	
	import flexunit.framework.TestCase;
	
	import mx.events.FlexEvent;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class DataInputTest extends TestCase
	{
		public function testDataInput():void
		{
			const input:DataInput = new DataInput();
			input.width = 300;
			input.translator = new DelegateTranslator(clean);
			input.initialize();
			input.addEventListener(FlexEvent.VALUE_COMMIT, trace);
			UITestUtil.createTestWindow(input, "DataInput", addAsync(nullEventHandler, int.MAX_VALUE));
		}
	}
}