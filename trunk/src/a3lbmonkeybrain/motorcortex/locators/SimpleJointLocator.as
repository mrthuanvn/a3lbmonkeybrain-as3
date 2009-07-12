package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.geom.Angle;
	
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * Maintains a position equidistant from two other locators. May be used for a joint (such as an elbow, a knee,
	 * etc.) as long at the segments on either side of it are the same length. For joints with segments of
	 * different sizes, use <code>JointLocator</code>.
	 * 
	 * @author T. Michael Keesey
	 * @see JointLocator
	 */
	public class SimpleJointLocator extends CalculatedLocator {
		/**
		 * @private 
		 */
		private var _minAngle:Angle = new Angle();
		/**
		 * @private 
		 */
		private var _segmentLength:Number = 0.0;
		/**
		 * Equivalent to <code>segmentLength</code> &times; 2; precalculated for optimization.
		 * 
		 * @private 
		 */
		private var segmentLength2:Number = 0.0;
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
		public function SimpleJointLocator(x:Number = 0.0, y:Number = 0.0) {
			super(x, y);
			_minAngle.addEventListener(Event.CHANGE, refresh, false, int.MAX_VALUE, true);
		}
		[Bindable]
		/**
		 * The minimum angle between the segments of the joint.
		 * 
		 * @default 0°
		 * @throws ArgumentError
		 * 		If set to <code>null</code>.
		 */
		public function get minAngle():Angle {
			return _minAngle;
		}
		/**
		 * @private
		 */
		public function set minAngle(value:Angle):void {
			if (value == null) {
				throw new ArgumentError();
			}
			if (!_minAngle.equals(value)) {
				_minAngle.copy(value);
			}
		}
		[Bindable]
		/**
		 * The optimal length of the segments, both from <code>origin</code> to this and from this
		 * to <code>target</code>.
		 * 
		 * @see #origin
		 * @see #target
		 * @throws ArgumentError
		 * 		If not set to a finite number.
		 */
		public function get segmentLength():Number {
			return _segmentLength;
		}
		/**
		 * @private
		 */
		public function set segmentLength(value:Number):void {
			if (!isFinite(value)) {
				throw new ArgumentError();
			}
			value = Math.abs(value);
			if (_segmentLength != value) {
				_segmentLength = value;
				segmentLength2 = value * 2;
				refresh();
			}
		}
		/**
		 * @inheritDoc
		 */
		override protected function calculatePoint():void {
			if (_origin == null || _target == null) {
				return new Point();
			}
			var newPoint:Point;
			var midpoint:Point = Point.interpolate(_origin.point, _target.point, 0.5); 
			var distance:Number = Point.distance(_origin.point, _target.point);
			if (distance >= segmentLength2) {
				newPoint = midpoint;
			} else {
				var alpha:Number = Math.asin(distance / segmentLength2);
				var alpha2:Number = alpha * 2;
				if (_minAngle && Math.abs(alpha2) > _minAngle) {
					alpha = Math.max(_minAngle, alpha2) / 2;
				}
				var offset:Number = _segmentLength * Math.cos(alpha);
				var originAngle:Number = Math.atan2(_target.point.y - _origin.point.y,
					_target.point.x - _origin.point.x);
				var offsetAngle:Number = originAngle + _orientation * (Math.PI / 2);
				newPoint = new Point(Math.cos(offsetAngle) * offset + midpoint.x,
					Math.sin(offsetAngle) * offset + midpoint.y);
			}
			return newPoint;
		}
	}
}