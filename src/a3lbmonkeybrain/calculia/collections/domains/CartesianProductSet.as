package a3lbmonkeybrain.calculia.collections.domains
{
	import a3lbmonkeybrain.brainstem.collections.FiniteCollection;
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	import a3lbmonkeybrain.calculia.collections.sets.AbstractSet;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class CartesianProductSet extends AbstractSet
	{
		private var sets:Vector.<Set> /* .<Set> */;
		public function CartesianProductSet(sets:Object /* .<Set> */)
		{
			super();
			const setsVector:Vector.<Set> = new Vector.<Set>();
			var n:uint = 0;
			for each (var s:Set in sets)
			{
				setsVector.push(s);
				++n;
			}
			this.sets = new Vector.<Set>(n);
			for (var i:uint = 0; i < n; ++i)
				this.sets[i] = setsVector[i];
		}
		override public function get empty():Boolean
		{
			if (sets.length == 0)
				return true;
			for each (var s:Set in sets)
				if (s.empty)
					return true;
			return false;
		}
		override public function equals(value:Object):Boolean
		{
			if (value is CartesianProductSet)
			{
				const n:int = sets.length;
				if (CartesianProductSet(value).sets.length == n)
				{
					for (var i:int = 0; i < n; ++i)
						if (!Set(sets[i]).equals(CartesianProductSet(value).sets[i]))
							return false;
					return true;
				}
				return false;
			}
			if (isKnownSet(value))
				return false;
			throw new MathImplError("Cannot resolve equality of some nonfinite sets.");
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			if (name is Array || name is Vector)
			{
				var n:uint = sets.length;
				if (name.length != n)
					return false;
				for (var i:uint = 0; i < n; ++i)
					if (!Set(sets[i]).has(name[i]))
						return false;
				return true;
			}
			else if (name is FiniteCollection)
				return hasProperty(FiniteCollection(name).toVector());
			return false;
		}
		private static function isKnownSet(value:Object):Boolean
		{
			return value is Complexes || value is Reals || value is Rationals || value is Integers
				|| value is NaturalNumbers || value is Primes;
		}
		override public function prSubsetOf(value:Object):Boolean
		{
			if (value is CartesianProductSet)
			{
				var n:int = sets.length;
				if (CartesianProductSet(value).sets.length == n)
					for (var i:int = 0; i < n; ++i)
						if (!Set(sets[i]).prSubsetOf(CartesianProductSet(value).sets[i]))
							return false;
					return true;
				return false;
			}
			if (isKnownSet(value))
				return false;
			throw new MathImplError("Cannot resolve subset relation of some nonfinite sets.");
		}
		override public function subsetOf(value:Object):Boolean
		{
			if (value is CartesianProductSet)
			{
				var n:int = sets.length;
				if (CartesianProductSet(value).sets.length == n)
				{
					for (var i:int = 0; i < n; ++i)
						if (!Set(sets[i]).subsetOf(CartesianProductSet(value).sets[i]))
							return false;
					return true;
				}
				return false;
			}
			if (isKnownSet(value))
				return false;
			throw new MathImplError("Cannot resolve subset relation of some nonfinite sets.");
		}
		public function toString():String
		{
			return sets.join(" × "); 
		}
	}
}