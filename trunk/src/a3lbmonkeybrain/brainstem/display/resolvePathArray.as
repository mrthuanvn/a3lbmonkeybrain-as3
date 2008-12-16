package a3lbmonkeybrain.brainstem.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	
	/**
	 * Given a parent object and a path, finds (and possibly creates) a display object.
	 * 
	 * @param ancestor
	 * 		Container to look in.
	 * @param path
	 * 		Array of display object names, from most to least inclusive. If empty, this method will return
	 * 		<code>ancestor</code>.
	 * @param forceCreation
	 * 		If <code>true</code>, will create new display objects (sprites) to satisfy <code>path</code>. If
	 * 		<code>false</code>, may cause this method to return <code>null</code>.	
	 * @return
	 * 		A display object. If <code>forceCreation</code> is <code>true</code>, this may be a new
	 * 		<code>Sprite</code> object. If <code>false</code>, this may return <code>null</code>.
	 * @throws ArgumentError
	 * 		<code>ArgumentError</code>: If any element in <code>path</code> is blank.
	 * @throws TypeError
	 * 		<code>TypeError</code>: If <code>ancestor</code> is <code>null</code>.
	 * @throws flash.errors.IllegalOperation
	 * 		<code>flash.errors.IllegalOperation</code>: If <code>forceCreation</code> is <code>true</code> and <code>path</code> requires making a child in
	 * 		a display object that is not a container.
	 * @see flash.display.DisplayObject
	 * @see flash.display.DisplayObjectContainer
	 * @see flash.display.Sprite
	 */
	public function resolvePathArray(ancestor:DisplayObjectContainer, path:Array /* .<String> */,
		forceCreation:Boolean = true):DisplayObject
	{
		if (ancestor == null)
			throw new TypeError("Null ancestor.");
		if (!(path.length > 0))
			return ancestor;
		const nextName:String = path[0];
		if (nextName.length == 0)
			throw new ArgumentError("Empty DisplayObject name in path (" + path.join(".") + ").");
		const next:DisplayObject = ancestor.getChildByName(nextName);
		if (path.length == 1)
		{
			if (next != null)
				return next;
			else if (forceCreation)
				return createSprite(ancestor, nextName);
		}
		else
		{
			const nextPath:Array = path.concat();
			nextPath.shift();
			if (next is DisplayObjectContainer)
			{
				return resolvePathArray(next as DisplayObjectContainer, nextPath, forceCreation);
			}
			else if (forceCreation)
			{
				if (next == null)
					return resolvePathArray(createSprite(ancestor, nextName), nextPath, true);
				else
					throw new IllegalOperationError("Cannot create a child in display object: " + next);
			}
		}
		return null;
		}
}
