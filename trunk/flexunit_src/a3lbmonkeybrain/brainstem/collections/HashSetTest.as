package a3lbmonkeybrain.brainstem.collections
{
	import flexunit.framework.TestCase;
	
	import a3lbmonkeybrain.brainstem.assert.AssertionError;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class HashSetTest extends TestCase
	{
		private static function isEven(n:Number):Boolean
		{
			return n / 2 == Math.floor(n / 2);
		}
		private static function isInteger(n:Number):Boolean
		{
			return isFinite(n) && n == Math.floor(n);
		}
		private static function isNull(n:Object):Boolean
		{
			return n == null;
		}
		public function testClear():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			set1.clear();
			assertEquals(0, set1.size);
			assertTrue(set1.empty);
			for each (var x:Object in set1)
			{
				throw new AssertionError("Member in empty set: " + x);
			}
		}
		public function testClone():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			var set2:HashSet = HashSet.clone(set1);
			var set3:HashSet = HashSet.fromObject([1, 2, 3, 4]);
			var set4:HashSet = HashSet.fromObject([1, 2, 3, 4, 6]);
			assertTrue(set1.equals(set2));
			assertTrue(set2.equals(set1));
			assertFalse(set1.equals(set3));
			assertFalse(set3.equals(set1));
			assertFalse(set1.equals(set4));
			assertFalse(set4.equals(set1));
		}
		public function testDiff():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertTrue(set1.diff(set1).empty)
			assertTrue(set1.diff(new HashSet()).equals(set1));
			var set2:HashSet = HashSet.fromObject([3, 4, 5]);
			var set3:HashSet = HashSet.fromObject([2, 1]);
			assertTrue(set1.diff(set2).equals(set3));
		}
		public function testEmpty():void
		{
			assertTrue(new HashSet().empty);
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertFalse(set1.empty);
		}
		public function testEquals():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			var set2:HashSet = HashSet.fromObject([5, 4, 2, 1, 3]);
			assertTrue(set1.equals(set2));
			assertTrue(set2.equals(set1));
			set1 = new HashSet();
			assertFalse(set1.equals(set2));
			assertFalse(set2.equals(set1));
			assertTrue(set1.equals(set1));
			assertTrue(set1.equals(new HashSet()));
			assertTrue(new HashSet().equals(set1));
		}
		public function testEvery():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertFalse(set1.every(isEven));
			assertTrue(set1.every(isInteger));
			assertFalse(set1.every(isNull));
		}
		public function testFilter():void
		{
			var set1:HashSet = HashSet.fromObject([0, 1, 2, 3, 4, 5]);
			var set2:HashSet = HashSet.fromObject([0, 2, 4]);
			assertTrue(set1.filter(isEven).equals(set2));
		}
		public function testForEach():void
		{
			var i:int = 0;
			var f:Function = function(x:Object):void
			{
				assertTrue(x is Number);
				assertTrue(isEven(x as Number));
				++i;
			}
			var s:HashSet = HashSet.fromObject([0, 2, 4, 6, 8]);
			s.forEach(f);
			assertEquals(5, i);
		}
		public function testHasMember():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertTrue(set1.has(1));
			assertTrue(set1.has(2));
			assertTrue(set1.has(3));
			assertTrue(set1.has(4));
			assertTrue(set1.has(5));
			assertFalse(set1.has(0));
			assertFalse(set1.has(set1));
		}
		public function testIntersect():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			var set2:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertTrue(set1.equals(set1.intersect(set1)));
			assertTrue(set1.equals(set1.intersect(set2)));
			assertTrue(set1.equals(set2.intersect(set1)));
			set2 = HashSet.fromObject([1, 2]);
			assertTrue(set2.equals(set2.intersect(set1)));
			assertTrue(set2.equals(set1.intersect(set2)));
			var set3:HashSet = HashSet.fromObject([1, 2, 10]);
			assertTrue(set2.equals(set3.intersect(set1)));
			assertTrue(set2.equals(set1.intersect(set3)));
			assertTrue(new HashSet().equals(set1.intersect(new HashSet())));
		}
		public function testMap():void
		{
			var mapper:Function = function(x:int):int
			{
				return x * 2;
			}
			var set1:HashSet = HashSet.fromObject([0, 1, 2, 3]);
			var set2:HashSet = HashSet.fromObject([0, 2, 4, 6]);
			assertTrue(set1.map(mapper).equals(set2));
			set1 = HashSet.fromObject([-1, 0, 1]);
			set2 = HashSet.fromObject([0, 1]);
			assertTrue(set1.map(Math.abs).equals(set2));
			mapper = function (x:*):*
			{
				if (x == mapper)
					return undefined;
				return x;
			}
			set1 = HashSet.fromObject([mapper, 1]);
			set2 = HashSet.createSingleton(1);
			assertTrue(set1.map(mapper).equals(set2));
		}
		public function testPrSubsetOf():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertFalse(set1.prSubsetOf(set1));
			var set2:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertFalse(set1.prSubsetOf(set2));
			set2 = HashSet.fromObject([1, 2, 3, 4]);
			assertFalse(set1.prSubsetOf(set2));
			assertTrue(set2.prSubsetOf(set1));
			assertFalse(set1.prSubsetOf(new HashSet()));
			assertTrue(new HashSet().prSubsetOf(set1));
			assertTrue(new HashSet().prSubsetOf(set1));
			assertFalse(new HashSet().prSubsetOf(new HashSet()));
			assertFalse(set2.prSubsetOf([1, 2, 3, 4]));
			assertFalse(set2.prSubsetOf([1, 2, 3, 4, 4]));
			assertTrue(set2.subsetOf([0, 3, 2, 1, 4, 0, 9]));
		}
		public function testSize():void
		{
			assertEquals(0, new HashSet().size);
			assertEquals(3, HashSet.fromObject([1, 2, 3]).size);
			assertEquals(2, HashSet.fromObject([1, 2, 2]).size);
		}
		public function testSome():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertTrue(set1.some(isEven));
			assertTrue(set1.some(isInteger));
			assertFalse(set1.some(isNull));
		}
		public function testSubsetOf():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertTrue(set1.subsetOf(set1));
			var set2:HashSet = HashSet.fromObject([1, 3, 4, 2, 5]);
			assertTrue(set1.subsetOf(set2));
			assertTrue(set2.subsetOf(set1));
			set2 = HashSet.fromObject([1, 2, 3, 4]);
			assertFalse(set1.subsetOf(set2));
			assertTrue(set2.subsetOf(set1));
			assertFalse(set1.subsetOf(new HashSet()));
			assertTrue(new HashSet().subsetOf(set1));
			assertTrue(new HashSet().subsetOf(new HashSet()));
			assertTrue(set2.subsetOf([1, 2, 3, 4]));
			assertTrue(set2.subsetOf([1, 2, 3, 4, 4]));
			assertTrue(set2.subsetOf([0, 3, 2, 1, 4, 0, 9]));
		}
		public function testProxy():void
		{
			var set1:HashSet = HashSet.fromObject([5, 3, 4, 1, 2]);
			var i:int = 0;
			for each (var x:Number in set1)
			{
				assertTrue(x >= 1 && x <= 5);
				assertTrue(isInteger(x));
				++i;
			}
			assertEquals(set1.size, i);
			i = 0;
			for (var z:* in set1)
			{
				assertTrue(z >= 1 && z <= 5);
				assertTrue(isInteger(z));
				++i;
			}
			assertEquals(set1.size, i);
			delete set1[1];
			assertEquals(--i, set1.size);
			set1[1] = 1;
			assertEquals(++i, set1.size);
			assertEquals(3, set1[3]);
		}
		public function testUnion():void
		{
			var set1:HashSet = HashSet.fromObject([1, 2, 3, 4, 5]);
			assertTrue(set1.equals(set1.union(set1)));
			assertTrue(set1.equals(set1.union(new HashSet())));
			assertTrue(set1.equals(set1.union(new HashSet())));
			assertTrue(set1.equals(new HashSet().union(set1)));
			var set2:HashSet = HashSet.fromObject([7, 6, 5, 4, 3]);
			var set3:HashSet = HashSet.fromObject([1, 2, 3, 4, 5, 6, 7]);
			assertTrue(set3.equals(set1.union(set2)));
			assertTrue(set3.equals(set2.union(set1)));
			assertTrue(set3.equals(set1.union(set3)));
			assertTrue(set3.equals(set3.union(set1)));
			assertTrue(set3.equals(set2.union(set3)));
			assertTrue(set3.equals(set3.union(set2)));
			assertTrue(set3.equals(set3.union([7, 6, 5, 4, 3])));
		}
	}
}