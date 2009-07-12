package a3lbmonkeybrain.motorcortex.locators
{
	import flash.geom.Point;
	/**
	 * Default implementation of <code>JointLocator</code>.
	 * <p>
	 * This class cannot be instantiated; use a concrete subclass instead.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see JointLocator
	 */
	internal class AbstractJointLocator extends CalculatedLocator implements JointLocator
	{
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
		public function AbstractJointLocator(x:Number = 0.0, y:Number = 0.0)
		{
			super(x, y);
		}
		[Bindable]
		[Inspectable(enumeration="-1,1")]
		/**
		 * @inheritDoc
		 */
		public final function get orientation():int
		{
			return _orientation;
		}
		/**
		 * @private
		 */
		public final function set orientation(value:int):void
		{
			value = (value < 0) ? -1 : 1;
			if (_orientation != value)
			{
				_orientation = value;
				refresh();
			}
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public final function get origin():Locator {
			return _origin;
		}
		/**
		 * @private
		 */
		public final function set origin(value:Locator):void {
			if (_origin != value)
			{
				if (_origin != null)
					_origin.removeEventListener(LocatorEventType.MOVE, refresh);
				_origin = value;
				if (_origin != null)
					_origin.addEventListener(LocatorEventType.MOVE, refresh);
				refresh();
			}
		}
		[Bindable]
		/**
		 * @inheritDoc
		 */
		public final function get target():Locator
		{
			return _target;
		}
		/**
		 * @private
		 */
		public final function set target(value:Locator):void {
			if (_target != value)
			{
				if (_target != null)
					_target.removeEventListener(LocatorEventType.MOVE, refresh);
				_target = value;
				if (_target != null)
					_target.addEventListener(LocatorEventType.MOVE, refresh);
				refresh();
			}
		}
	}
}