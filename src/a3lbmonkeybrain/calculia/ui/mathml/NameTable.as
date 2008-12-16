package a3lbmonkeybrain.calculia.ui.mathml
{
	public interface NameTable
	{
		function resolveOpInfo(xml:XML):OperatorStyle
		function resolveXML(xml:XML, closing:Boolean = false):Object;
	}
}