package a3lbmonkeybrain.hippocampus.ui.forms
{
	import a3lbmonkeybrain.brainstem.core.nullEventHandler;
	import a3lbmonkeybrain.brainstem.test.UITestUtil;
	import a3lbmonkeybrain.hippocampus.domain.TestEntity;
	
	import flexunit.framework.TestCase;
	
	import mx.core.Container;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class FormFactoryTest extends TestCase
	{
		private static function createEntity(name:String):TestEntity
		{
			const entity:TestEntity = new TestEntity();
			entity.name = name;
			return entity;
		}
		public function testCreateForData():void
		{
			const data:TestEntity = createEntity("Primates");
			data.children.addItem(createEntity("Lemuriformes"));
			data.children.addItem(createEntity("Tarsiiformes"));
			data.children.addItem(createEntity("Simiiformes"));
			//data.vernacular = "prime apes";
			const form:Container = new FormFactory().createForData(data);
			form.width = 500;
			UITestUtil.createTestWindow(form, "FormFactory", addAsync(nullEventHandler, int.MAX_VALUE));
		}
	}
}