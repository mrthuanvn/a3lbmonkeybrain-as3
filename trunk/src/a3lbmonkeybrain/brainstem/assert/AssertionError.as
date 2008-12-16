package a3lbmonkeybrain.brainstem.assert
{
	/**
	 * Error which signifies a failed assertion.
	 * 
	 * @author T. Michael Keesey
	 * @see	Assertion
	 */
	public class AssertionError extends Error
	{
		/**
		 * Creates a new instance.
		 * 
		 * @param message
		 * 		 A string associated with the assertion.
		 */
		public function AssertionError(message:String = "")
		{
			super(message);
			name = "Assertion Error";
		}
	}
}