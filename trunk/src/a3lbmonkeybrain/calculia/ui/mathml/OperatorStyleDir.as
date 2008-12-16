package a3lbmonkeybrain.calculia.ui.mathml
{
	public final class OperatorStyleDir
	{
		public static const HTL:String = "htl";
		public static const LTR:String = "ltr";
		public static const LTH:String = "lth";
		public static const RTL:String = "rtl";
		public static function isValidDir(s:String):Boolean
		{
			return s == HTL || s == LTR || s == LTH || s == RTL;
		}
		public static function isHorizontal(s:String):Boolean
		{
			return s == LTR || s == RTL;
		}
		public static function isVertical(s:String):Boolean
		{
			return s == HTL || s == LTH;
		}
	}
}