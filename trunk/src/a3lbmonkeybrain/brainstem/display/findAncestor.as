package a3lbmonkeybrain.brainstem.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Searchs a display object's ancestry for an instance of a certain class. If found, returns the instance.
	 * If not, returns <code>null</code>.
	 * 
	 * @param descendant
	 * 		Display object, or any object with a property named <code>&quot;parent&quot;</code> that references an
	 * 		instance of <code>DisplayObjectContainer</code>. If <code>descendant</code> does not match those
	 * 		criteria, this function returns <code>null</code>.
	 * @param ancestorClass
	 * 		Subclass of <code>DisplayObjectContainer</code>, the class of the object.
	 * @return
	 * 		The first instance of <code>ancestorClass</code> found by tracing <code>descendant</code>'s hierarchy,
	 * 		or <code>null</code>.
	 * @see flash.display.DisplayObjectContainer
	 */		
	public function findAncestor(descendant:Object, ancestorClass:Class):DisplayObjectContainer
	{
		var parent:DisplayObjectContainer = null;
		if (descendant is DisplayObject)
			parent = DisplayObject(descendant).parent;
		else if (descendant.hasOwnProperty("parent") && descendant.parent is DisplayObjectContainer)
			parent = descendant.parent as DisplayObjectContainer;
		if (parent != null && parent != descendant)
		{
			if (parent is ancestorClass)
				return parent as DisplayObjectContainer; 
			return findAncestor(parent, ancestorClass);
		}
		return null;
	}
}
