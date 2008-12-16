package a3lbmonkeybrain.brainstem.resolve
{
	public class CompositeXMLResolver implements XMLResolver
	{
		protected const resolvers:Array /* .<XMLResolver> */ = [];
		public function CompositeXMLResolver(resolvers:Array /* .<XMLResolver> */)
		{
			super();
			if (!(resolvers.length >= 2))
				throw new ArgumentError("CompositeXMLResolver requires at least two resolvers; found "
					+ resolvers.length + ".");
			const n:int = resolvers.length;
			for (var i:int = 0; i < n; ++i)
			{
				if (resolvers[i] is XMLResolver)
					this.resolvers.push(resolvers[i]);
				else
					throw new ArgumentError("CompositeXMLResolver requires XMLResolver objects; found: "
						+ resolvers[i]);
			}
		}
		public function resolveXML(xml:XML):Object
		{
			if (!(xml is XML))
				throw new ArgumentError();
			const n:int = resolvers.length;
			for (var i:int = 0; i < n; ++i)
			{
				var entity:Object = XMLResolver(resolvers[i]).resolveXML(xml);
				if (!(entity is Unresolvable))
					return entity;
			}
			return new UnresolvableXML(xml);
		}
	}
}