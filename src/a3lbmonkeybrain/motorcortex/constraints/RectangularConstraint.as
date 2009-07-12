package a3lbmonkeybrain.motorcortex.constraints
{
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
	 * Constrains points to be within a rectangle.
	 * 
	 * @author T. Michael Keesey
	 */
	public class RectangularConstraint extends EventDispatcher implements Constraint
	{
		/**
		 * @private 
		 */
		private var _maxX:Number = Number.POSITIVE_INFINITY;
		/**
		 * @private 
		 */
		private var _maxY:Number = Number.POSITIVE_INFINITY;
		/**
		 * @private 
		 */
		private var _minX:Number = Number.NEGATIVE_INFINITY;
		/**
		 * @private 
		 */
		private var _minY:Number = Number.NEGATIVE_INFINITY;
		/**
		 * Creates a new instance, 
		 * 
		 */
		public function RectangularConstraint()
		{
			super();
		}
		[Bindable(event="change")]
		/**
		 * Right side of the constraining rectangle, in pixels.
		 * <p>
		 * Setting this to less than <code>minX</code> will set <code>minX</code> to the same value.
		 * </p>
		 * 
		 * @default Number.POSITIVE_INFINITY
		 * @see #minX
		 */
		public final function get maxX():Number
		{
			return _maxX;
		}
		/**
		 * @private
		 */
		public final function set maxX(value:Number):void
		{
			if (_maxX != value)
			{
				_maxX = value;
				if (_maxX < _minX)
					_minX = _maxX;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		[Bindable(event="change")]
		/**
		 * Bottom side of the constraining rectangle, in pixels.
		 * <p>
		 * Setting this to less than <code>minY</code> will set <code>minY</code> to the same value.
		 * </p>
		 * 
		 * @default Number.POSITIVE_INFINITY
		 * @see #minY
		 */
		public final function get maxY():Number
		{
			return _maxY;
		}
		/**
		 * @private
		 */
		public final function set maxY(value:Number):void
		{
			if (_maxY != value)
			{
				_maxY = value;
				if (_maxY < _minY)
					_minY = _maxY;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		[Bindable(event="change")]
		/**
		 * Left side of the constraining rectangle, in pixels.
		 * <p>
		 * Setting this to more than <code>maxX</code> will set <code>maxX</code> to the same value.
		 * </p>
		 * 
		 * @default Number.NEGATIVE_INFINITY
		 * @see #maxX
		 */
		public final function get minX():Number
		{
			return _minX;
		}
		/**
		 * @private
		 */
		public final function set minX(value:Number):void
		{
			if (_minX != value)
			{
				_minX = value;
				if (_minX > _maxX)
					_maxX = _minX;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		[Bindable(event="change")]
		/**
		 * Top side of the constraining rectangle, in pixels.
		 * <p>
		 * Setting this to more than <code>maxY</code> will set <code>maxY</code> to the same value.
		 * </p>
		 * 
		 * @default Number.NEGATIVE_INFINITY
		 * @see #maxY
		 */
		public final function get minY():Number
		{
			return _minY;
		}
		/**
		 * @private
		 */
		public final function set minY(value:Number):void
		{
			if (_minY != value)
			{
				_minY = value;
				if (_minY > _maxY)
					_maxY = _minY;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * @inheritDoc
		 */
		public function constrainPoint(point:Point):Point {
			return new Point(Math.min(_maxX, Math.max(_minX, point.x)),
				Math.min(_maxY, Math.max(_minY, point.y)));
		}
	}
}