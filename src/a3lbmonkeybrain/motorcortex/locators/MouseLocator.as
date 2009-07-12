package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.constraints.Constraint;
	
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * Dispatched when the <code>constraint</code> property changes. 
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEventType.CONSTRAINT_CHANGE
	 * @see	#constraint
	 */
	[Event(name="constraintChange",type="flash.events.Event")]
	/**
	 * Dispatched when the <code>x</code> or <code>y</code> property changes. Also signals simultaneous changes
	 * in the <code>point</code> property.
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEventType.MOVE
	 * @see	#point
	 * @see	#x
	 * @see	#y
	 */
	[Event(name="move",type="flash.events.Event")]
	/**
	 * Tracks the locator of the mouse within a {@link flash.display.InteractiveObject} instance.
	 * 
	 * @author T. Michael Keesey
	 */
	public class MouseLocator extends EventDispatcher implements Locator {
		/**
		 * Creates a new instance.
		 */
		public function MouseLocator() {
			super();
		}
		/**
		 * @see	#constraint
		 */
		private var _constraint:Constraint = null;
		/**
		 * @see	#interactiveObject
		 */
		private var _interactiveObject:InteractiveObject = null;
		[Bindable(event="constraintChange")]
		/**
		 * An object that constrains the point that this object represents.
		 * If <code>null</code>, this object's point is unconstrained.
		 * 
		 * @default	null
		 * @see a3lbmonkeybrain.motorcortex.constraints
		 * @see a3lbmonkeybrain.motorcortex.constraints.IConstraint
		 */
		public function get constraint():Constraint {
			return _constraint;
		}
		/**
		 * @private
		 */
		public function set constraint(value:Constraint):void {
			if (_constraint != value) {
				if (_constraint) {
					_constraint.removeEventListener(LocatorEventType.CONSTRAINT_CHANGE, dispatchEvent);
				}
				_constraint = value;
				if (_constraint) {
					_constraint.addEventListener(LocatorEventType.CONSTRAINT_CHANGE, dispatchEvent);
				}
				dispatchEvent(new Event(LocatorEventType.CONSTRAINT_CHANGE));
			}
		}
		/**
		 * The interactive object which this object tracks the mouse position of.
		 * 
		 * @default	null
		 */
		public function get interactiveObject():InteractiveObject {
			return _interactiveObject;
		}
		/**
		 * @private
		 */
		public function set interactiveObject(value:InteractiveObject):void {
			if (_interactiveObject != value) {
				if (_interactiveObject) {
					_interactiveObject.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				}
				_interactiveObject = value;
				if (_interactiveObject) {
					_interactiveObject.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				}
				dispatchEvent(new Event(LocatorEventType.MOVE));
			}
		}
		[Bindable(event="move")]
		/**
		 * The point that this object currently represents. Corresponds to the position of the mouse
		 * in <code>interactiveObject</code>. If <code>interactiveObject</code> is <code>null</code>, then <code>(x=0, y=0)</code> is returned.
		 * <p>
		 * Note that setting the properties of this field will not change it. That is, this code will
		 * have no effect:
		 * <pre>
		 * var l:Locator = new Locator(0, 0);
		 * l.point.x = 100;
		 * trace(l.point); // traces "(x=0, y=0)"
		 * </pre>
		 * </p>
		 * <p>
		 * Setting this field directly also has no effect.
		 * </p>
		 * 
		 * @default	(x=0, y=0)
		 * @see	#x
		 * @see	#y
		 */
		public function get point():Point {
			if (_interactiveObject) {
				return new Point(_interactiveObject.mouseX, _interactiveObject.mouseY);
			}
			return new Point();
		}
		/**
		 * @private
		 */
		public function set point(value:Point):void {
		}
		[Bindable(event="move")]
		/**
		 * The horizontal coordinate of the point that this object currently represents.
		 * <p>
		 * Setting this field has no effect.
		 * </p>
		 * 
		 * @default	0
		 * @see	#point
		 * @see	#y
		 */
		public function get x():Number {
			return _interactiveObject ? _interactiveObject.mouseX : 0;
		}
		/**
		 * @private
		 */
		public function set x(value:Number):void {
		}
		[Bindable(event="move")]
		/**
		 * The vertical coordinate of the point that this object currently represents.
		 * <p>
		 * Setting this field has no effect.
		 * </p>
		 * 
		 * @default	0
		 * @see	#point
		 * @see	#y
		 */
		public function get y():Number {
			return _interactiveObject ? _interactiveObject.mouseY : 0;
		}
		/**
		 * @private
		 */
		public function set y(value:Number):void {
		}
		/**
		 * Reports that the locator has moved whenever the mouse moves.
		 * 
		 * @param event	Mouse event.
		 * @see	#interactiveObject
		 * @see	flash.events.MouseEvent#MOUSE_MOVE
		 */
		protected function onMouseMove(event:MouseEvent):void {
			dispatchEvent(new Event(LocatorEventType.MOVE));
		}
	}
}