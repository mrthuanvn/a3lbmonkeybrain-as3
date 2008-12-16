package a3lbmonkeybrain.brainstem.w3c.mathml
{
	import a3lbmonkeybrain.brainstem.w3c.xml.XMLError;
	
	public class MathMLError extends XMLError
	{
		public function MathMLError(message:String)
		{
			super(message);
			name = "MathML Error";
		}
	}
}