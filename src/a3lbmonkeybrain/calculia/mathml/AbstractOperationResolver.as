package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	import a3lbmonkeybrain.calculia.collections.operations.Operation;
	import a3lbmonkeybrain.calculia.collections.operations.UnresolvableOperation;
	
	public class AbstractOperationResolver implements OperationResolver
	{
		protected const operationMap:Object = {}
		public function AbstractOperationResolver()
		{
			super();
			initOperationMap();
		}
		public function getOperation(mathML:XML):Operation
		{
			const operation:* = operationMap[mathML.name().toString()];
			if (operation is Operation)
				return operation as Operation;
			return new UnresolvableOperation(mathML);
		}
		protected function initOperationMap():void
		{
			throw new AbstractMethodError();
		}
	}
}