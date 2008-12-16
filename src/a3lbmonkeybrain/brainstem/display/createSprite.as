package a3lbmonkeybrain.brainstem.display
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * Creates a sprite with a given name in a parent object.
	 *  
	 * @param parent
	 * 		Object to make the sprite in.
	 * @param name
	 * 		Name to give the sprite.
	 * @return
	 * 		New <code>Sprite</code> object.
	 * @see	flash.display.Sprite
	 * @see	flash.display.DisplayObject#name
	 */
	public function createSprite(parent:DisplayObjectContainer, name:String):Sprite
	{
		const created:Sprite = new Sprite();
		created.name = name;
		parent.addChild(created);
		return created;
	}
}