package a3lbmonkeybrain.motorcortex.locators {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Dispatched when any property of this object is set.
	 *
	 * @eventType flash.events.Event.CHANGE
	 * @see #locator
	 * @see #stateName
	 */
	[Event(name = "change", type = "flash.events.Event")]
	/**
	 * Associates a state name with a locator.
	 * 
	 * @author T. Michael Keesey
	 * @see Locator
	 * @see StateLocator
	 */	
	public final class StateLocatorEntry extends EventDispatcher {
		/**
		 * @private 
		 */
		private var _locator:Locator;
		/**
		 * @private 
		 */
		private var _stateName:String = "";
		/**
		 * Creates a new instance. 
		 */
		public function StateLocatorEntry() {
			super();
			_locator = new BasicLocator();
		}
		[Bindable(event="change")]
		/**
		 * The associated locator. 
		 * <p>
		 * Defaults to a <code>BasicLocator</code> with coordinates (0, 0). If set to <code>null</code>,
		 * this property will be set to a new <code>BasicLocator</code> with coordinates (0, 0).
		 * </p>
		 * <p>
		 * Changing this property causes this object to dispatch a <code>change</code> event.
		 * </p>
		 * 
		 * @see #event:change
		 * @see BasicLocator
		 */
		public function get locator():Locator {
			return _locator;
		}
		/**
		 * @private
		 */
		public function set locator(value:Locator):void {
			if (_locator != value) {
				_locator = (value == null) ? new BasicLocator() : value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		[Bindable(event="change")]
		/**
		 * The name of the associated state.
		 * <p>
		 * Defaults to the empty string (<code>&quot;&quot;</code). If set to <code>null</code>,
		 * this property will be set to the empty string.
		 * </p>
		 * <p>
		 * Changing this property causes this object to dispatch a <code>change</code> event.
		 * </p>
		 * 
		 * @see #event:change
		 */
		public function get stateName():String {
			return _stateName;
		}
		/**
		 * @private
		 */
		public function set stateName(value:String):void {
			value = (value == null) ? "" : value;
			if (_stateName != value) {
				_stateName = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
	}
}