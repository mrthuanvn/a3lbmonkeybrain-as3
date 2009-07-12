package a3lbmonkeybrain.motorcortex.control
{
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	import flash.events.Event;
	/**
	 * Dispatched when the value changes.
	 *
	 * @eventType flash.events.Event.CHANGE
	 * @see #value
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * Dispatched when the destination changes.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.control.NumberController.EVENT_DESTINATION_CHANGE
	 * @see #destination
	 */
	[Event(name="destinationChange",type="flash.events.Event")]
	/**
	 * Moves a number value toward a destination over time.
	 * 
	 * @author T. Michael Keesey
	 * @see	#value
	 */
	public class NumberController extends AbstractBeaconDrivenController
	{
		/**
		 * The default value for <code>speed</code>.
		 * 
		 * @see #speed 
		 */		
		public static const DEFAULT_SPEED:Number = 0.001;
		/**
		 * The <code>NumberController.EVENT_DESTINATION_CHANGE</code> constant defines the value of the
		 * <code>type</code> property of the event object for a <code>destinationChange</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"destinationChange"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType destinationChange
		 * @see	#destination
		 */
		public static const EVENT_DESTINATION_CHANGE:String = "destinationChange";
		/**
		 * @private 
		 */
		private var _destination:Number = 0;
		/**
		 * @private 
		 */
		private var _speed:Number = 1;
		/**
		 * @private 
		 */
		private var _value:Number = 0;
		/**
		 * Creates a new instance.
		 *  
		 * @param value
		 * 		Initial value for the <code>destination</code> and <code>value</code> properties.
		 * @param speed
		 * 		Initial value for the <code>speed</code> property.
		 * @see	#destination
		 * @see	#speed
		 * @see	#value
		 */
		public function NumberController(value:Number = 0, speed:Number = 0.001)
		{
			super();
			_destination = _value = value;
			_speed = speed;
		}
		[Bindable(event="destinationChange")]
		/**
		 * The destination for <code>value</code>.
		 * <p>
		 * If set to a non-number, defaults to 0.
		 * </p>
		 * 
		 * @see	#value
		 */
		public function get destination():Number
		{
			return _destination;
		}
		public function set destination(value:Number):void
		{
			if (isNaN(value))
				value = 0;
			if (_destination != value)
			{
				_destination = value;
				dispatchEvent(new Event(EVENT_DESTINATION_CHANGE));
			}
		}
		/**
		 * The speed, per millisecond, that <code>value</code> moves toward <code>destination</code>.
		 * 
		 * @see	#destination
		 * @see	#value
		 */
		public function get speed():Number
		{
			return _speed;
		}
		/**
		 * @private
		 */
		public function set speed(value:Number):void
		{
			if (isNaN(value))
				_speed = 0;
			else
				_speed = Math.abs(value);
		}
		[Bindable(event="change")]
		/**
		 * The value controller by this object. Moves toward <code>destination</code> at the rate indicated by
		 * <code>speed</code>.
		 * 
		 * @see #destination
		 * @see #speed
		 */
		public function get value():Number
		{
			return _value;
		}
		/**
		 * @inheritDoc
		 */
		override public function refresh(event:Event = null):void
		{
			if (running && event is BeaconEvent)
			{
				var speedAmount:Number = _speed * BeaconEvent(event).beaconTime;
				if (speedAmount == 0)
					return;
				if (Math.abs(_destination - _value) <= speedAmount)
					_value = _destination;
				else if (_destination < _value)
					_value -= speedAmount;
				else
					_value += speedAmount;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
}