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
	 * Constrains points to be within a horizontal range.
	 * 
	 * @author T. Michael Keesey
	 */
	public class HorizontalConstraint extends EventDispatcher implements Constraint
	{
		/**
		 * @private 
		 */
		private var _maxX:Number = Number.POSITIVE_INFINITY;
		/**
		 * @private 
		 */
		private var _minX:Number = Number.NEGATIVE_INFINITY;
		/**
		 * Creates a new instance, 
		 * 
		 */
		public function HorizontalConstraint()
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
		 * @see	#minX
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
		/**
		 * @inheritDoc
		 */
		public function constrainPoint(point:Point):Point
		{
			return new Point(Math.min(_maxX, Math.max(_minX, point.x)), point.y);
		}
	}
}