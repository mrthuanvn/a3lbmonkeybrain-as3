package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.assert.assert;
	import a3lbmonkeybrain.brainstem.assert.assertEqual;
	import a3lbmonkeybrain.brainstem.assert.assertType;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	import flash.errors.IllegalOperationError;
	
	import flexunit.framework.TestCase;

	public final class ArrayListTest extends TestCase
	{
		private static function isEven(n:Number, ...args):Boolean
		{
			return n / 2 == Math.floor(n / 2);
		}
		private static function isOdd(n:Number, ...args):Boolean
		{
			return !isEven(n);
		}
		public function testAdd():void
		{
			const list:MutableList = new ArrayList();
			list.add(1);
			assertEquals(1, list.size);
			assertEquals(1, list[0]);
		}
		public function testAddMembers():void
		{
			const list:MutableList = ArrayList.fromObject(EmptyList.INSTANCE);
			assert(list.empty);
			list.addMembers([1, 2, 3]);
			assertEquals(3, list.size);
			assertEquals(1, list[0]);
			assertEquals(2, list[1]);
			assertEquals(3, list[2]);
		}
		public function testClear():void
		{
			const list:MutableList = new ArrayList();
			list.addMembers([1, 2, 3]);
			list.clear();
			assertEquals(0, list.size);
		}
		public function testEmpty():void
		{
			const list:MutableList = new ArrayList();
			assert(list.empty);
			list.add(1);
			assert(!list.empty);
		}
		public function testEquals():void
		{
			const list:MutableList = ArrayList.fromObject([1, 2, 3]);
			assert(list.equals(list));
			const list2:MutableList = new ArrayList();
			assert(!list.equals(list2));
			list2.addMembers(list);
			assert(list.equals(list2));
			list.clear();
			assert(!list.equals(list2));
			list2.clear();
			assert(list.equals(list2));
		}
		public function testEvery():void
		{
			const list:MutableList = ArrayList.fromObject([1, 2, 3]);
			assert(!list.every(isEven));
			assert(!list.every(isOdd));
			list.clear();
			list.addMembers([2, 4, 6]);
			assert(list.every(isEven));
			assert(!list.every(isOdd));
			list.clear();
			list.addMembers([3, 5, 7]);
			assert(!list.every(isEven));
			assert(list.every(isOdd));
		}
		public function testFilter():void
		{
			const list:MutableList = ArrayList.fromObject([1, 2, 3, 4]);
			assertEqual(list.filter(isOdd), ArrayList.fromObject([1, 3]), true);
			assertEqual(list.filter(isEven), ArrayList.fromObject([2, 4]), true);
		}
		public function testForEach():void
		{
			const list:MutableList = ArrayList.fromObject([2, 4, 6, 8]);
			var total:uint = 0;
			list.forEach(assertEven);
			assertEqual(4, total);
			
			function assertEven(x:Number, ...args):void
			{
				assert(isEven(x));
				++total;
			}
		}
		public function testGetMember():void
		{
			const list:MutableList = ArrayList.fromObject([2, 4, 6, 8]);
			assertEquals(list.getMember(0), 2);
			assertEquals(list.getMember(1), 4);
			assertEquals(list.getMember(2), 6);
			assertEquals(list.getMember(3), 8);
			assertEquals(list[0], 2);
			assertEquals(list[1], 4);
			assertEquals(list[2], 6);
			assertEquals(list[3], 8);
		}
		public function testHas():void
		{
			const list:MutableList = ArrayList.fromObject([1, 2, 3]);
			assert(list.has(1));
			assert(list.has(2));
			assert(list.has(3));
			assert(!list.has(0));
			assert(!list.has(null));
			assert(!list.has(list));
		}
		public function testMakeMutable():void
		{
			var list:MutableList = ArrayList.makeMutable(EmptyList.INSTANCE);
			assert(list.empty);
			list.add(1);
			assertEqual(list, ArrayList.fromObject([1]), true);
			list = ArrayList.makeMutable(HashSet.fromObject([1, 2, 3]));
			assertEqual(3, list.size);
			list.add(4);
			assertEqual(4, list.size);
			list.remove(2);
			assertEqual(3, list.size);
			delete list[0];
			assertEqual(list, ArrayList.fromObject([3, 4]), true);
		}
		public function testMap():void
		{
			var list:FiniteCollection = ArrayList.fromObject([0, 1, 2, 3]);
			list = list.map(double) as FiniteCollection;
			assertEqual(list, ArrayList.fromObject([0, 2, 4, 6]), true);
			
			function double(x:Number, ...args):Number
			{
				return 2 * x;
			}
		}
		public function testRemove():void
		{
			var list:ArrayList = ArrayList.fromObject([0, 1, 1, 1]);
			list.remove(1);
			assertEqual(1, list.size);
			assertEqual(0, list[0]);
			list.add(1);
			list.add(2);
			delete list[1];
			assertEqual(list, ArrayList.fromObject([0, 2]), true);
			delete list[1];
			assertEqual(list, ArrayList.fromObject([0]), true);
			delete list[0];
			assertEqual(list, EmptyList.INSTANCE, true);
		}
		public function testRemoveMembers():void
		{
			const list:ArrayList = ArrayList.fromObject([0, 1, 2, 3, 4, 5, 6, 7, 8]);
			list.removeMembers([0, 2, 4, 6, 8]);
			assertEqual(4, list.size);
			assertEqual(list, ArrayList.fromObject([1, 3, 5, 7]), true);
		}
		public function testSingleMember():void
		{
			const list:ArrayList = ArrayList.fromObject([6]);
			assertEquals(1, list.size);
			assertEquals(6, list.singleMember);
			list.clear();
			var error:Error;
			try
			{
				list.singleMember;
			}
			catch (e:IllegalOperationError)
			{
				error = e;
			}
			assertType(error, IllegalOperationError);
		}
		public function testSize():void
		{
			assertEqual(0, new ArrayList().size);
			assertEqual(1, ArrayList.fromObject([0]).size);
			assertEqual(2, ArrayList.fromObject([0, 0]).size);
			assertEqual(3, ArrayList.fromObject([0, 1, 0]).size);
		}
		public function testSome():void
		{
			const list:ArrayList = ArrayList.fromObject([1, 2, 3]);
			assert(list.some(isEven));
			assert(list.some(isOdd));
			list.remove(2);
			assert(!list.some(isEven));
			assert(list.some(isOdd));
			list.clear();
			assert(!list.some(isEven));
			assert(!list.some(isOdd));
		}
		public function testToArray():void
		{
			const list:ArrayList = ArrayList.fromObject([1, 2, 3]);
			assert(Equality.arraysEqual(list.toArray(), [1, 2, 3]));
		}
	}
}