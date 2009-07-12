package a3lbmonkeybrain.motorcortex.control {
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * Dispatched when the user presses the mouse button while over <code>interactiveObject</code>.
	 *
	 * @eventType flash.events.MouseEvent.MOUSE_DOWN
	 * @see #down
	 * @see #interactiveObject
	 * @see #stageIndicator
	 * @see #up
	 */
	[Event(name="mouseDown",type="flash.events.MouseEvent")]
	/**
	 * Dispatched when the user release the mouse button while over <code>interactiveObject</code>.
	 *
	 * @eventType flash.events.MouseEvent.MOUSE_UP
	 * @see #down
	 * @see #interactiveObject
	 * @see #stageIndicator
	 * @see #up
	 */
	[Event(name="mouseUp",type="flash.events.MouseEvent")]
	/**
	 * Dispatched when the controller is restarted.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.START
	 * @see #running
	 */
	[Event(name="start",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * Dispatched when the controller is stopped.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.STOP
	 * @see #running
	 */
	[Event(name="stop",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * Tracks the state of the mouse button.
	 * 
	 * @author T. Michael Keesey
	 */
	public class MouseButtonController extends EventDispatcher implements Runnable
	{
		/**
		 * @private
		 */
		private var _down:Boolean = false;
		/**
		 * @private
		 */
		private var _interactiveObject:InteractiveObject = null;
		/**
		 * @private
		 */
		private var _stageIndicator:DisplayObject = null;
		/**
		 * @private
		 */
		private var _running:Boolean = false;
		/**
		 * Class cosntructor.
		 */
		public function MouseButtonController()
		{
			super();
		}
		[Bindable(event="mouseDown")]
		[Bindable(event="mouseUp")]
		/**
		 * Tells whether the mouse button is currently down.
		 * 
		 * @see	#up
		 */
		public final function get down():Boolean
		{
			return _down;
		}
		/**
		 * The interactive object which refreshes this controller.
		 * <p>
		 * This controller uses a weak reference to listen to an interactive object, so that if nothing else refers
		 * to the interactive object, it will be garbage-collected.
		 * </p>
		 * 
		 * @see	#down
		 * @see	#stageIndicator
		 * @see	#up
		 * @see	flash.display.InteractiveObject
		 */
		public final function set interactiveObject(value:InteractiveObject):void
		{
			if (_interactiveObject != value)
			{
				if (_interactiveObject != null)
				{
					_interactiveObject.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					_interactiveObject.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				}
				_interactiveObject = value;
				if (_interactiveObject != null)
				{
					_interactiveObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, int.MAX_VALUE,
						true);
					_interactiveObject.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, int.MAX_VALUE,
						true);
				}
			}
		}
		[Bindable(event="start")]
		[Bindable(event="stop")]
		/**
		 * @inheritDoc
		 */
		public final function get running():Boolean
		{
			return _running;
		}
		/**
		 * @private
		 */
		public final function set running(value:Boolean):void
		{
			if (_running != value)
			{
				if (!value && _down)
				{
					_down = false;
					dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
				}
				_running = value;
				dispatchEvent(new RunEvent(this));
			}
		}
		/**
		 * This property can be used to set <code>interactiveObject</code> to a <code>Stage</code> object.
		 * If it exists within a <code>Stage</code> object, that will be used as <code>interactiveObject</code>.
		 * If not, <code>interactiveObject</code> is set to <code>null</code> and then set to
		 * <code>stageIndicator.stage</code> whenever <code>stageIndicator</code> is added to a <code>Stage</code>
		 * object.
		 * <p>
		 * When <code>stageIndicator</code> is removed from its stage, it does not affect
		 * <code>interactiveObject</code>. 
		 * </p>
		 * <p>
		 * If this property is set to <code>null</code>, it does not affect <code>interactiveObject</code>. 
		 * </p>
		 * <p>
		 * Setting this property and <code>interactiveObject</code> is not recommended. One or the other
		 * should be used.
		 * </p>
		 * 
		 * @param value
		 * 		Display object that refers to a <code>Stage</code> object.
		 * @see #interactiveObject
		 * @see flash.display.Stage
		 * @see flash.display.DisplayObject#stage
		 * @see flash.events.Event#ADDED_TO_STAGE
		 */
		public final function set stageIndicator(value:DisplayObject):void
		{
			if (_stageIndicator != value)
			{
				if (_stageIndicator != null)
					_stageIndicator.removeEventListener(Event.ADDED_TO_STAGE, onIndicatorAddedToStage);
				_stageIndicator = value;
				if (_stageIndicator != null)
				{
					interactiveObject = _stageIndicator.stage;
					_stageIndicator.addEventListener(Event.ADDED_TO_STAGE, onIndicatorAddedToStage, false,
						int.MAX_VALUE, true);
				}
			}
		}
		[Bindable(event="mouseDown")]
		[Bindable(event="mouseUp")]
		/**
		 * Tells whether the mouse button is currently up.
		 * 
		 * @see	#down
		 */
		public final function get up():Boolean
		{
			return !_down;
		}
		/**
		 * @private
		 */
		private function onIndicatorAddedToStage(event:Event):void
		{
			interactiveObject = _stageIndicator.stage;
		}
		/**
		 * Refreshes this controller when the mouse is pressed.
		 * 
		 * @param event
		 * 		[optional] - Dispatched event (for example, <code>MouseEvent.MOUSE_DOWN</code>).
		 * @see	flash.events.MouseEvent#MOUSE_DOWN
		 */
		protected final function onMouseDown(event:Event = null):void {
			if (!_down)
			{
				_down = true;
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
		}
		/**
		 * Refreshes this controller when the mouse is released.
		 * 
		 * @param event
		 * 		[optional] - Dispatched event (for example, <code>MouseEvent.MOUSE_UP</code>).
		 * @see	flash.events.MouseEvent#MOUSE_UP
		 */
		protected final function onMouseUp(event:Event = null):void
		{
			if (_down)
			{
				_down = false;
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			}
		}
	}
}