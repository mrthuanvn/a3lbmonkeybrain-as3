package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.brainstem.resolve.Unresolvable;
	import a3lbmonkeybrain.calculia.collections.operations.Operation;
	import a3lbmonkeybrain.calculia.collections.operations.UnresolvableOperation;
	
	public class CompositeOperationResolver implements OperationResolver
	{
		protected var resolvers:Array /* .<OperationResolver> */;
		public function CompositeOperationResolver(resolvers:Array /* .<OperationResolver> */)
		{
			super();
			this.resolvers = [];
			const n:int = resolvers.length;
			if (!(n >= 2))
				throw new ArgumentError("CompositeOperationResolver requires at least two resolvers; found "
					+ n + ".");
			for (var i:int = 0; i < n; ++i)
			{
				if (resolvers[i] is OperationResolver)
					this.resolvers.push(resolvers[i]);
				else
					throw new ArgumentError("CompositeOperationResolver requires operation resolvers;"
						+ " found: " + resolvers[i]);
			}
		}
		public function getOperation(mathML:XML):Operation
		{
			const n:int = resolvers.length;
			for (var i:int = 0; i < n; ++i)
			{
				var operation:Operation = OperationResolver(resolvers[i]).getOperation(mathML);
				if (!(operation is Unresolvable))
					return operation;
			}
			return new UnresolvableOperation(mathML);
		}
	}
}