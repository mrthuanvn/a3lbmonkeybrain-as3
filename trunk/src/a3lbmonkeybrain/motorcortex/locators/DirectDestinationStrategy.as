package a3lbmonkeybrain.motorcortex.locators {
	import flash.geom.Point;
	/**
	 * Destination strategy that moves directly toward the destination at a constant rate.
	 *  
	 * @author T. Michael Keesey
	 */
	public class DirectDestinationStrategy implements DestinationStrategy {
		/**
		 * @private 
		 */
		private var _distancePerMilli:Number = 0.0;
		/**
		 * Creates a new instance.
		 * 
		 * @param distancePerMilli
		 * 		Initial value for <code>distancePerMilli</code>.
		 */
		public function DirectDestinationStrategy(distancePerMilli:Number = 0.0) {
			super();
			this.distancePerMilli = distancePerMilli;
		}
		/**
		 * Distance (in pixels) to move per millisecond.
		 * <p>
		 * If set to a negative number, will use the absolute value.
		 * </p>
		 * 
		 * @default 0.0
		 */
		public function get distancePerMilli():Number {
			return _distancePerMilli;
		}
		/**
		 * @private
		 */
		public function set distancePerMilli(value:Number):void {
			_distancePerMilli = Math.abs(value) || 0;
		}
		/**
		 * @inheritDoc
		 */
		public function getNextPoint(locator:Locator, destination:Locator, time:uint):Point {
			if (time && _distancePerMilli) {
				var speed:Number = _distancePerMilli * time;
				var xDiff:Number = destination.x - locator.x; 
				var yDiff:Number = destination.y - locator.y; 
				if (Math.sqrt(xDiff * xDiff + yDiff * yDiff) <= speed) {
					return destination.point;
				}
				var p:Point = locator.point;
				var a:Number = Math.atan2(yDiff, xDiff);
				p.x += speed * Math.cos(a);
				p.y += speed * Math.sin(a);
				return p;
			}
			return locator.point;
		}
	}
}