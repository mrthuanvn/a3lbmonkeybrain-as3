package a3lbmonkeybrain.calculia.collections.graphs
{
	import a3lbmonkeybrain.brainstem.collections.EmptySet;
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	
	import flash.utils.getTimer;
	
	import flexunit.framework.TestCase;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class NetworkTest extends TestCase
	{
		private var network:Network;
		override public function setUp():void
		{
			var arcs:Array = [
				[0, 1, 1],
				[0, 7, 1],
				[1, 2, 1],
				[1, 5, 1],
				[1, 6, 1],
				[2, 3, 1],
				[2, 4, 1],
				[5, 3, 1],
				[5, 4, 1],
				[7, 6, 1],
				[7, 8, 1],
				[7, 12, 1],
				[8, 9, 1],
				[8, 13, 1],
				[9, 10, 1],
				[9, 11, 1],
				[12, 13, 1],
				[13, 14, 1],
				[13, 15, 1]
			];
			network = new Network(arcs);
		}
		private function createRandomSubset():HashSet
		{
			var s:HashSet = new HashSet();
			const vertices:FiniteCollection = network.getMember(0) as FiniteCollection;
			var candidates:Array = vertices.toArray();
			var l:int = Math.floor(Math.random() * vertices.size);
			for (var i:int = 0; i < l; ++i)
			{
				var p:int = Math.floor(Math.random() * candidates.length);
				var element:Object = candidates[p];
				s.add(element);
				candidates.splice(p, 1);
			}
			return s;
		}
		public function testFindAllAncestors():void
		{
			var s1:HashSet = HashSet.fromObject([4]);
			var s2:HashSet = HashSet.fromObject([2, 4, 5]);
			assertTrue(network.findAllAncestors(s1).equals(network.findAllAncestors(s2)));
			assertTrue(network.findAncestors(4).equals(network.findAllAncestors(s2)));
			assertTrue(network.findAncestors(4).equals(network.findAllAncestors(s1)));
			s1 = HashSet.fromObject([2, 15]);
			s2 = HashSet.fromObject([2, 1, 0, 15, 13, 8, 12, 7]);
			assertTrue(s2.equals(network.findAllAncestors(s1)));
			assertTrue(s2.equals(network.findAllAncestors(s2)));
		}
		public function testFindAllAncestors_speed():void
		{
			var total:int = 0;
			for (var i:int = 0; i < 200; ++i)
			{
				var s:FiniteSet = createRandomSubset();
				var t:int = getTimer();
				s = network.findAllAncestors(s);
				total += getTimer() - t;
			}
			trace("findAllAncestors: " + total + " ms");
		}
		public function testFindAllDescendants():void
		{
			var s1:HashSet = HashSet.fromObject([1]);
			var s2:HashSet = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			assertTrue(s2.equals(network.findAllDescendants(s1)));
			assertTrue(s2.equals(network.findAllDescendants(s2)));
			s1 = HashSet.fromObject([0]);
			assertTrue(network.findAllDescendants(s1).equals(network[0]));
			s1 = HashSet.fromObject([6]);
			assertTrue(network.findAllDescendants(s1).equals(s1));
		}
		public function testFindAncestors():void
		{
			var expected:HashSet = HashSet.fromObject([0, 1, 2, 4, 5]);
			assertTrue(expected.equals(network.findAncestors(4)));
			expected = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.findAncestors(0)));
			expected = HashSet.fromObject([0, 1, 6, 7]);
			assertTrue(expected.equals(network.findAncestors(6)));
			expected = HashSet.fromObject([0, 1]);
			assertTrue(expected.equals(network.findAncestors(1)));
			expected = HashSet.fromObject([0, 7]);
			assertTrue(expected.equals(network.findAncestors(7)));
			expected = HashSet.fromObject([0, 7, 8, 9]);
			assertTrue(expected.equals(network.findAncestors(9)));
			expected = HashSet.fromObject([0, 7, 8, 9, 10]);
			assertTrue(expected.equals(network.findAncestors(10)));
			expected = HashSet.fromObject([0, 7, 8, 12, 13, 14]);
			assertTrue(expected.equals(network.findAncestors(14)));
		}
		public function testFindApomorphyAncestor():void
		{
			var charSet:FiniteSet = HashSet.fromObject([8, 9, 10, 11, 12, 13]);
			var specifierSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([8]);
			var ancestor:FiniteSet = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([11, 15]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(ancestor.empty);
			
			specifierSet = new HashSet();
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(ancestor.empty);
			
			charSet = HashSet.fromObject([1, 2, 3, 4, 9, 10, 11]);
			specifierSet = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([9]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([3]);
			expected = HashSet.fromObject([1]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([4]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([2]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([3, 4]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([1]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([4, 10]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(ancestor.empty);
			
			charSet = HashSet.fromObject([8, 12, 13, 15]);
			specifierSet = HashSet.fromObject([15]);
			expected = HashSet.fromObject([8, 12]);
			ancestor = network.findApomorphyAncestor(charSet, specifierSet);
			assertTrue(expected.equals(ancestor));
		}
		public function testFindApomorphyClade():void
		{
			var charSet:FiniteSet = HashSet.fromObject([8, 9, 10, 11, 12, 13]);
			var specifierSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			var clade:FiniteSet = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([11, 15]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(clade.empty);
			
			specifierSet = new HashSet();
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(clade.empty);
			
			charSet = HashSet.fromObject([1, 2, 3, 4, 9, 10, 11]);
			specifierSet = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([9, 10, 11]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([3]);
			expected = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([4]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([2]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([3, 4]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([1]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
			
			specifierSet = HashSet.fromObject([4, 10]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(clade.empty);
			
			charSet = HashSet.fromObject([8, 12, 13, 15]);
			specifierSet = HashSet.fromObject([15]);
			expected = HashSet.fromObject([8, 9, 10, 11, 12, 13, 14, 15]);
			clade = network.findApomorphyClade(charSet, specifierSet);
			assertTrue(expected.equals(clade));
		}
		public function testFindBranchAncestor():void
		{
			var inSet:FiniteSet = HashSet.fromObject([10]);
			var outSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([10]);
			var ancestor:FiniteSet = network.findBranchAncestor(inSet, outSet);
			assertTrue(expected.equals(ancestor));
			
			outSet = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([8]);
			ancestor = network.findBranchAncestor(inSet, outSet);
			assertTrue(expected.equals(ancestor));
			
			inSet = HashSet.fromObject([4, 6]);
			outSet = HashSet.fromObject([3]);
			ancestor = network.findBranchAncestor(inSet, outSet);
			assertTrue(ancestor.empty);
			
			inSet = HashSet.fromObject([3, 4]);
			outSet = HashSet.fromObject([6]);
			expected = HashSet.fromObject([2, 5]);
			ancestor = network.findBranchAncestor(inSet, outSet);
			assertTrue(expected.equals(ancestor));
		}
		public function testFindBranchClade():void
		{
			var inSet:FiniteSet = HashSet.fromObject([10]);
			var outSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([10]);
			var clade:FiniteSet = network.findBranchClade(inSet, outSet);
			assertTrue(expected.equals(clade));
			
			outSet = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			clade = network.findBranchClade(inSet, outSet);
			assertTrue(expected.equals(clade));
			
			inSet = HashSet.fromObject([4, 6]);
			outSet = HashSet.fromObject([3]);
			clade = network.findBranchClade(inSet, outSet);
			assertTrue(clade.empty);
			
			inSet = HashSet.fromObject([3, 4]);
			outSet = HashSet.fromObject([6]);
			expected = HashSet.fromObject([2, 3, 4, 5]);
			clade = network.findBranchClade(inSet, outSet);
			assertTrue(expected.equals(clade));
		}
		public function testFindChildren():void
		{
			var expected:FiniteSet = HashSet.fromObject([1, 7]);
			var children:FiniteSet = network.findChildren(0);
			assertTrue(expected.equals(children));
			
			expected = HashSet.fromObject([6, 8, 12]);
			children = network.findChildren(7);
			assertTrue(expected.equals(children));
			
			children = network.findChildren(14);
			assertTrue(children.empty);
		}
		public function testFindClade():void
		{
			var ancestor:FiniteSet = new HashSet();
			assertTrue(network.findClade(ancestor).empty);
			
			ancestor = HashSet.fromObject([3, 4]);
			assertTrue(network.findClade(ancestor).empty);
			
			ancestor = HashSet.fromObject([7, 8]);
			trace("Clade(" + ancestor + ") = " +  network.findClade(ancestor));
			assertTrue(network.findClade(ancestor).empty);
			
			ancestor = HashSet.fromObject([9, 10]);
			assertTrue(network.findClade(ancestor).empty);
			
			ancestor = HashSet.fromObject([3]);
			var clade:FiniteSet = network.findClade(ancestor);
			assertTrue(ancestor.equals(clade));
			
			ancestor = HashSet.fromObject([1]);
			var expected:FiniteSet = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			clade = network.findClade(ancestor);
			assertTrue(expected.equals(clade));
			
			ancestor = HashSet.fromObject([2, 5]);
			expected = HashSet.fromObject([2, 3, 4, 5]);
			clade = network.findClade(ancestor);
			assertTrue(expected.equals(clade));
			
			ancestor = HashSet.fromObject([0]);
			expected = network[0];
			clade = network.findClade(ancestor);
			assertTrue(expected.equals(clade));
		}
		public function testFindCommonAncestors():void
		{
			var specifiers:FiniteSet = HashSet.fromObject([2]);
			var expected:FiniteSet = HashSet.fromObject([0, 1, 2]);
			var ancestors:FiniteSet = network.findCommonAncestors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([0, 7, 8, 9]);
			ancestors = network.findCommonAncestors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([10, 15]);
			expected = HashSet.fromObject([0, 7, 8]);
			ancestors = network.findCommonAncestors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([3, 4, 6]);
			expected = HashSet.fromObject([0, 1]);
			ancestors = network.findCommonAncestors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([6, 15]);
			expected = HashSet.fromObject([0, 7]);
			ancestors = network.findCommonAncestors(specifiers);
			assertTrue(expected.equals(ancestors));
		}
		public function testFindCommonDescendants():void
		{
			var specifiers:FiniteSet = HashSet.fromObject([8, 12]);
			var expected:FiniteSet = HashSet.fromObject([13, 14, 15]);
			var descendants:FiniteSet = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([8]);
			expected = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([10]);
			expected = HashSet.fromObject([10]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([10, 1]);
			expected = HashSet.fromObject([]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([1, 8]);
			expected = HashSet.fromObject([]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([8, 9]);
			expected = HashSet.fromObject([9, 10, 11]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([1, 7]);
			expected = HashSet.fromObject([6]);
			descendants = network.findCommonDescendants(specifiers);
			assertTrue(expected.equals(descendants));
		}
		public function testFindCrown():void
		{
			var extant:FiniteSet = HashSet.fromObject([6, 14, 15]);
			
			var specifiers:FiniteSet;
			var expected:FiniteSet;
			var clade:FiniteSet;
			
			specifiers = HashSet.fromObject([8]);
			expected = HashSet.fromObject([13, 14, 15]);
			clade = network.findCrown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([9]);
			expected = HashSet.fromObject([]);
			clade = network.findCrown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 4]);
			expected = HashSet.fromObject([]);
			clade = network.findCrown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([0]);
			expected = HashSet.fromObject([6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
			clade = network.findCrown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([6, 10]);
			expected = HashSet.fromObject([6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
			clade = network.findCrown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([6]);
			clade = network.findCrown(specifiers, extant);
			assertTrue(expected.equals(clade));
		}
		public function testFindMaximal():void
		{
			var expected:HashSet = HashSet.fromObject([3, 4, 6, 10, 11, 14, 15]);
			assertTrue(expected.equals(network.findMaximal(network[0] as HashSet)));
			
			var pool:HashSet = HashSet.fromObject([7, 8, 12, 13]);
			expected = HashSet.fromObject([13]);
			assertTrue(expected.equals(network.findMaximal(pool)));
			
			pool = HashSet.fromObject([0, 2, 10]);
			expected = HashSet.fromObject([2, 10]);
			assertTrue(expected.equals(network.findMaximal(pool)));
			
			pool = HashSet.fromObject([9, 10, 11, 2, 3, 4]);
			expected = HashSet.fromObject([3, 4, 10, 11]);
			assertTrue(expected.equals(network.findMaximal(pool)));
		}
		public function testFindMinimal():void
		{
			var expected:HashSet = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.findMinimal(network[0] as HashSet)));
			
			var pool:HashSet = HashSet.fromObject([7, 8, 12, 13]);
			expected = HashSet.fromObject([7]);
			assertTrue(expected.equals(network.findMinimal(pool)));
			
			pool = HashSet.fromObject([0, 2, 10]);
			expected = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.findMinimal(pool)));
			
			pool = HashSet.fromObject([9, 10, 11, 2, 3, 4]);
			expected = HashSet.fromObject([2, 9]);
			assertTrue(expected.equals(network.findMinimal(pool)));
		}
		public function testFindNodeAncestor():void
		{
			var specifiers:FiniteSet;
			var expected:FiniteSet;
			var ancestor:FiniteSet;
			
			specifiers = HashSet.fromObject([3, 4]);
			expected = HashSet.fromObject([2, 5]);
			ancestor = network.findNodeAncestor(specifiers);
			assertTrue(expected.equals(ancestor));
			
			specifiers = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([1]);
			ancestor = network.findNodeAncestor(specifiers);
			assertTrue(expected.equals(ancestor));
			
			specifiers = HashSet.fromObject([8, 9]);
			expected = HashSet.fromObject([8]);
			ancestor = network.findNodeAncestor(specifiers);
			assertTrue(expected.equals(ancestor));
			
			specifiers = HashSet.fromObject([3, 6, 10]);
			expected = HashSet.fromObject([0]);
			ancestor = network.findNodeAncestor(specifiers);
			assertTrue(expected.equals(ancestor));
		}
		public function testFindNodeClade():void
		{
			var specifiers:FiniteSet;
			var expected:FiniteSet;
			var clade:FiniteSet;
			
			specifiers = HashSet.fromObject([3, 4]);
			expected = HashSet.fromObject([2, 3, 4, 5]);
			clade = network.findNodeClade(specifiers);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			clade = network.findNodeClade(specifiers);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([8, 9]);
			expected = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			clade = network.findNodeClade(specifiers);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 6, 10]);
			expected = network[0] as HashSet;
			clade = network.findNodeClade(specifiers);
			assertTrue(expected.equals(clade));
		}
		public function testFindParents():void
		{
			var expected:HashSet;
			
			expected = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.findParents(7)));
			
			expected = HashSet.fromObject([2, 5]);
			assertTrue(expected.equals(network.findParents(3)));
			
			expected = HashSet.fromObject([1, 7]);
			assertTrue(expected.equals(network.findParents(6)));
		}
		public function testFindPaths():void
		{
			assertEquals(0, network.findPaths(1, 7).size);
			assertEquals(2, network.findPaths(0, 6).size);
			assertEquals(2, network.findPaths(0, 14).size);
			assertEquals(1, network.findPaths(0, 5).size);
			assertEquals(1, network.findPaths(8, 14).size);
			assertEquals(2, network.findPaths(1, 4).size);
			assertEquals(1, network.findPaths(2, 4).size);
		}
		public function testFindSynapomorphicAncestors():void
		{
			// :TODO:
		}
		public function testFindTotal():void
		{
			var extant:FiniteSet = HashSet.fromObject([6, 14, 15]);
			
			var expected:FiniteSet;
			var specifiers:FiniteSet;
			
			var total:FiniteSet;
			
			specifiers = HashSet.fromObject([14, 15]);
			expected = HashSet.fromObject([8, 9, 10, 11, 12, 13, 14, 15]);
			total = network.findTotal(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([6]);
			expected = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			total = network.findTotal(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([8]);
			expected = HashSet.fromObject([8, 9, 10, 11, 12, 13, 14, 15]);
			total = network.findTotal(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([9]);
			expected = EmptySet.INSTANCE;
			total = network.findTotal(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([10]);
			expected = EmptySet.INSTANCE;
			total = network.findTotal(specifiers, extant);
			assertTrue(expected.equals(total));
		}
		public function testProxy():void
		{
			assertTrue(network[0] is FiniteSet);
			assertTrue(network[1] is FiniteSet);
			assertEquals(16, network[0].size);
			assertEquals(19, network[1].size);
			var i:int = 0;
			for each (var s:FiniteSet in network)
			{
				assertTrue(s is FiniteSet);
				++i;
			}
			assertEquals(2, i);
		}
	}
}