package a3lbmonkeybrain.motorcortex.control
{
	import a3lbmonkeybrain.motorcortex.run.RunEvent;
	import flash.events.Event;
	/**
	 * Dispatched when the value of <code>leftStep</code> changes.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.control.StepController.EVENT_CHANGE_LEFT
	 * @see #leftStep
	 */
	[Event(name="changeLeft",type="flash.events.Event")]
	/**
	 * Dispatched when the value of <code>rightStep</code> changes.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.control.StepController.EVENT_CHANGE_RIGHT
	 * @see #rightStep
	 */
	[Event(name="changeRight",type="flash.events.Event")]
	/**
	 * Dispatched when the value of <code>currentSide</code> changes.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.control.StepController.STEP
	 * @see #currentSide
	 */
	[Event(name="step",type="flash.events.Event")]
	/**
	 * Controller for alternating left and right steps.
	 * 
	 * @author T. Michael Keesey
	 */
	public class StepController extends SineController {
		/**
		 * The <code>StepController.EVENT_CHANGE_LEFT</code> constant defines the value of the <code>type</code>
		 * property of the event object for a <code>changeLeft</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"changeLeft"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType changeLeft
		 * @see	#stepLeft
		 */
		public static const EVENT_CHANGE_LEFT:String = "changeLeft";
		/**
		 * The <code>StepController.EVENT_CHANGE_RIGHT</code> constant defines the value of the <code>type</code>
		 * property of the event object for a <code>changeRight</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"changeRight"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType changeRight
		 * @see	#stepRight
		 */
		public static const EVENT_CHANGE_RIGHT:String = "changeRight";
		/**
		 * The <code>StepController.EVENT_STEP</code> constant defines the value of the <code>type</code>
		 * property of the event object for a <code>step</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"step"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType step
		 * @see	#currentSide
		 */
		public static const EVENT_STEP:String = "step";
		/**
		 * @private 
		 */
		private var _currentSide:Chirality = Chirality.RIGHT;
		/**
		 * Creates a new instance.
		 */
		public function StepController()
		{
			super();
			addEventListener(RunEvent.STOP, onStart, false, int.MAX_VALUE);
			addEventListener(Event.CHANGE, onChange, false, int.MAX_VALUE);
		}
		[Bindable(event="step")]
		/**
		 * The currently-stepping side. If this is set, values will jump to the beginning of the specified step.
		 *
		 * @default Chirality.RIGHT
		 * @throws ArgumentError
		 * 		If set to <code>null</code>.
		 */
		public final function get currentSide():Chirality
		{
			return _currentSide;
		} 
		/**
		 * @private
		 */
		public function set currentSide(value:Chirality):void
		{
			if (value == null) throw new ArgumentError();
			if (_currentSide != value)
			{
				_currentSide = value;
				angle.radians = (value == Chirality.LEFT) ? Math.PI : 0;
				dispatchEvent(new Event(EVENT_STEP));
			}
		}
		[Bindable(event="changeLeft")]
		/**
		 * Value for the left step, from 0 to 1.
		 * 
		 * @see #getStep()
		 */
		public function get leftStep():Number
		{
			return Math.max(0, -value);
		} 
		[Bindable(event="changeRight")]
		/**
		 * Value for the right step, from 0 to 1.
		 * 
		 * @see #getStep()
		 */
		public function get rightStep():Number
		{
			return Math.max(0, value);
		} 
		/**
		 * Value for the given side.
		 *  
		 * @param side
		 * 		<code>Chirality.LEFT</code> or <code>Chirality.RIGHT</code>.
		 * @return
		 * 		The value for the specified step, from 0 to 1.
		 * @see #leftStep
		 * @see #rightStep
		 * @see	Chirality
		 */
		public function getStep(side:Chirality):Number
		{
			if (!running)
				return 0;
			return Math.max(0, side.value * value);
		}
		/**
		 * @private
		 */
		private function onChange(event:Event):void
		{
			var r:Number = angle.radians;
			if (r <= Math.PI)
				dispatchEvent(new Event(EVENT_CHANGE_RIGHT));
			if (r == 0 || r >= Math.PI)
				dispatchEvent(new Event(EVENT_CHANGE_LEFT));
			var newSide:Chirality = (r < Math.PI) ? Chirality.RIGHT : Chirality.LEFT;
			if (_currentSide != newSide)
			{
				_currentSide = newSide;
				dispatchEvent(new Event(EVENT_STEP));
			}
		}
		/**
		 * @private
		 */
		private function onStop(event:RunEvent):void
		{
			angle.radians = (_currentSide == Chirality.LEFT) ? 0 : Math.PI;
		}
	}
}