package a3lbmonkeybrain.brainstem.core
{
	import flash.display.Sprite;
	
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class BrainstemTest extends TestCase
	{
		public function testFindClass():void
		{
			assertEquals(findClass(undefined), null);
			assertEquals(findClass(null), null);
			assertEquals(findClass(""), String);
			assertEquals(findClass(1), int);
			assertEquals(findClass(1.2), Number);
			assertEquals(findClass([]), Array);
			assertEquals(findClass({}), Object);
			assertEquals(findClass(new Sprite()), Sprite);
			assertEquals(findClass(Sprite), Sprite);
			assertEquals(findClass(Math), Math);
		}
		public function testFindClassName():void
		{
			assertEquals(findClassName(undefined), "");
			assertEquals(findClassName(null), "");
			assertEquals(findClassName(""), "String");
			assertEquals(findClassName(1), "int");
			assertEquals(findClassName(1.2), "Number");
			assertEquals(findClassName([]), "Array");
			assertEquals(findClassName({}), "Object");
			assertEquals(findClassName(new Sprite()), "Sprite");
			assertEquals(findClassName(Sprite), "Sprite");
			assertEquals(findClassName(Math), "Math");
		}
		public function testClone():void
		{
			var x:Object = {a:1, b:2};
			var y:Object = clone(x);
			assertEquals(x.a, y.a);
			assertEquals(x.b, y.b);
			var dateA:Date = new Date();
			var dateB:Date = clone(dateA) as Date;
			assertEquals(dateA.time, dateB.time);
			var arrayA:Array = [1, 2, 3];
			var arrayB:Array = clone(arrayA) as Array;
			assertEquals(arrayA.length, arrayB.length);
			assertEquals(arrayA[0], arrayB[0]);
			assertEquals(arrayA[1], arrayB[1]);
			assertEquals(arrayA[2], arrayB[2]);
		}
	}
}