package a3lbmonkeybrain.motorcortex.constraints
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when the rules of this constraint change.
	 *
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * A list of constraints, which may be applied in order to points.
	 * 
	 * @author T. Michael Keesey
	 * @see	Constraint 
	 */
	public class ConstraintSequence extends EventDispatcher implements Constraint
	{
		/**
		 * @private
		 */
		private var _constraints:Array /* of Constraint */ = [];
		/**
		 * Creates a new instance.
		 */
		public function ConstraintSequence()
		{
			super();
		}
		[ArrayElementType("a3lbmonkeybrain.motorcortex.constraints.Constraint")]
		[Bindable(event="change")]
		/**
		 * The list of constraints used by this sequence.
		 * <p>
		 * This property cannot be modified piecemeal but must bet set wholsesale.
		 * <p>
		 */
		public function get constraints():Array /* of Constraint */
		{
			return _constraints.concat();
		}
		/**
		 * @private
		 */
		public function set constraints(value:Array /* of Constraint */):void
		{
			for each (var constraint:Constraint in _constraints)
			{
				constraint.removeEventListener(Event.CHANGE, onConstraintChange);
			}
			_constraints = [];
			if (value == null)
				return;
			var n:int = value.length;
			for (var i:int = 0; i < n; ++i)
			{
				constraint = value[i] as Constraint;
				if (constraint != null)
				{
					constraint.addEventListener(Event.CHANGE, onConstraintChange);
					_constraints.push(constraint);
				}
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * @inheritDoc
		 */
		public function constrainPoint(point:Point):Point
		{
			var result:Point = point;
			for each (var constraint:Constraint in _constraints)
			{
				result = constraint.constrainPoint(result);
			}
			return result;
		}
		/**
		 * @private
		 */
		private function onConstraintChange(event:Event):void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}