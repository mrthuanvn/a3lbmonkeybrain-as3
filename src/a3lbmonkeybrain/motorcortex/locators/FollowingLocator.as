package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	import a3lbmonkeybrain.motorcortex.record.PointRecord;
	
	import flash.geom.Point;
	import flash.utils.getTimer;
	/**
	 * Follows another locator by a given amount of time.
	 * 
	 * @author T. Michael Keesey
	 */
	public class FollowingLocator extends RunnableLocator {
		/**
		 * @private 
		 */
		private var _delay:uint = 0;
		/**
		 * @private 
		 */
		private var _target:Locator;
		/**
		 * A record of the target locator's positions over time, from least to most recent. 
		 */
		protected var records:Array;
		/**
		 * Creates a new instance
		 * 
		 * @param x	Initial horizontal coordinate.
		 * @param y Initial vertical coordinate.
		 * @see	#x
		 * @see	#y
		 */
		public function FollowingLocator(x:Number = 0.0, y:Number = 0.0) {
			super(x, y);
			records = [];
		}
		/**
		 * The number of milliseconds to follow the target locator by.
		 * 
		 * @defaultValue 0
		 */
		public final function get delay():uint {
			return _delay;
		}
		/**
		 * @private
		 */
		public final function set delay(value:uint):void {
			_delay = value || 0;
		}
		/**
		 * The locator that this locator follows.
		 */
		public final function get target():Locator {
			return _target;
		}
		/**
		 * @private
		 */
		public final function set target(value:Locator):void {
			if (_target != value) {
				if (_target) {
					_target.removeEventListener(LocatorEventType.MOVE, onTargetMove);
				}
				_target = value;
				if (_target) {
					_target.addEventListener(LocatorEventType.MOVE, onTargetMove);
				}
			}
		}
		/**
		 * Updates <code>records</code> when <code>target</code> moves.
		 *  
		 * @param event	<code>move</code> event.
		 */
		protected final function onTargetMove(event:Event):void {
			if (_delay) {
				var t:uint = getTimer();
				if (records.length) {
					if (PointRecord(records[records.length]).time == t) {
						return;
					}
				}
				records.push(new PointRecord(_target.point, t));
			}
		}
		/**
		 * Refreshes this locator. Called by <code>refresh()</code>.
		 * 
		 * @param event	Dispatched event that triggered the refresh.
		 * @see	#refresh()
		 */
		override protected function performRefresh(event:Event):void {
			if (_target) {
				if (_delay == 0) {
					point = _target.point;
				} else {
					var l:uint = records.length;
					if (l == 0) {
						return;
					}
					var t:uint = getTimer() - delay;
					var r:PointRecord;
					if (l == 1) {
						r = records[0] as PointRecord;
						point = r.point;
					} else {
						var index:uint = l;
						for (var i:uint = 0; i < l; ++i) {
							r = records[i] as PointRecord;
							if (r.time == t) {
								point = r.point;
								return;
							}
							if (r.time > t) {
								index = i;
								break;
							}
						}
						if (index == 0) {
							point = r.point;
							return;
						}
						var r2:PointRecord = records[index - 1] as PointRecord;
						var f:Number = (t - r2.time) / (r.time - r2.time);
						point = Point.interpolate(r.point, r2.point, f);
						if (--index) {
							records.splice(0, index);
						}
					}  
				} else {
					point = _target.point;
				}
			}
		}
	}
}