package a3lbmonkeybrain.brainstem.relate
{
	import a3lbmonkeybrain.brainstem.core.Property;
	
	import flexunit.framework.TestCase;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class EqualityTest extends TestCase
	{
		public function testArrayContains():void
		{
			assertTrue(Equality.arrayContains([1], 1));
			assertTrue(Equality.arrayContains([1, 1, 1], 1));
			assertTrue(Equality.arrayContains([1, 2, 3], 1));
			assertTrue(Equality.arrayContains([3, 2, 1], 1));
			assertFalse(Equality.arrayContains([3, 2, 4, 3], 1));
			assertTrue(Equality.arrayContains([{a: 1}], {a: 1}, ["a"]));
			assertTrue(Equality.arrayContains([{a: 1}, {a: 2}], {a: 1}, ["a"]));
			assertTrue(Equality.arrayContains([{a: 2}, {a: 1}], {a: 1}, ["a"]));
			assertTrue(Equality.arrayContains([{a: 1}], {a: 1}, Property.AUTO_PROPERTIES));
			assertTrue(Equality.arrayContains([{a: 2}, {a: 1}], {a: 1}, Property.AUTO_PROPERTIES));
			assertTrue(Equality.arrayContains([{a: 1}, {a: 2}], {a: 1}, Property.AUTO_PROPERTIES));
			assertTrue(Equality.arrayContains([{a: 1, b: 2}], {a: 1, b: 3}, ["a"]));
			assertFalse(Equality.arrayContains([{a: 1, b: 2}], {a: 1, b: 3}, ["b"]));
			assertFalse(Equality.arrayContains([{a: 1, b: 2}], {a: 1, b: 3}, Property.AUTO_PROPERTIES));
			assertFalse(Equality.arrayContains([{a: 2}], {a: 1}, ["a"]));
			assertFalse(Equality.arrayContains([], {a: 1}, ["a"]));
		}
		public function testArraysEqual():void
		{
			assertTrue(Equality.arraysEqual([], []));
			assertTrue(Equality.arraysEqual([1], [1]));
			assertTrue(Equality.arraysEqual([1, 1, 1, "hello"], [1, 1, 1, "hello"]));
			assertTrue(Equality.arraysEqual([1, [2, 3]], [1, [2, 3]]));
			assertFalse(Equality.arraysEqual([], [0]));
			assertFalse(Equality.arraysEqual([1], [2]));
			assertFalse(Equality.arraysEqual([1, 1, 1, "Hello"], [1, 1, 1, "hello"]));
			assertFalse(Equality.arraysEqual([1, [2, 2]], [1, [2, 3]]));
			var a:Array = [1];
			a.push(a);
			var b:Array = [1, a];
			assertTrue(Equality.arraysEqual(a, a));
			assertTrue(Equality.arraysEqual(a, a));
			assertTrue(Equality.arraysEqual(a, b));
			assertTrue(Equality.arraysEqual(a, b));
			b.push(b);
			assertFalse(Equality.arraysEqual(a, b));
			assertFalse(Equality.arraysEqual(a, b));
			var equatableA:Equatable = new EquatableImpl(1, 2);
			var equatableB:Equatable = new EquatableImpl(1, 2);
			assertTrue(Equality.arraysEqual([equatableA, equatableB], [equatableA, equatableB]));
			assertTrue(Equality.arraysEqual([equatableA, equatableA], [equatableB, equatableB]));
			assertTrue(Equality.arraysEqual([equatableB, equatableA], [equatableA, equatableB]));
			equatableB = new EquatableImpl(2, 2);
			assertTrue(Equality.arraysEqual([equatableA, equatableB], [equatableA, equatableB]));
			assertFalse(Equality.arraysEqual([equatableA, equatableA], [equatableB, equatableB]));
			assertFalse(Equality.arraysEqual([equatableA, equatableA], [equatableA, equatableB]));
		}
		public function testEqual():void
		{
			assertTrue(Equality.equal(2, 2));
			assertTrue(Equality.equal("hello", "hello"));
			assertTrue(Equality.equal([1, 2], [1, 2]));
			assertTrue(Equality.equal([this], [this]));
			assertTrue(Equality.equal(null, null));
			assertFalse(Equality.equal(1, 2));
			assertFalse(Equality.equal("hello", "Hello"));
			assertFalse(Equality.equal([1, 2], [1, 1]));
			assertFalse(Equality.equal(this, null));
			assertFalse(Equality.equal(null, this));
			assertFalse(Equality.equal([this], [null]));
			assertFalse(Equality.equal([null], [this]));
			assertTrue(Equality.equal({a:1, b:2}, {a:1, b:2}, Property.AUTO_PROPERTIES));
			var a:Object = {aRef: null};
			a.aRef = a;
			var b:Object = {aRef: null};
			b.aRef = a;
			assertTrue(Equality.equal(a, a, Property.AUTO_PROPERTIES));
			assertTrue(Equality.equal(a, a, ["aRef"]));
			assertTrue(Equality.equal(a, b, Property.AUTO_PROPERTIES));
			assertTrue(Equality.equal(a, b, ["aRef"]));
			assertTrue(Equality.equal(a, a, Property.AUTO_PROPERTIES));
			assertTrue(Equality.equal(a, a, ["aRef"]));
			assertTrue(Equality.equal(a, b, Property.AUTO_PROPERTIES));
			assertTrue(Equality.equal(a, b, ["aRef"]));
			b.aRef = b;
			assertFalse(Equality.equal(a, b, Property.AUTO_PROPERTIES));
			assertFalse(Equality.equal(a, b, ["aRef"]));
			assertFalse(Equality.equal(a, b, Property.AUTO_PROPERTIES));
			assertFalse(Equality.equal(a, b, ["aRef"]));
			var equatableA:Equatable = new EquatableImpl(1, 2);
			var equatableB:Equatable = new EquatableImpl(1, 2);
			assertTrue(Equality.equal(equatableA, equatableA));
			assertTrue(Equality.equal(equatableB, equatableB));
			assertTrue(Equality.equal(equatableA, equatableB));
			equatableB = new EquatableImpl(1, 3);
			assertTrue(Equality.equal(equatableA, equatableA));
			assertTrue(Equality.equal(equatableB, equatableB));
			assertFalse(Equality.equal(equatableA, equatableB));
			assertTrue(Equality.equal(new Date(1976, 10, 10), new Date(1976, 10, 10)));
			assertTrue(Equality.equal(new Namespace("a3lbmonkeybrain"), new Namespace("a3lbmonkeybrain")));
			assertTrue(Equality.equal(new QName("a3lbmonkeybrain", "x"), new QName("a3lbmonkeybrain", "x")));
			assertFalse(Equality.equal(new Date(1976, 10, 10), new Date(2009, 0, 1)));
			assertFalse(Equality.equal(new Namespace("a3lbmonkeybrain"), new Namespace("3lbmonkeybrain")));
			assertFalse(Equality.equal(new QName("a3lbmonkeybrain", "x"), new QName("a3lbmonkeybrain", "y")));
		}
	}
}