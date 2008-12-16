package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.brainstem.strings.trim;
	import a3lbmonkeybrain.hippocampus.domain.TestEntity;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class TestEntityReader implements EntityReader
	{
		public function TestEntityReader()
		{
			super();
		}
		public function get entityClass():Class
		{
			return TestEntity;
		}
		public function read(s:String):Object
		{
			s = trim(s);
			const parts:Array = s.split(/\s*:\s*/, 2);
			const entity:TestEntity = new TestEntity();
			entity.name = parts[0] as String;
			if (parts.length == 2)
			{
				const subParts:Array = parts[1].split(/\s*;\s*/g);
				for each (var subPart:String in subParts)
				{
					entity.children.addItem(read(subPart));
				}
			}
			return entity;
		}
	}
}