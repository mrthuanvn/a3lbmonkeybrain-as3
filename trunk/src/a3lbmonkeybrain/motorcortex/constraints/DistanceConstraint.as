package a3lbmonkeybrain.motorcortex.constraints
{
	import a3lbmonkeybrain.motorcortex.geom.Point3D;
	import a3lbmonkeybrain.motorcortex.locators.Locator;
	import a3lbmonkeybrain.motorcortex.locators.LocatorEventType;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when the rules of this constraint change.
	 *
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * Constrains points to be within a certain distance range from a certain locator.
	 * <p>
	 * Works with both 2D and 3D points.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 * @see	a3lbmonkeybrain.motorcortex.locators.Locator
	 */
	public class DistanceConstraint extends EventDispatcher implements Constraint
	{
		protected var _maxDistance:Number = Number.POSITIVE_INFINITY;
		protected var _minDistance:Number = 0.0;
		protected var _target:Locator;
		/**
		 * Creates a new instance.
		 */
		public function DistanceConstraint()
		{
			super();
		}
		[Bindable(event="change")]
		/**
		 * The furthest that points can be from <code>target</code>, in pixels.
		 * <p>
		 * If set to a negative value, will use the absolute value. If set to less than
		 * <code>minDistance</code>, will set <code>minDistance</code> to the same value. 
		 * </p>
		 * 
		 * @default Number.POSITIVE_INFINITY
		 * @see	#minDistance
		 * @see	#target
		 */
		public function get maxDistance():Number
		{
			return _maxDistance;
		}
		/**
		 * @private
		 */
		public function set maxDistance(value:Number):void
		{
			value = Math.abs(value);
			if (_maxDistance != value)
			{
				_maxDistance = value;
				if (_minDistance > _maxDistance)
					_minDistance = _maxDistance;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		[Bindable(event="change")]
		/**
		 * The closest that points can be from <code>target</code>, in pixels.
		 * <p>
		 * If set to a negative value, will use the absolute value. If set to more than
		 * <code>maxDistance</code>, will set <code>maxDistance</code> to the same value. 
		 * </p>
		 * 
		 * @default 0.0
		 * @see	#maxDistance
		 * @see	#target
		 */
		public function get minDistance():Number
		{
			return _minDistance;
		}
		/**
		 * @private
		 */
		public function set minDistance(value:Number):void {
			value = Math.abs(value);
			if (_minDistance != value) {
				_minDistance = value;
				if (_maxDistance < _minDistance)
					_maxDistance = _minDistance;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		[Bindable(event="change")]
		/**
		 * The locator which this constraint is bound to.
		 */
		public function get target():Locator
		{
			return _target;
		}
		/**
		 * @private
		 */
		public function set target(value:Locator):void
		{
			if (_target != value)
			{
				if (_target != null)
					_target.removeEventListener(LocatorEventType.MOVE, onTargetMove);
				_target = value;
				if (_target != null)
					_target.addEventListener(LocatorEventType.MOVE, onTargetMove);
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * @inheritDoc
		 */
		public function constrainPoint(point:Point):Point
		{
			if (_target != null && (_minDistance > 0 || _maxDistance < Number.POSITIVE_INFINITY))
			{
				var distance:Number = Point.distance(_target.point, point);
				var angle:Number;
				if (distance < _minDistance)
				{
					if (distance == 0)
						angle = Math.PI / 4;
					else
						angle = Math.atan2(point.y - _target.y, point.x - _target.x);
					return new Point(_target.x + _minDistance * Math.cos(angle),
						_target.y + _minDistance * Math.sin(angle));
				}
				else if (distance > maxDistance)
				{
					angle = Math.atan2(point.y - _target.y, point.x - _target.x);
					return new Point(_target.x + _maxDistance * Math.cos(angle),
						_target.y + _maxDistance * Math.sin(angle));
				}
			}
			return point.clone();
		}
		/**
		 * @private
		 */
		private function onTargetMove(event:LocatorEvent):void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}