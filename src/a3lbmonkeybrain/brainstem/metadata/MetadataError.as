package a3lbmonkeybrain.brainstem.metadata
{
	public class MetadataError extends Error
	{
		public function MetadataError(message:String = "")
		{
			super(message);
			name = "Metadata Error";
		}
	}
}