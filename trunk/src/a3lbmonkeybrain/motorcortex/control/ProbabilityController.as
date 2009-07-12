package a3lbmonkeybrain.motorcortex.control {
	import a3lbmonkeybrain.motorcortex.beacon.Beacon;
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	import a3lbmonkeybrain.motorcortex.run.RunEvent;
	
	import flash.events.Event;
	/**
	 * Dispatched when the value changes.
	 *
	 * @eventType flash.events.Event.CHANGE
	 * @see #value
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * Controls a Boolean value which has a certain chance of being <code>true</code> or <code>false</code>.
	 * 
	 * @author T. Michael Keesey
	 * @see #probability
	 * @see	#value
	 */
	public class ProbabilityController extends AbstractBeaconDrivenController
	{
		/**
		 * @private 
		 */
		private var _probability:Number = 0.5;
		/**
		 * @private 
		 */
		private var _value:Boolean = false;
		/**
		 * Creates a new instance.
		 */
		public function ProbabilityController()
		{
			super();
		}
		/**
		 * The probability that <code>value</code> will be <code>true</code>. If 0, <code>value</code> will
		 * always be <code>false</code>. If 1, <code>value</code> will always be <code>true</code>.
		 * <p>
		 * Setting this to a non-number or a negative number will set it to 0. Setting this to any number more
		 * than 1 will set it to 1. 
		 * </p>
		 * 
		 * @default 0.5
		 */
		public final function get probability():Number
		{
			return _probability;
		}
		/**
		 * @private
		 */
		public final function set probability(value:Number):void
		{
			if (isNaN(value) || value < 0)
				value = 0;
			else if (value > 1)
				value = 1;
			_probability = value;
		}
		[Bindable(event="change")]
		/**
		 * The Boolean value that this controller controls.
		 * 
		 * @see	#probability
		 */
		public final function get value():Boolean
		{
			return _value;
		}
		/**
		 * @private
		 */
		public final function set value(newValue:Boolean):void
		{
			if (_value != newValue)
			{
				_value = newValue;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * @inheritDoc
		 */
		override public function refresh(event:Event = null):void
		{
			if (running)
			{
				if (_probability == 0)
					value = false;
				else if (_probability == 1)
					value = true;
				else
					value = Math.random() < _probability;
			}
		}
	}
}