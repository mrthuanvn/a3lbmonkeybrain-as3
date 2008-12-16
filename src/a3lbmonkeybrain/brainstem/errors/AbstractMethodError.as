package a3lbmonkeybrain.brainstem.errors
{
	import flash.errors.IllegalOperationError;

	public class AbstractMethodError extends IllegalOperationError
	{
		public function AbstractMethodError(message:String = "This method has not been implemented. It should be overridden.")
		{
			super(message);
			name = "Unimplemented Method Error";
		}
	}
}