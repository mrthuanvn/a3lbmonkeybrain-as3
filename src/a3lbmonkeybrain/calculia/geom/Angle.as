package a3lbmonkeybrain.calculia.geom
{
	import a3lbmonkeybrain.brainstem.relate.Ordered;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when this object changes.
	 *
	 * @eventType flash.events.Event.CHANGE
	 * @see #degrees
	 * @see #radians
	 */
	[Event(name = "change", type = "flash.events.Event")]
	/**
	 * Represents an angle.
	 * <p>
	 * Generally optimized for using radians over degrees.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see	#degrees
	 * @see	#radians
	 */
	public final class Angle extends EventDispatcher implements Ordered
	{
		/**
		 * Degrees per radian (π/180).
		 */
		public static const DEG_TO_RAD:Number = Math.PI / 180;
		/**
		 * 2π (radians per full rotation).
		 */
		public static const PI_2:Number = Math.PI * 2;
		/**
		 * Radians per degree (180/π).
		 */
		public static const RAD_TO_DEG:Number = 180 / Math.PI;
		/**
		 * @private 
		 */
		private var _radians:Number;
		/**
		 * Precision (in radians) to use when comparing angles for equality.
		 * 
		 * @see	#equals
		 */
		public static var precision:Number = 0.0001;
		/**
		 * Creates a new instance. Defaults to 0°.
		 * 
		 * @see	#clone()
		 * @see	#createFromDegrees()
		 * @see	#createFromDisplayObject()
		 * @see	#createFromRadians()
		 * @see	#difference()
		 */
		public function Angle()
		{
			super();
		}
		/**
		 * Creates a new angle from degrees.
		 * 
		 * @param degrees
		 * 		Value in degrees. If not set, defaults to 0°.
		 * @return
		 * 		New <code>Angle</code> object.
		 */
		public static function createFromDegrees(degrees:Number):Angle
		{
			const angle:Angle = new Angle();
			angle.degrees = degrees;
			return angle;
		}
		/**
		 * Creates a new angle from a display object (uses the <code>rotation</code> property).
		 * 
		 * @param object
		 * 		Display object. If not set, defaults to 0°.
		 * @return
		 * 		New <code>Angle</code> object.
		 * @see	flash.display.DisplayObject#rotation
		 */
		public static function createFromDisplayObject(object:DisplayObject):Angle
		{
			const angle:Angle = new Angle();
			if (object != null)
				angle.degrees = object.rotation;
			return angle;
		}
		/**
		 * Creates a new angle from a point. Corresponds to the angle from the origin (0, 0) to the point.
		 * 
		 * @param p
		 * 		A point.
		 * @return 
		 * 		New <code>Angle</code> object.
		 */
		public static function createFromPoint(p:Point):Angle
		{
			const angle:Angle = new Angle();
			if (p != null)
				angle.radians = Math.atan2(p.y, p.x);
			return angle;
		}
		/**
		 * Creates a new angle from radians.
		 * 
		 * @param radians
		 * 		Value in radians. If not set, defaults to 0°.
		 * @return
		 * 		New <code>Angle</code> object.
		 */
		public static function createFromRadians(radians:Number):Angle
		{
			const angle:Angle = new Angle();
			angle.radians = radians;
			return angle;
		}
		/**
		 * Calculates the difference between two angles.
		 * 
		 * @param a
		 * 		<code>Angle</code> object.
		 * @param b
		 * 		<code>Angle</code> object.
		 * @return
		 * 		New <code>Angle</code> object storing the difference between <code>a</code> and <code>b</code>.
		 */
		public static function difference(a:Angle, b:Angle):Angle
		{
			const difference:Angle = new Angle();
			if (!a.equals(b))
			{
				var lesser:Number;
				var greater:Number;
				if (a._radians < b._radians)
				{
					lesser = a._radians;
					greater = b._radians;
				}
				else
				{
					greater = a._radians;
					lesser = b._radians;
				}
				const diff1:Number = greater - lesser;
				const diff2:Number = lesser + (PI_2 - greater);
				difference.radians = Math.min(diff1, diff2);
			}
			return difference;
		}
		[Bindable(event="change")]
		/**
		 * Value of the angle in degrees: 0 ≤ <code>degrees</code> &lt; 360
		 * 
		 * @default 0
		 */
		public function get degrees():Number
		{
			return _radians * 180 / Math.PI;
		}
		/**
		 * @private
		 */
		public function set degrees(value:Number):void
		{
			radians = value * Math.PI / 180;
		}
		[Bindable(event="change")]
		/**
		 * Value of the angle in radians: 0 ≤ <code>radians</code> &lt; 2π
		 * 
		 * @default 0
		 */
		public function get radians():Number
		{
			return _radians;
		}
		/**
		 * @private
		 */
		public function set radians(value:Number):void
		{
			if (!isFinite(value))
				value = 0;
			while (value >= 2 * Math.PI)
			{
				value -= 2 * Math.PI;
			}
			while (value < 0)
			{
				value += 2 * Math.PI;
			}
			if (_radians != value)
			{
				_radians = value;
				if (hasEventListener(Event.CHANGE))
					dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * Creates a copy of this angle.
		 * 
		 * @return	New <code>Angle</code> object.
		 */
		public function clone():Angle
		{
			var angle:Angle = new Angle();
			angle.copy(this);
			return angle;
		}
		/**
		 * Finds the degrees amount equivalent to this angle which is closest to a given degrees amount.
		 * 
		 * <p>Examples:
		 * 	<table>
		 * 		<tr>
		 * 			<th><code>this.degrees</code></th>
		 * 			<th><code>degrees</code></th>
		 * 			<th><code>this.closestDegrees(degrees)</code></th>
		 * 		</tr>
		 * 		<tr>
		 * 			<td>0</td>
		 * 			<td>10</td>
		 * 			<td>0</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td>0</td>
		 * 			<td>-10</td>
		 * 			<td>0</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td>0</td>
		 * 			<td>370</td>
		 * 			<td>360</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td>90</td>
		 * 			<td>-300</td>
		 * 			<td>-270</td>
		 * 		</tr>
		 * 		<tr>
		 * 			<td>90</td>
		 * 			<td>-300</td>
		 * 			<td>-270</td>
		 * 		</tr>
		 * 	</table>
		 * </p>
		 * 
		 * @param degrees
		 * 		Degrees amount. If not a finite number, defaults to 0.
		 * @return
		 * 		A number (degrees).
		 */
		public function closestDegrees(degrees:Number):Number
		{
			if (!isFinite(degrees))
				degrees = 0;
			var closest:Number = this.degrees;
			while (degrees < closest)
			{
				closest -= 360;
			}
			while (degrees > closest)
			{
				closest += 360;
			}
			const diff1:Number = closest - degrees;
			const diff2:Number = degrees - (closest - 360);
			if (diff1 <= diff2)
				return closest;
			return closest - 360;
		}
		/**
		 * Copies data from another angle.
		 * 
		 * @param angle
		 * 		<code>Angle</code> object to copy data from.
		 */
		public function copy(angle:Angle):void
		{
			_radians = angle._radians;
		}
		/**
		 * Tests if this angle equals another angle.
		 * <p>
		 * Uses precision as determined by <code>Angle.precision</code>.
		 * </p>
		 * 
		 * @param angle
		 * 		<code>Angle</code> object to compare this one to.
		 * @return
		 * 		A value of <code>true</code> if the angles are equal; <code>false</code> if not.
		 * @see	#precision
		 */
		public function equals(value:Object):Boolean
		{
			if (value is Angle)
				return Math.abs(_radians - Angle(value)._radians) <= precision;
			if (value is Number)
				return Math.abs(_radians - Number(value)) <= precision;
			return false;
		}
		/**
		 * @inheritDoc
		 */
		public function findOrder(value:Object):int
		{
			if (value is Angle)
				return (Angle(value)._radians < _radians) ? 1 : (equals(value) ? 0 : -1);
			if (value is Number)
				return (value < _radians) ? 1 : ((value == _radians) ? 0 : -1);
			return 0;
		}
		/**
		 * String representation of this object.
		 * 
		 * @return
		 * 		<code>"<i>degrees</i>°"</code>; <code>degrees</code> is rounded to the nearest 1/100 for brevity.
		 * @see	#degrees
		 */
		override public function toString():String
		{
			return degrees.toPrecision(2) + "°";
		}
		/**
		 * @inheritDoc
		 */
		public function valueOf():Object
		{
			return _radians;
		}
	}
}