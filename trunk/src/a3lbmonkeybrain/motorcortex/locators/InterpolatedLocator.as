package a3lbmonkeybrain.motorcortex.locators {
	import flash.geom.Point;
	/**
	 * A locator whose point is based on two other locators. 
	 * 
	 * @author T. Michael Keesey
	 */
	public class InterpolatedLocator extends RunnableLocator {
		/**
		 * @private 
		 */
		private var _fraction:Number = 0.5;
		/**
		 * @private 
		 */
		private var _targetA:Locator;
		/**
		 * @private 
		 */
		private var _targetB:Locator;
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
		public function InterpolatedLocator(x:Number=0.0, y:Number=0.0) 	{
			super(x, y);
		}
		/**
		 * Ratio that tells where this locator falls between <code>targetA</code> and {@link targetB}.
		 * A value of 0 places this locator at <code>targetB</code>. A value of 1 places this locator at <code>targetA</code>.
		 * A value of 0.5 places this locator directly between <code>targetA</code> and <code>targetB</code>.
		 * 
		 * @default	0.5
		 */
		public function get fraction():Number {
			return _fraction;
		}
		/**
		 * @private
		 */
		public function set fraction(value:Number):void {
			value = value || 0;
			if (_fraction != value) {
				_fraction = value;
				refresh();
			}
		}
		/**
		 * One of the locators which this locator is based on.
		 * 
		 * @default	null
		 * @see	#fraction
		 */
		public function get targetA():Locator {
			return _targetA;
		}
		/**
		 * @private
		 */
		public function set targetA(value:Locator):void {
			if (_targetA != value) {
				if (_targetA) {
					_targetA.removeEventListener(LocatorEventType.MOVE, refresh);
				}
				_targetA = value;
				if (_targetA) {
					_targetA.addEventListener(LocatorEventType.MOVE, refresh);
				}
				if (_targetB) {
					refresh();
				}
			}
		}
		/**
		 * One of the locators which this locator is based on.
		 * 
		 * @default	null
		 * @see	#fraction
		 */
		public function get targetB():Locator {
			return _targetB;
		}
		/**
		 * @private
		 */
		public function set targetB(value:Locator):void {
			if (_targetB != value) {
				if (_targetB) {
					_targetB.removeEventListener(LocatorEventType.MOVE, refresh);
				}
				_targetB = value;
				if (_targetB) {
					_targetB.addEventListener(LocatorEventType.MOVE, refresh);
				}
				if (_targetA) {
					refresh();
				}
			}
		}
		/**
		 * Refreshes this locator's position.
		 * 
		 * @param event	Dispatched event that triggered the refresh.
		 */
		override protected function performRefresh(event:Event):void {
			if (_targetA != null && _targetB != null) {
				point = Point.interpolate(_targetA.point, _targetB.point, _fraction);
			}
		}
	}
}