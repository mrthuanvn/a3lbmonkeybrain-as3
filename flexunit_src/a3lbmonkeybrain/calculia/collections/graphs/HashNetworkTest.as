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
	public final class HashNetworkTest extends TestCase
	{
		private var network:HashNetwork;
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
			network = HashNetwork.createFromArcs(arcs);
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
		public function testAllPredecessors():void
		{
			var s1:HashSet = HashSet.fromObject([4]);
			var s2:HashSet = HashSet.fromObject([2, 4, 5]);
			assertTrue(network.allPredecessors(s1).equals(network.allPredecessors(s2)));
			assertTrue(network.predecessors(4).equals(network.allPredecessors(s2)));
			assertTrue(network.predecessors(4).equals(network.allPredecessors(s1)));
			s1 = HashSet.fromObject([2, 15]);
			s2 = HashSet.fromObject([2, 1, 0, 15, 13, 8, 12, 7]);
			assertTrue(s2.equals(network.allPredecessors(s1)));
			assertTrue(s2.equals(network.allPredecessors(s2)));
		}
		public function testAllPredecessors_speed():void
		{
			var total:uint = 0;
			for (var i:int = 0; i < 2000; ++i)
			{
				var s:FiniteSet = createRandomSubset();
				var t:uint = getTimer();
				s = network.allPredecessors(s);
				total += getTimer() - t;
			}
			trace("allPredecessors: " + total + " ms");
		}
		public function testAllSuccessors():void
		{
			var s1:HashSet = HashSet.fromObject([1]);
			var s2:HashSet = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			assertTrue(s2.equals(network.allSuccessors(s1)));
			assertTrue(s2.equals(network.allSuccessors(s2)));
			s1 = HashSet.fromObject([0]);
			assertTrue(network.allSuccessors(s1).equals(network[0]));
			s1 = HashSet.fromObject([6]);
			assertTrue(network.allSuccessors(s1).equals(s1));
		}
		public function testPredecessors():void
		{
			var expected:HashSet = HashSet.fromObject([0, 1, 2, 4, 5]);
			assertTrue(expected.equals(network.predecessors(4)));
			expected = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.predecessors(0)));
			expected = HashSet.fromObject([0, 1, 6, 7]);
			assertTrue(expected.equals(network.predecessors(6)));
			expected = HashSet.fromObject([0, 1]);
			assertTrue(expected.equals(network.predecessors(1)));
			expected = HashSet.fromObject([0, 7]);
			assertTrue(expected.equals(network.predecessors(7)));
			expected = HashSet.fromObject([0, 7, 8, 9]);
			assertTrue(expected.equals(network.predecessors(9)));
			expected = HashSet.fromObject([0, 7, 8, 9, 10]);
			assertTrue(expected.equals(network.predecessors(10)));
			expected = HashSet.fromObject([0, 7, 8, 12, 13, 14]);
			assertTrue(expected.equals(network.predecessors(14)));
		}
		public function testApomorphyAncestor():void
		{
			var charSet:FiniteSet = HashSet.fromObject([8, 9, 10, 11, 12, 13]);
			var specifierSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([8]);
			var ancestor:FiniteSet = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([11, 15]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(ancestor.empty);
			
			specifierSet = new HashSet();
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(ancestor.empty);
			
			charSet = HashSet.fromObject([1, 2, 3, 4, 9, 10, 11]);
			specifierSet = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([9]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([3]);
			expected = HashSet.fromObject([1]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([4]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([2]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([3, 4]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([1]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
			
			specifierSet = HashSet.fromObject([4, 10]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(ancestor.empty);
			
			charSet = HashSet.fromObject([8, 12, 13, 15]);
			specifierSet = HashSet.fromObject([15]);
			expected = HashSet.fromObject([8, 12]);
			ancestor = network.minimal(network.comemberPredecessors(charSet, specifierSet));
			assertTrue(expected.equals(ancestor));
		}
		public function testBranchAncestor():void
		{
			var inSet:FiniteSet = HashSet.fromObject([10]);
			var outSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([10]);
			var ancestor:FiniteSet = network.branchCladogen(inSet, outSet);
			assertTrue(expected.equals(ancestor));
			
			outSet = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([8]);
			ancestor = network.branchCladogen(inSet, outSet);
			assertTrue(expected.equals(ancestor));
			
			inSet = HashSet.fromObject([4, 6]);
			outSet = HashSet.fromObject([3]);
			ancestor = network.branchCladogen(inSet, outSet);
			assertTrue(ancestor.empty);
			
			inSet = HashSet.fromObject([3, 4]);
			outSet = HashSet.fromObject([6]);
			expected = HashSet.fromObject([2, 5]);
			ancestor = network.branchCladogen(inSet, outSet);
			assertTrue(expected.equals(ancestor));
		}
		public function testBranchClade():void
		{
			var inSet:FiniteSet = HashSet.fromObject([10]);
			var outSet:FiniteSet = HashSet.fromObject([11]);
			var expected:FiniteSet = HashSet.fromObject([10]);
			var clade:FiniteSet = network.branchClade(inSet, outSet);
			assertTrue(expected.equals(clade));
			
			outSet = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			clade = network.branchClade(inSet, outSet);
			assertTrue(expected.equals(clade));
			
			inSet = HashSet.fromObject([4, 6]);
			outSet = HashSet.fromObject([3]);
			clade = network.branchClade(inSet, outSet);
			assertTrue(clade.empty);
			
			inSet = HashSet.fromObject([3, 4]);
			outSet = HashSet.fromObject([6]);
			expected = HashSet.fromObject([2, 3, 4, 5]);
			clade = network.branchClade(inSet, outSet);
			assertTrue(expected.equals(clade));
		}
		public function testClade():void
		{
			var ancestor:FiniteSet = new HashSet();
			assertTrue(network.clade(ancestor).empty);
			
			ancestor = HashSet.fromObject([3, 4]);
			assertTrue(network.clade(ancestor).empty);
			
			ancestor = HashSet.fromObject([7, 8]);
			assertTrue(network.clade(ancestor).empty);
			
			ancestor = HashSet.fromObject([9, 10]);
			assertTrue(network.clade(ancestor).empty);
			
			ancestor = HashSet.fromObject([3]);
			var clade:FiniteSet = network.clade(ancestor);
			assertTrue(ancestor.equals(clade));
			
			ancestor = HashSet.fromObject([1]);
			var expected:FiniteSet = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			clade = network.clade(ancestor);
			assertTrue(expected.equals(clade));
			
			ancestor = HashSet.fromObject([2, 5]);
			expected = HashSet.fromObject([2, 3, 4, 5]);
			clade = network.clade(ancestor);
			assertTrue(expected.equals(clade));
			
			ancestor = HashSet.fromObject([0]);
			expected = network[0];
			clade = network.clade(ancestor);
			assertTrue(expected.equals(clade));
		}
		public function testCommonPredecessors():void
		{
			var specifiers:FiniteSet = HashSet.fromObject([2]);
			var expected:FiniteSet = HashSet.fromObject([0, 1, 2]);
			var ancestors:FiniteSet = network.commonPredecessors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([0, 7, 8, 9]);
			ancestors = network.commonPredecessors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([10, 15]);
			expected = HashSet.fromObject([0, 7, 8]);
			ancestors = network.commonPredecessors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([3, 4, 6]);
			expected = HashSet.fromObject([0, 1]);
			ancestors = network.commonPredecessors(specifiers);
			assertTrue(expected.equals(ancestors));
			specifiers = HashSet.fromObject([6, 15]);
			expected = HashSet.fromObject([0, 7]);
			ancestors = network.commonPredecessors(specifiers);
			assertTrue(expected.equals(ancestors));
		}
		public function testCommonSuccessors():void
		{
			var specifiers:FiniteSet = HashSet.fromObject([8, 12]);
			var expected:FiniteSet = HashSet.fromObject([13, 14, 15]);
			var descendants:FiniteSet = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([8]);
			expected = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([10]);
			expected = HashSet.fromObject([10]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([10, 11]);
			expected = HashSet.fromObject([]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([10, 1]);
			expected = HashSet.fromObject([]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([1, 8]);
			expected = HashSet.fromObject([]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([8, 9]);
			expected = HashSet.fromObject([9, 10, 11]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
			
			specifiers = HashSet.fromObject([1, 7]);
			expected = HashSet.fromObject([6]);
			descendants = network.commonSuccessors(specifiers);
			assertTrue(expected.equals(descendants));
		}
		public function testCrown():void
		{
			var extant:FiniteSet = HashSet.fromObject([6, 14, 15]);
			
			var specifiers:FiniteSet;
			var expected:FiniteSet;
			var clade:FiniteSet;
			
			specifiers = HashSet.fromObject([8]);
			expected = HashSet.fromObject([13, 14, 15]);
			clade = network.crown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([9]);
			expected = HashSet.fromObject([]);
			clade = network.crown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 4]);
			expected = HashSet.fromObject([]);
			clade = network.crown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([0]);
			expected = HashSet.fromObject([6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
			clade = network.crown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([6, 10]);
			expected = HashSet.fromObject([6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
			clade = network.crown(specifiers, extant);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([6]);
			clade = network.crown(specifiers, extant);
			assertTrue(expected.equals(clade));
		}
		public function testDistance():void
		{
			assertEquals(0, network.distance(0, 0));
			assertEquals(1, network.distance(0, 1));
			assertEquals(1, network.distance(1, 0));
			assertEquals(2, network.distance(1, 4));
			assertEquals(2, network.distance(4, 1));
			assertEquals(7, network.distance(4, 15));
			assertEquals(7, network.distance(15, 4));
			assertEquals(2, network.distance(6, 8));
			assertEquals(2, network.distance(8, 6));
		}
		public function testMaximal():void
		{
			var expected:HashSet = HashSet.fromObject([3, 4, 6, 10, 11, 14, 15]);
			assertTrue(expected.equals(network.maximal(network[0] as HashSet)));
			
			var pool:HashSet = HashSet.fromObject([7, 8, 12, 13]);
			expected = HashSet.fromObject([13]);
			assertTrue(expected.equals(network.maximal(pool)));
			
			pool = HashSet.fromObject([0, 2, 10]);
			expected = HashSet.fromObject([2, 10]);
			assertTrue(expected.equals(network.maximal(pool)));
			
			pool = HashSet.fromObject([9, 10, 11, 2, 3, 4]);
			expected = HashSet.fromObject([3, 4, 10, 11]);
			assertTrue(expected.equals(network.maximal(pool)));
		}
		public function testMinimal():void
		{
			var expected:HashSet = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.minimal(network[0] as FiniteSet)));
			
			var pool:HashSet = HashSet.fromObject([7, 8, 12, 13]);
			expected = HashSet.fromObject([7]);
			assertTrue(expected.equals(network.minimal(pool)));
			
			pool = HashSet.fromObject([0, 2, 10]);
			expected = HashSet.fromObject([0]);
			assertTrue(expected.equals(network.minimal(pool)));
			
			pool = HashSet.fromObject([9, 10, 11, 2, 3, 4]);
			expected = HashSet.fromObject([2, 9]);
			assertTrue(expected.equals(network.minimal(pool)));
		}
		public function testNodeAncestor():void
		{
			var specifiers:FiniteSet;
			var expected:FiniteSet;
			var ancestor:FiniteSet;
			
			specifiers = HashSet.fromObject([3, 4]);
			expected = HashSet.fromObject([2, 5]);
			ancestor = network.nodeCladogen(specifiers);
			assertTrue(expected.equals(ancestor));
			
			specifiers = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([1]);
			ancestor = network.nodeCladogen(specifiers);
			assertTrue(expected.equals(ancestor));
			
			specifiers = HashSet.fromObject([8, 9]);
			expected = HashSet.fromObject([8]);
			ancestor = network.nodeCladogen(specifiers);
			assertTrue(expected.equals(ancestor));
			
			specifiers = HashSet.fromObject([3, 6, 10]);
			expected = HashSet.fromObject([0]);
			ancestor = network.nodeCladogen(specifiers);
			assertTrue(expected.equals(ancestor));
		}
		public function testNodeClade():void
		{
			var specifiers:FiniteSet;
			var expected:FiniteSet;
			var clade:FiniteSet;
			
			specifiers = HashSet.fromObject([3, 4]);
			expected = HashSet.fromObject([2, 3, 4, 5]);
			clade = network.nodeClade(specifiers);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 6]);
			expected = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			clade = network.nodeClade(specifiers);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([8, 9]);
			expected = HashSet.fromObject([8, 9, 10, 11, 13, 14, 15]);
			clade = network.nodeClade(specifiers);
			assertTrue(expected.equals(clade));
			
			specifiers = HashSet.fromObject([3, 6, 10]);
			expected = network[0] as HashSet;
			clade = network.nodeClade(specifiers);
			assertTrue(expected.equals(clade));
		}
		public function testPaths():void
		{
			assertEquals(0, network.paths(1, 7).size);
			assertEquals(2, network.paths(0, 6).size);
			assertEquals(2, network.paths(0, 14).size);
			assertEquals(1, network.paths(0, 5).size);
			assertEquals(1, network.paths(8, 14).size);
			assertEquals(2, network.paths(1, 4).size);
			assertEquals(1, network.paths(2, 4).size);
		}
		public function testComemberPredecessors():void
		{
			var charSet:FiniteSet = HashSet.fromObject([1, 4, 5, 6, 9]);
			
			var expected:FiniteSet;
			var specifiers:FiniteSet;
			
			var predecessors:FiniteSet;
			
			specifiers = HashSet.createSingleton(4);
			expected = HashSet.fromObject([1, 4, 5]);
			predecessors = network.comemberPredecessors(charSet, specifiers);
			assertTrue(predecessors.equals(expected));
			
			specifiers = HashSet.createSingleton(14);
			predecessors = network.comemberPredecessors(charSet, specifiers);
			assertTrue(predecessors.empty);
			
			specifiers = HashSet.fromObject([4, 14]);
			predecessors = network.comemberPredecessors(charSet, specifiers);
			assertTrue(predecessors.empty);
			
			specifiers = HashSet.createSingleton(9);
			expected = specifiers;
			predecessors = network.comemberPredecessors(charSet, specifiers);
			assertTrue(predecessors.equals(expected));
		}
		public function testTotal():void
		{
			var extant:FiniteSet = HashSet.fromObject([6, 14, 15]);
			
			var expected:FiniteSet;
			var specifiers:FiniteSet;
			
			var total:FiniteSet;
			
			specifiers = HashSet.fromObject([14, 15]);
			expected = HashSet.fromObject([8, 9, 10, 11, 12, 13, 14, 15]);
			total = network.total(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([6]);
			expected = HashSet.fromObject([1, 2, 3, 4, 5, 6]);
			total = network.total(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([8]);
			expected = HashSet.fromObject([8, 9, 10, 11, 12, 13, 14, 15]);
			total = network.total(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([9]);
			expected = EmptySet.INSTANCE;
			total = network.total(specifiers, extant);
			assertTrue(expected.equals(total));
			
			specifiers = HashSet.fromObject([10]);
			expected = EmptySet.INSTANCE;
			total = network.total(specifiers, extant);
			assertTrue(expected.equals(total));
		}
		public function testProxy():void
		{
			trace(network);
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
		public function testWeightedDistance():void
		{
			assertEquals(0, network.weightedDistance(0, 0));
			assertEquals(1, network.weightedDistance(0, 1));
			assertEquals(1, network.weightedDistance(1, 0));
			assertEquals(2, network.weightedDistance(1, 4));
			assertEquals(2, network.weightedDistance(4, 1));
			assertEquals(7, network.weightedDistance(4, 15));
			assertEquals(7, network.weightedDistance(15, 4));
			assertEquals(2, network.weightedDistance(6, 8));
			assertEquals(2, network.weightedDistance(8, 6));
		}
	}
}