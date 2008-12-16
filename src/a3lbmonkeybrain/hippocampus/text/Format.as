package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.brainstem.w3c.xml.extractText;
	
	public final class Format
	{
		public static const HTML_TEXT:String = "htmlText";
		public static const TEXT:String = "text";
		public function Format()
		{
			super();
			throw new TypeError();
		}
		public static function htmlTextToText(htmlText:String):String
		{
			return extractText(new XML("<html>" + htmlText + "</html>"));
		}
	}
}