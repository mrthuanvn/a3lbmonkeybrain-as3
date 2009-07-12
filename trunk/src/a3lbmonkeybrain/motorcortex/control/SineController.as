package a3lbmonkeybrain.motorcortex.control
{
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	import a3lbmonkeybrain.motorcortex.geom.Angle;
	import flash.events.Event;
	/**
	 * Dispatched when the value changes.
	 *
	 * @eventType flash.events.Event.CHANGE
	 * @see #value
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * Animates a numerical value according to a sine wave.
	 * 
	 * @author T. Michael Keesey
	 * @see	#value
	 */
	public class SineController extends AbstractBeaconDrivenController
	{
		/**
		 * The default value for <code>speed</code>, equivalent to one complete cycle per second.
		 * 
		 * @see #speed 
		 */		
		public static const DEFAULT_SPEED:Number = 2 * Math.PI / 1000;
		/**
		 * @private 
		 */
		private var _angle:Angle;
		/**
		 * @private 
		 */
		private var _speed:Number = DEFAULT_SPEED;
		/**
		 * @private 
		 */
		private var _value:Object = null;
		/**
		 * Creates a new instance.
		 */
		public function SineController()
		{
			super();
			_angle = new Angle();
			_angle.addEventListener(Event.CHANGE, onAngleChange, 0, int.MAX_VALUE);
		}
		/**
		 * The angle used to calculate <code>value</code>.
		 * 
		 * @see	#value
		 */
		public final function get angle():Angle
		{
			return _angle;
		}
		/**
		 * The speed to increment <code>angle</code> by, in cycles per second.
		 * <p>
		 * If set to a non-number, defaults to 0.
		 * </p>
		 * <p>
		 * Always equivalent to <code>speed</code> × 1000 / 2π.
		 * </p>
		 * 
		 * @default 1
		 * @see	#speed
		 */
		public final function get cyclesPerSecond():Number
		{
			return _speed * (1000 / (2 * Math.PI));
		}
		/**
		 * @private
		 */
		public final function set cyclesPerSecond(value:Number):void
		{
			if (isNaN(value))
				speed = 0;
			else
				_speed = value * (2 * Math.PI / 1000);
		}
		/**
		 * The speed to increment <code>angle</code> by, in radians per millisecond.
		 * <p>
		 * If set to a non-number, defaults to 0.
		 * </p>
		 * <p>
		 * Always equivalent to <code>cyclesPerSecond</code> × 2π / 1000.
		 * </p>
		 * 
		 * @default 0.006283185307179586476925286766559
		 * @see	#DEFAULT_SPEED
		 * @see	#cyclesPerSecond
		 */
		public final function get speed():Number
		{
			return _speed;
		}
		/**
		 * @private
		 */
		public final function set speed(value:Number):void
		{
			if (isNaN(value))
				_speed = 0;
			else
				_speed = value;
		}
		[Bindable(event="change")]
		/**
		 * The current value, from -1 to 1.
		 * 
		 * @see	#angle
		 */
		public final function get value():Number
		{
			if (_value == null)
				_value = Math.sin(_angle.radians);
			return Number(_value);
		}
		/**
		 * @private
		 */
		private function onAngleChange(event:Event):void
		{
			_value = null;
			dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * @inheritDoc
		 */
		override public function refresh(event:Event = null):void
		{
			if (running && event is BeaconEvent && _speed != 0)
				_angle.radians += _speed * BeaconEvent(event).beaconTime;
		}
	}
}