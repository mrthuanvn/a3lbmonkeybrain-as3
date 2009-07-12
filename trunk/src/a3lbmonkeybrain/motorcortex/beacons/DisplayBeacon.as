package a3lbmonkeybrain.motorcortex.beacon
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * Beacon that uses a display object's <code>enterFrame</code> events.
	 * 
	 * @author T. Michael Keesey
	 * @see	flash.display.DisplayObject
	 * @see	flash.events.Event#ENTER_FRAME
	 */
	public class DisplayBeacon extends ProxyBeacon
	{
		/**
		 * Creates a new instance.
		 * 
		 * @param proxy
		 *		Display object. This beacon dispatches a <code>beacon</code> event every time <code>proxy</code>
		 * 		dispatches an <code>enterFrame</code> event. 
		 * @param useWeakReference
		 * 		If true, allows <code>proxy</code> to be garbage-collected if there are no other references
		 * 		to it.
		 * @see	flash.display.DisplayObject
		 * @see	flash.events.Event#ENTER_FRAME
		 * @see	flash.events.IEventDispatcher#addEventListener()
		 */
		public function DisplayBeacon(proxy:DisplayObject, useWeakReference:Boolean = true)
		{
			super(proxy, Event.ENTER_FRAME, useWeakReference);
		}
	}
}