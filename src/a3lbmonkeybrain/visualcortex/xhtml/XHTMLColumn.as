package a3lbmonkeybrain.visualcortex.xhtml
{
	import a3lbmonkeybrain.brainstem.w3c.xml.extractText;
	
	import flash.errors.IllegalOperationError;
	
	import mx.controls.dataGridClasses.DataGridColumn;
	
	public class XHTMLColumn extends DataGridColumn
	{
		private var property:String;
		public function XHTMLColumn(headerText:String = null, property:String = null, italics:Boolean = false,
			width:Number = 0.0)
		{
			super();
			this.headerText = headerText;
			this.property = property;
			if (italics)
				setStyle("font-style", "italics");
			if (width > 0.0)
				this.width = width;
			super.labelFunction = $labelFunction;
		}
		override public function set labelFunction(value:Function):void
		{
			throw new IllegalOperationError();
		}
		private function $labelFunction(item:Object, column:DataGridColumn):String
		{
			XML.prettyIndent = 0;
			XML.prettyPrinting = false;
			XML.ignoreWhitespace = false;
			var xml:XML = item[property] as XML;
			if (xml == null || xml.children().length() == 0)
				return "";
			return extractText(xml);
		}
	}
}