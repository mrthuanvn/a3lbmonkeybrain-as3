package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.calculia.collections.operations.Operation;
	
	public interface OperationResolver
	{
		function getOperation(mathML:XML):Operation;
	}
}