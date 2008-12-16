package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathML;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathMLError;
	
	import flash.utils.Dictionary;
	
	public class MathMLIdentifierResolver implements IdentifierResolver
	{
		protected const table:Dictionary = new Dictionary(false);
		public function MathMLIdentifierResolver()
		{
			super();
		}
		public function reset():void
		{
			for (var key:* in table)
			{
				delete table[key];
			}
		}
		public function resolveXML(ciNode:XML):Object
		{
			default xml namespace = MathML.NAMESPACE;
			const value:* = table[ciNode.@xref];
			if (value is Object)
				return Object(value);
			throw new MathMLError("Cannot find content identifier cross-reference: "
				+ String(ciNode.@xref));
		}
		public function setEntity(ciNode:XML, value:Object):void
		{
			default xml namespace = MathML.NAMESPACE;
			const id:Object = ciNode.@id;
			if (!id)
			{
				throw new MathMLError("A content identifier node requires a " + MathML.ID + " attribute: "
					+ ciNode.toXMLString());
			}
			table[id] = value;
		}
	}
}