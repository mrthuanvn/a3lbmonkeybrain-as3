package a3lbmonkeybrain.brainstem.math
{
	public class MathImplError extends Error
	{
		public function MathImplError(message:String)
		{
			super(message);
			name = "Mathematical Implementation Error";
		}
	}
}