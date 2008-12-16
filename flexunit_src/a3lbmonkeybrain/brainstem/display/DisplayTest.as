package a3lbmonkeybrain.brainstem.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import flexunit.framework.TestCase;
	
	/**
	 * @private
	 */
	public final class DisplayTest extends TestCase
	{
		public function testCreateSprite():void
		{
			var name:String = "sprite";
			var parent:DisplayObjectContainer = new Sprite();
			var sprite:Sprite = createSprite(parent, name);
			assertTrue("sprite exists in Sprite", sprite is Sprite);
			assertEquals("parent (Sprite)", sprite.parent, parent);
			assertEquals("name (Sprite)", sprite.name, name);
			parent = new MovieClip();
			sprite = createSprite(parent, name);
			assertTrue("sprite exists in MovieClip", sprite is Sprite);
			assertEquals("parent (MovieClip)", sprite.parent, parent);
			assertEquals("name (MovieClip)", sprite.name, name);
		}
		public function testFindPath():void
		{
			var grandparent:DisplayObjectContainer = new Sprite();
			grandparent.name = "grandparent";
			var parent:DisplayObjectContainer = createSprite(grandparent, "parent");
			var child:DisplayObjectContainer = createSprite(parent, "child");
			assertEquals(findPath(child, grandparent), "parent.child");
			assertEquals(findPath(child), "grandparent.parent.child");
			assertEquals(findPath(child, parent), "child");
			assertEquals(findPath(child, child), "");
			assertEquals(findPath(parent, child), "grandparent.parent");
			assertEquals(findPath(parent), "grandparent.parent");
			assertEquals(findPath(parent, grandparent), "parent");
			assertEquals(findPath(parent, parent), "");
		}
		public function testFindAncestor():void
		{
			var grandparent:DisplayObjectContainer = new MovieClip();
			var parentSprite:Sprite = createSprite(grandparent, "parentSprite");
			var parentContainer:DisplayObjectContainer = new MovieClip();
			parentContainer.name = "parentContainer";
			grandparent.addChild(parentContainer);
			var childSprite:Sprite = createSprite(parentSprite, "childSprite");
			var childSprite2:Sprite = createSprite(parentContainer, "childSprite2");
			var childClip:DisplayObjectContainer = new MovieClip();
			childClip.name = "childClip";
			parentContainer.addChild(childClip);
			assertEquals(findAncestor(parentSprite, MovieClip), grandparent);
			assertEquals(findAncestor(parentContainer, MovieClip), grandparent);
			assertEquals(findAncestor(childSprite, MovieClip), grandparent);
			assertEquals(findAncestor(childSprite2, MovieClip), parentContainer);
			assertEquals(findAncestor(childClip, MovieClip), parentContainer);
			assertNull(findAncestor(childClip, String));
			assertNull(findAncestor("", String));
			assertNull(findAncestor(grandparent, DisplayObjectContainer));
			assertEquals(findAncestor(parentContainer, DisplayObjectContainer), grandparent);
		}
		public function testResolvePath():void
		{
			var grandparent:DisplayObjectContainer = new Sprite();
			var parent:Sprite = createSprite(grandparent, "parent");
			var child:Sprite = createSprite(parent, "child");
			assertEquals(resolvePath(grandparent), grandparent);
			assertEquals(resolvePath(grandparent, ""), grandparent);
			assertEquals(resolvePath(grandparent, "."), grandparent);
			assertEquals(resolvePath(grandparent, "parent"), parent);
			assertEquals(resolvePath(grandparent, "parent.child"), child);
			assertEquals(resolvePath(parent, "."), parent);
			assertEquals(resolvePath(parent, "child"), child);
			assertEquals(resolvePath(child, "."), child);
			assertNull(resolvePath(grandparent, "child", false));
			assertNull(resolvePath(parent, "parent", false));
			var parent2:DisplayObject = resolvePath(grandparent, "parent2"); 
			assertTrue(parent2 is Sprite);
			assertEquals(parent2.name, "parent2");
			assertEquals(resolvePath(grandparent, "parent2"), parent2);
		}
	}
}