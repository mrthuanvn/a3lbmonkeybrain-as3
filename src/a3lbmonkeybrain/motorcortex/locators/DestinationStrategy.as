package a3lbmonkeybrain.motorcortex.locators {
	import flash.geom.Point;
	
	/**
	 * Interface for a strategy for moving from one location to another.
	 * 
	 * @author T. Michael Keesey
	 */
	public interface DestinationStrategy {
		/**
		 * Calulcates the next point for moving from one location to another.
		 * 
		 * @param start			The original location.
		 * @param destination	The destination.
		 * @param elapsedTime	The amount of time, in milliseconds, that has passed since the last move. 
		 * @return	The next point to move to.
		 */
		function getNextPoint(locator:Locator, destination:Locator, elapsedTime:uint):Point;
	}
}