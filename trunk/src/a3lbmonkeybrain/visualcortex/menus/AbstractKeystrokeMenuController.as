package a3lbmonkeybrain.visualcortex.menus
{
	import flash.display.InteractiveObject;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	import a3lbmonkeybrain.visualcortex.keyboard.Keystroke;
	
	public class AbstractKeystrokeMenuController extends AbstractMenuController
	{
		private var keystrokeMap:Dictionary = new Dictionary();
		public function AbstractKeystrokeMenuController(uiObject:InteractiveObject)
		{
			super();
			uiObject.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		}
		protected final function addKeystroke(stroke:Keystroke, item:MenuDataItem):void
		{
			if (keystrokeMap == null)
				keystrokeMap = new Dictionary();
			keystrokeMap[stroke] = item;
		}
		protected final function clearKeystrokes():void
		{
			keystrokeMap = null;
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			for (var stroke:* in keystrokeMap)
			{
				if (Keystroke(stroke).matchesEvent(event))
				{
					processItem(keystrokeMap[stroke] as MenuDataItem);
					return;
				}
			}
		}
	}
}