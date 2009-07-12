package a3lbmonkeybrain.motorcortex.refresh {
	import flash.events.Event;
	/**
	 * Interface for objects which can be refreshed on certain events.
	 *  
	 * @author T. Michael Keesey
	 */
	public interface Refreshable {
		/**
		 * Refreshes this object.
		 * 
		 * @param event
		 * 		[optional] - Event this object is refreshed by. 
		 */
		function refresh(event:Event = null):void;
	}
}