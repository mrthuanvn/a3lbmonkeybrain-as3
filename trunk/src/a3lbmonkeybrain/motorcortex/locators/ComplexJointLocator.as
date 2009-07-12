package a3lbmonkeybrain.motorcortex.locators {
	import flash.geom.Point;
	/**
	 * Locator that tracks a joint linked to two other locators.
	 * <p>
	 * For joints where both attached segements are the same length, <code>SimpleJointLocator</code> is optimized.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see SimpleJointLocator
	 */
	public class ComplexJointLocator extends AbstractJointLocator {
		/**
		 * @private 
		 */
		private var _originSegmentLength:Number = 0.0;
		/**
		 * @private 
		 */
		private var _targetSegmentLength:Number = 0;
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
		public function ComplexJointLocator(x:Number = 0.0, y:Number = 0.0) {
			super(x, y);
		}
		[Bindable]
		/**
		 * The optimal distance between <code>origin</code> and this locator.
		 * 
		 * @throws ArgumentError
		 * 		If set to a non-finite value.
		 * @default 0.0
		 * @see #origin
		 */
		public function get originSegmentLength():Number {
			return _originSegmentLength;
		}
		/**
		 * @private
		 */
		public function set originSegmentLength(value:Number):void {
			if (!isFinite(value)) {
				throw new ArgumentError();
			}
			value = Math.abs(value);
			if (_originSegmentLength != value) {
				_originSegmentLength = value;
				update();
			}
		}
		[Bindable]
		/**
		 * The optimal distance between <code>target</code> and this locator.
		 * 
		 * @throws ArgumentError
		 * 		If set to a non-finite value.
		 * @default 0.0
		 * @see #target
		 */
		public function get targetSegmentLength():Number {
			return _targetSegmentLength;
		}
		/**
		 * @private
		 */
		public function set targetSegmentLength(value:Number):void {
			if (!isFinite(value)) {
				throw new ArgumentError();
			}
			value = Math.abs(value);
			if (_targetSegmentLength != value) {
				_targetSegmentLength = value;
				update();
			}
		}
		/**
		 * @inheritDoc 
		 */
		override protected function calculatePoint():Point {
			if (_origin == null || _target == null) {
				return new Point();
			}
			var originPoint:Point = _origin.point;
			if (_originSegmentLength == 0) {
				return originPoint;
			}
			var targetPoint:Point = _target.point; 
			var offset:Point = targetPoint.subtract(originPoint);
			if (_targetSegmentLength == 0) {
				offset.normalize(_originSegmentLength);
				return offset.add(originPoint);
			}
			if (offset.length >= _originSegmentLength + _targetSegmentLength) {
				return Point.interpolate(originPoint, targetPoint,
					_targetSegmentLength / (_originSegmentLength + _targetSegmentLength));
			}
			var theta2:Number = Math.acos((offset.x * offset.x + offset.y * offset.y
				- _originSegmentLength * _originSegmentLength - _targetSegmentLength * _targetSegmentLength)
				/ (2 * _originSegmentLength * _targetSegmentLength));
			if (isNaN(theta2)) {
				theta2 = 0;
			}
			var cosTheta2:Number = Math.cos(theta2);
			var sinTheta2:Number = Math.sin(theta2);
			var oLPlusTLCosTh2:Number = _originSegmentLength + _targetSegmentLength * cosTheta2;
			var tLsinTh2:Number = _targetSegmentLength * sinTheta2; 
			var atanY:Number = oLPlusTLCosTh2 * offset.y - tLsinTh2 * offset.x;
			var atanX:Number = oLPlusTLCosTh2 * offset.x + tLsinTh2 * offset.y;
			var theta1:Number = Math.atan2(atanY, atanX);
			if (_orientation >= 0) {
				var theta:Number = Math.atan2(offset.y, offset.x);
				theta1 = theta * 2 - theta1; 
			}
			return new Point(Math.cos(theta1) * _originSegmentLength + originPoint.x,
				Math.sin(theta1) * _originSegmentLength + originPoint.y);
		}
	}
}