package a3lbmonkeybrain.brainstem.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * Given an ancestor object and a path, finds (and possibly creates) a display object.
	 * 
	 * @param ancestor
	 * 		Container to look in.
	 * @param path
	 * 		Period-separated list of display object names. Defaults to <code>"."</code>, in which case this
	 * 		function just returns <code>ancestor</code>.
	 * @param forceCreation
	 * 		If <code>true</code>, will create new display objects (sprites) to satisfy <code>path</code>. If
	 * 		<code>false</code>, may cause this method to return <code>null</code>.	
	 * @return
	 * 		A display object. If <code>forceCreation</code> is <code>true</code>, this may be a new
	 * 		<code>Sprite</code> object. If <code>false</code>, this may return <code>null</code>.
	 * @throws ArgumentError
	 * 		<code>ArgumentError</code>: If <code>path</code> is malformed.
	 * @throws TypeError
	 * 		<code>TypeError</code>: If <code>ancestor</code> is <code>null</code>.
	 * @throws flash.errors.IllegalOperation
	 * 		<code>flash.errors.IllegalOperation</code>: If <code>forceCreation</code> is <code>true</code> and <code>path</code> requires making a child in
	 * 		a display object that is not a container.
	 * @see flash.display.DisplayObject
	 * @see flash.display.DisplayObjectContainer
	 * @see flash.display.Sprite
	 */
	public function resolvePath(ancestor:DisplayObjectContainer, path:String = ".",
		forceCreation:Boolean = true):DisplayObject
	{
		if (path == null || path == "" || path == ".")
			return ancestor;
		return resolvePathArray(ancestor, path.split("."), forceCreation);
	}
}
