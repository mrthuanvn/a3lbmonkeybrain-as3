package a3lbmonkeybrain.calculia.ui.mathml
{
	public final class OperatorStyleForm
	{
		public static const FENCE:String = "fence";
		public static const INFIX:String = "infix";
		public static const POSTFIX:String = "postfix";
		public static const PREFIX:String = "prefix";
		public static function isValidForm(s:String):Boolean
		{
			return s == FENCE || s == INFIX || s == POSTFIX || s == PREFIX;
		}
	}
}