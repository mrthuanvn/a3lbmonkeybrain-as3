package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.hippocampus.domain.TestEntity;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class TestEntityWriter extends AbstractEntityWriter
	{
		public function TestEntityWriter()
		{
			super();
		}
		override public function get entityClass():Class
		{
			return TestEntity;
		}
		override public function writeHTML(value:Object):XML
		{
			if (value is TestEntity)
			{
				const entity:TestEntity = value as TestEntity;
				XML.ignoreWhitespace = false;
				const html:XML = <span><i>{entity.name}</i></span>;
				if (entity.children.length > 0)
				{
					html.appendChild(": ");
					var first:Boolean = true;
					for each (var child:TestEntity in entity.children)
					{
						if (first)
							first = false;
						else
							html.appendChild("; ");
						html.appendChild(writeHTML(child));
					}
				}
				return html.normalize();
			}
			throw new ArgumentError();
		}
	}
}