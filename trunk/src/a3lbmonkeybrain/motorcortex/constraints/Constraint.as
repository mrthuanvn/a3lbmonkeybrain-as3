package a3lbmonkeybrain.motorcortex.constraints
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when the rules of this constraint change.
	 *
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change",type="flash.events.Event")]
	/**
	 * Interface for classes which constrain points in some way.
	 * 
	 * @author T. Michael Keesey
	 * @see	a3lbmonkeybrain.motorcortex.geom.Point3D
	 * @see	flash.geom.Point
	 */
	public interface Constraint extends IEventDispatcher
	{
		/**
		 * Constrains a point.
		 * 
		 * @param point
		 * 		Point to constrain. Does not modify this object.
		 * @return
		 * 		Constrained point. 
		 */
		function constrainPoint(point:Point):Point;
	}
}