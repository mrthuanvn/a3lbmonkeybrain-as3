package a3lbmonkeybrain.calculia.core
{
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	
	import flexunit.framework.TestCase;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class CalcTableTest extends TestCase
	{
		public function testAPI():void
		{
			var table:CalcTable = new CalcTable();
			assertUndefined(table.getResult(Math.sin, [Math.PI]));
			table.setResult(Math.sin, [Math.PI], Math.sin(Math.PI));
			assertEquals(Math.sin(Math.PI), table.getResult(Math.sin, [Math.PI]));
			var s:HashSet = HashSet.fromObject([1, 2, 3]);
			var t:HashSet = HashSet.fromObject([3, 4, 5]);
			var u:HashSet = s.union(t) as HashSet;
			assertUndefined(table.getResult(s.union, [s, t]));
			table.setResult(s.union, [s, t], u);
			assertEquals(u, table.getResult(s.union, [s, t]));
			assertEquals(u, table.getResult(s.union, [s, t]));
			table.reset();
			assertUndefined(table.getResult(Math.sin, [Math.PI]));
			assertUndefined(table.getResult(s.union, [s, t]));
		}
	}
}