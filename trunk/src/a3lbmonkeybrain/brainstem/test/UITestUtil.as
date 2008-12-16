package a3lbmonkeybrain.brainstem.test
{
	import a3lbmonkeybrain.brainstem.core.findClassName;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.TitleWindow;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	public class UITestUtil
	{
		public function UITestUtil()
		{
			super();
		}
		public static function createTestWindow(value:DisplayObject,
			className:String = null, onClose:Function = null):TitleWindow
		{
			if (value is UIComponent)
				UIComponent(value).initialize();
			if (className == null)
				className = findClassName(value);
			const window:TitleWindow = new TitleWindow();
			window.initialize();
			window.title = className + " Test";
			window.showCloseButton = true;
			window.addChild(value);
			PopUpManager.addPopUp(window, Application.application as DisplayObject, true);
			PopUpManager.centerPopUp(window);
			if (onClose != null)
				window.addEventListener(CloseEvent.CLOSE, onClose);
			window.addEventListener(CloseEvent.CLOSE, onWindowClose);
			return window;
		}
		private static function onWindowClose(event:CloseEvent):void
		{
			const window:IFlexDisplayObject = event.target as IFlexDisplayObject;
			PopUpManager.removePopUp(window);
		}
	}
}