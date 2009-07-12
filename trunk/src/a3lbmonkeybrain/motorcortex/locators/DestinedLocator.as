package a3lbmonkeybrain.motorcortex.locators {
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * Dispatched when this locator's destination moves away from this locator.
	 * 
	 * @eventType	 a3lbmonkeybrain.motorcortex.locators.LocatorEvent.DESTINATION_AWAY
	 * @see	#atDestination
	 */
	[Event(name="destinationAway",type="a3lbmonkeybrain.motorcortex.locators.LocatorEventType")]
	/**
	 * Dispatched when this locator reaches its destination.
	 * 
	 * @eventType	 a3lbmonkeybrain.motorcortex.locators.LocatorEvent.DESTINATION_REACHED
	 * @see	#atDestination
	 */
	[Event(name="destinationReached",type="a3lbmonkeybrain.motorcortex.locators.LocatorEventType")]
	/**
	 * A locator that moves toward another locator, using some strategy.
	 * 
	 * @author T. Michael Keesey
	 * @see	DestinationStrategy
	 */
	public class DestinedLocator extends RunnableLocator {
		/**
		 * @private 
		 */
		private var _atDestination:Boolean = true;
		/**
		 * @private 
		 */
		private var _destination:Locator;
		/**
		 * @private 
		 */
		private var _strategy:DestinationStrategy;
		/**
		 * The last time, in milliseconds, since this locator was updated.
		 */
		protected var lastTime:uint = 0;
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
		public function DestinedLocator(x:Number=0.0, y:Number=0.0) {
			super(x, y);
		}
		[Bindable(event="destinationAway")]
		[Bindable(event="destinationReached")]
		/**
		 * Tells whether the destination has been reached.
		 * <p>
		 * If <code>destination</code> is <code>null</code>, this property returns <code>true</code>. 
		 * </p>
		 * 
		 * @default	true
		 * @see	#destination
		 */
		public final function get atDestination():Boolean {
			return _atDestination;
		}
		/**
		 * This locator's destination.
		 * 
		 * @default	null
		 */
		public final function get destination():Locator {
			return _destination;
		}
		/**
		 * @private
		 */
		public final function set destination(value:Locator):void {
			if (_destination != value) {
				if (_destination) {
					_destination.removeEventListener(LocatorEventType.MOVE, refresh);
				}
				_destination = value;
				if (_destination) {
					_destination.addEventListener(LocatorEventType.MOVE, refresh);
				}
				updateLastTime();
				updateAtDestination();
			}
		}
		/**
		 * The strategy this locator uses to reach its destination.
		 * <p>
		 * Setting this sets <code>lastTime</code> back to 0.
		 * </p>
		 * 
		 * @default	null
		 * @see	#lastTime
		 */
		public final function get strategy():DestinationStrategy {
			return _strategy;
		}
		/**
		 * @private
		 */
		public final function set strategy(value:DestinationStrategy):void {
			if (_strategy != value) {
				_strategy = value;
				updateLastTime();
			}
		}
		/**
		 * @inheritDoc
		 */
		override protected function performRefresh(event:Event):void {
			if (_strategy && _destination) {
				var t:uint = getTimer();
				if (t > lastTime) {
					point = _strategy.getNextPoint(this, _destination, t - lastTime);
					lastTime = t;
					updateAtDestination();
				}
			}
		}
		/**
		 * @private 
		 */
		private function setAtDestination(value:Boolean):void {
			if (_atDestination != value) {
				_atDestination = value;
				dispatchEvent(new Event(_atDestination
					? LocatorEventType.DESTINATION_REACHED : LocatorEventType.DESTINATION_AWAY));
			}
		}
		/**
		 * Checks whether this locator has reached its destination.
		 */
		protected final function updateAtDestination():void {
			if (_destination == null) {
				setAtDestination(true);
			} else {
				setAtDestination(_destination.x == _x && _destination.y == _y);
			}
		}
		/**
		 * Updates <code>lastTime</code> to the current time, if <code>destination</code> and
		 * <code>strategy</code> are both set. 
		 */
		protected final function updateLastTime():void {
			if (_strategy != null && _destination != null) {
				lastTime = getTimer();
			}
		}
	}
}