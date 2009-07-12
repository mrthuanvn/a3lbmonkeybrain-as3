package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.beacon.Beacon;
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * Locator that moves between other locators, as specified by a state.
	 * <p>
	 * This can be used to smoothly transition from one mode of motion to another.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 */
	public final class StateLocator extends BasicLocator {
		/**
		 * @private
		 */
		private var _beacon:Beacon;
		/**
		 * @private
		 */
		private var _entries:Object;
		/**
		 * @private
		 */
		private var _speed:Number = 0.001;
		/**
		 * @private
		 */
		private var stateRatio:Number = 0.0;
		/**
		 * @private
		 */
		private var states:Array;
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
		public function StateLocator(x:Number = 0.0, y:Number = 0.0) {
			super(x, y);
			_entries = {};
			states = [];
		}
		/**
		 * The beacon which refreshes this locator.
		 */
		public function set beacon(value:Beacon):void {
			if (_beacon != value) {
				if (_beacon != null) {
					_beacon.removeEventListener(BeaconEvent.BEACON, onBeacon);
				}
				_beacon = value;
				if (_beacon != null) {
					_beacon.addEventListener(BeaconEvent.BEACON, onBeacon);
				}
			}
		}
		/**
		 * A list of all associations between state names and locators.
		 * <p>
		 * This field can only be modified by resetting it.
		 * </p>
		 */
		public function get entries():Array /* of StateLocatorEntry */ {
			var result:Array = [];
			for each (var entry:StateLocatorEntry in _entries) {
				result.push(entry);
			}
			return result;
		}
		/**
		 * @private
		 */
		public function set entries(value:Array /* of StateLocatorEntry */):void {
			value = (value == null) ? [] : value;
			if (value.length > 0) {
				states = [value[0]];
			} else {
				states = [];
			}
			for each (var entry:StateLocatorEntry in _entries) {
				removeEntry(entry);
			}
			for each (entry in value) {
				addEntry(entry);
			}
		}
		/**
		 * The speed of the transition, in ratio per millisecond.
		 * <p>
		 * This must be a value between 0 and 1. Setting it to a non-number sets it to 0.
		 * </p>
		 * <p>
		 * Setting this to 0 will cause the state never to change.
		 * </p>
		 * 
		 * @default 0.001
		 */
		public function get speed():Number {
			return _speed;
		}
		/**
		 * @private
		 */
		public function set speed(value:Number):void {
			value = Math.min(1, Math.max(0, isNaN(value) ? 0 : value))
			_speed = value;
		}
		/**
		 * The name of this locator's current state.
		 */
		public function set state(value:String):void {
			while (states.length > 2) {
				states.pop();
			}
			if (states.length > 0) {
				if (states[states.length - 1] == value) {
					return;
				}
			}
			states.push(value);
			refreshPoint();
		}
		/**
		 * @private
		 */
		private function addEntry(entry:StateLocatorEntry):void {
			if (entry == null) {
				return;
			}
			if (_entries.hasOwnProperty(entry.stateName) && _entries[entry.stateName] is StateLocatorEntry) {
				removeEntry(_entries[entry.stateName] as StateLocatorEntry);
			}
			entry.addEventListener(Event.CHANGE, onEntryChange);
			entry.locator.addEventListener(LocatorEventType.MOVE, onLocatorMove);
			_entries[entry.stateName] = entry;
			refreshPoint();
		}
		/**
		 * @private
		 */
		private function advanceStateRatio(beaconTime:uint):void {
			if (states.length <= 1) {
				stateRatio = 0;
			} else {
				stateRatio += _speed * beaconTime;
				if (stateRatio >= 1) {
					stateRatio = 0;
					states.shift();
				}
			}
			refreshPoint();
		}
		/**
		 * @private
		 */
		private function getEntry(modeName:String):StateLocatorEntry {
			if (!_entries.hasOwnProperty(modeName)) {
				return null;
			}
			return _entries[modeName] as StateLocatorEntry;
		}
		/**
		 * @private
		 */
		private function onBeacon(event:BeaconEvent):void {
			advanceStateRatio(event.beaconTime);
		}
		/**
		 * @private
		 */
		private function onEntryChange(event:Event):void {
			removeEntry(event.target as StateLocatorEntry);
			addEntry(event.target as StateLocatorEntry);
			refreshPoint();
		}
		/**
		 * @private
		 */
		private function onLocatorMove(event:LocatorEventType):void {
			refreshPoint();
		}
		/**
		 * @private
		 */
		private function refreshPoint():void {
			if (states.length == 0) {
				return;
			}
			var entry0:StateLocatorEntry = getEntry(states[0]);
			if (entry0 == null) {
				stateRatio = 0;
				states.shift();
				updatePoint();
				return;
			}
			if (states.length == 1) {
				point = entry0.locator.point;
			} else {
				var entry1:StateLocatorEntry = getEntry(states[1]);
				if (entry1 == null) {
					stateRatio = 0;
					states.splice(1, 1);
					updatePoint();
					return;
				}
				point = Point.interpolate(entry1.locator.point, entry0.locator.point, stateRatio);
			}
		}
		/**
		 * @private
		 */
		private function removeEntry(entry:StateLocatorEntry):void {
			if (entry == null) {
				return;
			}
			entry.removeEventListener(Event.CHANGE, onEntryChange);
			entry.locator.removeEventListener(LocatorEventType.MOVE, onLocatorMove);
			for (var p:String in _entries) {
				if (_entries[p] == entry) {
					delete _entries[p];
				} 
			}
		}
	}
}