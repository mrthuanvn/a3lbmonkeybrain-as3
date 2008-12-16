package a3lbmonkeybrain.calculia.ui.mathml
{
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	import mx.controls.Label;
	import mx.core.mx_internal;
	
	use namespace mx_internal

	public class MathMLLabel extends Label
	{
		public function MathMLLabel()
		{
			super();
			truncateToFit = false;
			addEventListener(MouseEvent.CLICK, trace);
			addEventListener(TextEvent.LINK, onLink);
		}
		private function onLink(event:TextEvent):void
		{
			trace(event);
			trace(event.text);
		}
	    override mx_internal function getMinimumText(t:String):String
	    {
	        if (!t)
	            t = "";
	        return t;   
	    }
	}
}