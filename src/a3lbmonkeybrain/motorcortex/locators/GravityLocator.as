package a3lbmonkeybrain.motorcortex.locators {
	import flash.geom.Point;
	import flash.utils.getTimer;
	/**
	 * Locator that falls over time.
	 * 
	 * @author T. Michael Keesey
	 */
	public class GravityLocator extends CalculatedLocator {
		/**
		 * @private 
		 */
		private var _acceleration:Number = 9.8;
		/**
		 * @private 
		 */
		private var startPoint:Point;
		/**
		 * @private 
		 */
		private var startTime:uint = 0;
		/**
		 * @private 
		 */
		private var startVelocity:Number = 0;
		/**
		 * Creates a new instance.
		 *  
		 * @param x
		 * 		Initial horizontal coordinate.
		 * @param y
		 * 		Initial vertical coordinate.
		 * @see	#x
		 * @see	#y
		 */
		public function GravityLocator(x:Number = 0.0, y:Number = 0.0) {
			super(x, y);
			startPoint = new Point(x, y);
		}
		[Bindable]
		/**
		 * The gravity acceleration constant, in pixels per second squared.
		 * 
		 * @default	9.8
		 */
		public final function get acceleration():Number {
			return _acceleration;
		}
		/**
		 * @private
		 */
		public final function set acceleration(value:Number):void {
			_acceleration = value || 0;
		}
		/**
		 * Calculates the point of this locator.
		 * 
		 * @return Calculated <code>Point</code> object.
		 * @see	#clearPoint
		 * @see	#getPoint
		 */
		override protected function calculatePoint():Point {
			if (startTime) {
				var time:uint = getTimer() - startTime;
				var point:Point = startPoint.clone();
				point.y += 0.5 * _acceleration * time * time + startVelocity * time;
				return point;
			}
			return startPoint;
		}
		/**
		 * Starts moving the locator according to gravity.
		 * 
		 * @param velocity
		 * 		Initial velocity to start with. Default value: 0 (straight fall).
		 */
		public function start(velocity:Number = 0):void {
			startTime = getTimer();
			startPoint = new Point(x, y);
			startVelocity = velocity;
		}
		/**
		 * Stops moving the locator according to gravity.
		 */
		public function stop():void {
			startTime = 0;
			startPoint = new Point(x, y);
		}
	}
}