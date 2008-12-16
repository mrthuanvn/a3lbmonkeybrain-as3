package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.assert.AssertionError;
	import a3lbmonkeybrain.brainstem.assert.assert;
	import a3lbmonkeybrain.brainstem.assert.assertEqual;
	import a3lbmonkeybrain.brainstem.assert.assertType;
	
	import flash.errors.IllegalOperationError;
	
	import flexunit.framework.TestCase;

	public final class EmptySetTest extends TestCase
	{
		public function testAll():void
		{
			with (EmptySet.INSTANCE)
			{
				assert(empty);
				assertEqual(0, size);
			}
			var s:HashSet = HashSet.fromObject([1, 2, 3]);
			assertEqual(EmptySet.INSTANCE, EmptySet.INSTANCE.diff(s), true);
			assertEqual(EmptySet.INSTANCE, EmptySet.INSTANCE.diff([1, 2, 3]), true);
			assertEqual(s, s.diff(EmptySet.INSTANCE), true);
			assertEqual(EmptySet.INSTANCE, EmptySet.INSTANCE.intersect(s), true);
			assertEqual(EmptySet.INSTANCE, EmptySet.INSTANCE.intersect(EmptySet.INSTANCE), true);
			assertEqual(EmptySet.INSTANCE, EmptySet.INSTANCE.intersect([1, 2, 3]), true);
			assertEqual(EmptySet.INSTANCE, EmptySet.INSTANCE, true);
			assertEqual(EmptySet.INSTANCE, new EmptySet(), true);
			assertEqual(EmptySet.INSTANCE, new HashSet(), true);
			assert(!EmptySet.INSTANCE.equals(EmptyList.INSTANCE));
			assert(!EmptySet.INSTANCE.equals(new Object()));
			assert(!EmptySet.INSTANCE.equals(new ArrayList()));
			for each (var x:* in EmptySet.INSTANCE)
			{
				throw new AssertionError("Element in empty collection.");
			}
			var error:IllegalOperationError = null;
			try
			{
				EmptySet.INSTANCE.singleMember;
			}
			catch (e:IllegalOperationError)
			{
				error = e;
			}
			assertType(error, IllegalOperationError);
		}
	}
}