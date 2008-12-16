package a3lbmonkeybrain.brainstem.w3c.xml
{
	public class XMLError extends Error
	{
		public function XMLError(message:String)
		{
			super(message);
			name = "XML Error";
		}
	}
}