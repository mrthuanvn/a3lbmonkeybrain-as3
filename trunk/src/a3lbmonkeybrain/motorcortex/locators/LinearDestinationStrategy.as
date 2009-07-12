package a3lbmonkeybrain.motorcortex.locators {
	import flash.geom.Point;
	/**
	 * Destination strategy that moves toward the destination at a constant rate for both axes (horizontal and vertical).
	 *  
	 * @author T. Michael Keesey
	 */
	public class LinearDestinationStrategy implements DestinationStrategy {
		/**
		 * @private 
		 */
		private var _xPerMilli:Number = 0;
		/**
		 * @private 
		 */
		private var _yPerMilli:Number = 0;
		/**
		 * Creates a new instance.
		 * 
		 * @param xPerMilli
		 * 		Initial value for <code>xPerMilli</code>.
		 * @param yPerMilli
		 * 		Initial value for <code>yPerMilli</code>.
		 * @see #xPerMilli
		 * @see #yPerMilli
		 */
		public function LinearDestinationStrategy(xPerMilli:Number = 0, yPerMilli:Number = 0) {
			super();
			this.xPerMilli = xPerMilli;
			this.yPerMilli = yPerMilli;
		}
		/**
		 * Horizontal distance (in pixels) to move per Milli.
		 * <p>
		 * If set to a negative number, will use the absolute value.
		 * </p>
		 */
		public function get xPerMilli():Number {
			return _xPerMilli;
		}
		/**
		 * @private
		 */
		public function set xPerMilli(value:Number):void {
			_xPerMilli = Math.abs(value) || 0;
		}
		/**
		 * Vertical distance (in pixels) to move per Milli.
		 * <p>
		 * If set to a negative number, will use the absolute value.
		 * </p>
		 */
		public function get yPerMilli():Number {
			return _yPerMilli;
		}
		/**
		 * @private
		 */
		public function set yPerMilli(value:Number):void {
			_yPerMilli = Math.abs(value) || 0;
		}
		/**
		 * @inheritDoc
		 */
		public function getNextPoint(locator:Locator, destination:Locator, time:uint):Point {
			if (time && (_xPerMilli || _yPerMilli)) {
				var p:Point = locator.point;
				var speed:Number;
				var diff:Number;
				if (_xPerMilli) {
					speed = _xPerMilli * time;
					diff = p.x - destination.x;
					if ((diff < 0 ? -diff : diff) < speed) {
						p.x = destination.x;
					} else if (diff > 0) {
						p.x -= speed;
					} else {
						p.x += speed; 
					}
				}
				if (_yPerMilli) {
					speed = _yPerMilli * time;
					diff = p.y - destination.y;
					if ((diff < 0 ? -diff : diff) < speed) {
						p.y = destination.y;
					} else if (diff > 0) {
						p.y -= speed;
					} else {
						p.y += speed;
					}
				}
				return p;
			}
			return locator.point;
		}
	}
}