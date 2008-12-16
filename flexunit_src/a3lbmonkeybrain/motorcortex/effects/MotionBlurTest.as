package a3lbmonkeybrain.motorcortex.effects
{
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import flexunit.framework.TestCase;
	
	import mx.core.Application;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class MotionBlurTest extends TestCase
	{
		private var blur:MotionBlur;
		private var blurred:TextField;
		private function completeTest(...args):void
		{
			Application.application.removeEventListener(MouseEvent.MOUSE_MOVE, updateBlurredPos);
			blurred.parent.removeChild(blurred);
			blur.dispose();
		}
		public function test():void
		{
			blurred = new TextField();
			blurred.text = "MotionBlurTest\nClick to end.\n(Ends automatically after 10 seconds.)";
			blurred.autoSize = TextFieldAutoSize.CENTER;
			blurred.background = true;
			blurred.textColor = 0x000000;
			blurred.backgroundColor = 0xFFFFFF;
			blurred.filters = [new DropShadowFilter()];
			updateBlurredPos();
			blur = new MotionBlur(blurred, 0.3);
			Application.application.rawChildren.addChild(blurred);
			Application.application.addEventListener(MouseEvent.MOUSE_MOVE, updateBlurredPos);
			blurred.addEventListener(MouseEvent.CLICK, addAsync(completeTest, 10 * 1000, null, completeTest), false, 0,
				true);
		}
		private function updateBlurredPos(event:MouseEvent = null):void
		{
			blurred.x = Application.application.mouseX - blurred.width / 2;
			blurred.y = Application.application.mouseY - blurred.height / 2;
		}
	}
}