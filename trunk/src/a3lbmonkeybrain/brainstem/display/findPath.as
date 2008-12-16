package a3lbmonkeybrain.brainstem.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Finds the path of a display object.
	 * <p>
	 * Suppose a display hierarchy where <code>child</code> is a child object of <code>parent</code>, and
	 * <code>parent</code> is a child object of <code>grandparent</code>. Then
	 * <code>DisplayObjectUtil.findPath(child, grandparent)</code> will return
	 * <code>&quot;parent.child&quot;</code>.
	 * </p>
	 *  
	 * @param object
	 * 		Object to find the path of.
	 * @param root
	 * 		Root object to stop at. If not specified, or if <code>root</code> is not the same as or ancestral to
	 * 		<code>object</code>, then the path will be from the highest reachable, named object in the display
	 * 		object hierarchy.
	 * @return 
	 * 		Period-separated list of display object names, from highest to lowest in the display object hierarchy.
	 */
	public function findPath(object:DisplayObject, root:DisplayObjectContainer = null):String
	{
		if (object == null || object == root)
			return "";
		if (object.parent != null && object.parent != root && object.parent.name != null)
			return findPath(object.parent, root) + "." + object.name;
		return object.name;
	}
}
