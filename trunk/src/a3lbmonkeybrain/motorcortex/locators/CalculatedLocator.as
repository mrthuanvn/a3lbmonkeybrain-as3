package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.beacon.Beacon;
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	import a3lbmonkeybrain.motorcortex.constraints.Constraint;
	import a3lbmonkeybrain.motorcortex.refresh.Refreshable;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when the <code>constraint</code> property changes. 
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEventType.CONSTRAINT_CHANGE
	 * @see	#constraint
	 */
	[Event(name="constraintChange",type="flash.events.Event")]
	/**
	 * Dispatched when the <code>x</code> or <code>y</code> property changes. Also signals simultaneous changes
	 * in the <code>point</code> property.
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEventType.MOVE
	 * @see	#point
	 * @see	#x
	 * @see	#y
	 */
	[Event(name="move",type="flash.events.Event")]
	/**
	 * Base class for a locator that is (lazily) calculated.
	 * The function <code>calculatePoint</code> must be overridden in concrete subclasses.
	 * 
	 * @author T. Michael Keesey
	 * @see #calculatePoint()
	 */
	internal class CalculatedLocator extends EventDispatcher implements Locator, Refreshable {
		/**
		 * @private 
		 */
		private var _beacon:Beacon = null;
		/**
		 * @private 
		 */
		private var _constraint:Constraint;
		/**
		 * @private 
		 */
		private var _point:Point;
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
		public function CalculatedLocator(x:Number = 0.0, y:Number = 0.0) {
			super();
			_point = new Point(x, y);
		}
		/**
		 * The beacon that signals this locator to refresh its position.
		 * <p>
		 * Setting this to <code>null</code> will stop the locator from updating (unless something else
		 * triggers <code>refresh()</code>).
		 * </p>
		 * 
		 * @default	null
		 * @see #refresh()
		 * @see	a3lbmonkeybrain.motorcortex.beacon.Beacon
		 */
		public final function get beacon():Beacon {
			return _beacon;
		}
		/**
		 * @private
		 */
		public function set beacon(value:Beacon) {
			if (_beacon != value) {
				if (_beacon) {
					_beacon.removeEventListener(BeaconEvent.BEACON, refresh);
				}
				_beacon = value;
				if (_beacon) {
					_beacon.addEventListener(BeaconEvent.BEACON, refresh);
				}
			}
		}
		[Bindable(event="constraintChange")]
		/**
		 * @inheritDoc
		 */
		public final function get constraint():Constraint {
			return _constraint;
		}
		/**
		 * @private
		 */
		public function set constraint(value:Constraint):void {
			_constraint = value;
			point = point;
		}
		[Bindable(event="move")]
		/**
		 * @inheritDoc
		 */
		public final function get point():Point {
			return getPoint().clone();
		}
		/**
		 * @private
		 */
		public final function set point(value:Point):void {
			if (_constraint) {
				value = _constraint.constrainPoint(value);
			}
			if (getPoint().x != value.x || _point.y != value.y) {
				_point = value.clone();
				dispatchEvent(new Event(LocatorEventType.MOVE));
			}
		}
		[Bindable(event="move")]
		/**
		 * @inheritDoc
		 */
		public final function get x():Number {
			return getPoint().x;
		}
		/**
		 * @private
		 */
		public final function set x(value:Number):void {
			point = new Point(value, getPoint().y);
		}
		[Bindable(event="move")]
		/**
		 * @inheritDoc
		 */
		public final function get y():Number {
			return getPoint().y;
		}
		/**
		 * @private
		 */
		public final function set y(value:Number):void {
			point = new Point(getPoint().x, value);
		}
		/**
		 * Calculates the point of this locator.
		 * 
		 * @return
		 * 		Calculated <code>Point</code> object.
		 * @see	#clearPoint
		 * @see	#getPoint
		 * @see	flash.geom.Point
		 */
		protected function calculatePoint():Point {
			throw new IllegalOperationError("CalculatedLocator.calculatePoint() must be overridden.");
		}
		/**
		 * Resets the value of <code>point</code> so that, the next time it is retrieved, it is recalculated. 
		 * 
		 * @see	#calculatePoint
		 * @see	#getPoint
		 */
		protected final function clearPoint():void {
			_point = null;
		}
		/**
		 * Gets the calculated point, performing the calculation if necessary.
		 * 
		 * @return {@link flash.geom.Point} object.
		 * @see	#calculatePoint
		 * @see	#clearPoint
		 */
		protected final function getPoint():Point {
			if (_point == null) {
				_point = calculatePoint();
				if (_constraint != null) {
					_point = _constraint.constrainPoint(_point);
				}
			}
			return _point;
		}
		/**
		 * @inheritDoc
		 */
		public function refresh(event:Event = null):void {
			_point = null;
			dispatchEvent(new Event(LocatorEventType.MOVE));
		}
	}
}