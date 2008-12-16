package a3lbmonkeybrain.hippocampus.domain
{
	import flexunit.framework.TestCase;
	
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class PersistentTest extends TestCase
	{
		public static const TIMEOUT:uint = 1000;
		public function testID():void
		{
			const entity:Persistent = new TestEntity();
			assertEquals(0, entity.id);
			entity.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,
				addAsync(onIDPropertyChange, TIMEOUT));
			entity.id = 100;
		}
		private static function onIDPropertyChange(event:PropertyChangeEvent):void
		{
			assertTrue(event.target is TestEntity);
			const entity:Persistent = event.target as TestEntity;
			assertEquals(100, entity.id);
			assertEquals(PropertyChangeEventKind.UPDATE, event.kind);
			assertEquals(0, event.oldValue);
			assertEquals(100, event.newValue);
			assertEquals("id", event.property);
			assertEquals(entity, event.source);
		}
	}
}