package a3lbmonkeybrain.calculia.collections.domains
{
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.calculia.collections.sets.AbstractSet;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class CartesianProductSet extends AbstractSet
	{
		private var sets:Array /* .<Set> */;
		public function CartesianProductSet(sets:Array /* .<Set> */)
		{
			super();
			this.sets = [];
			var n:int = sets.length;
			for (var i:int = 0; i < n; ++i)
			{
				if (sets[i] is Set)
					this.sets.push(sets[i]);
			}
			if (!(this.sets.length > 1))
				throw new ArgumentError("Invalid number of operands (" + this.sets.length
					+ ") for a Cartesian product: " + this.sets);
		}
		override public function get empty():Boolean
		{
			if (sets.length == 0)
				return true;
			for each (var s:Set in sets)
			{
				if (s.empty)
					return true;
			}
			return false;
		}
		override public function equals(value:Object):Boolean
		{
			if (value is CartesianProductSet)
			{
				var n:int = sets.length;
				if (CartesianProductSet(value).sets.length == n)
				{
					for (var i:int = 0; i < n; ++i)
					{
						if (!Set(sets[i]).equals(CartesianProductSet(value).sets[i]))
							return false;
					}
					return true;
				}
				return false;
			}
			if (isKnownSet(value))
				return false;
			throw new MathImplError("Cannot resolve subset relation of some nonfinite sets.");
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			if (name is Array)
			{
				var n:int = sets.length;
				if ((name as Array).length != n)
					return false;
				for (var i:int = 0; i < n; ++i)
				{
					if (sets[i][name[i]] == undefined)
						return false;
				}
				return true;
			}
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
				{
					for (var i:int = 0; i < n; ++i)
					{
						if (!Set(sets[i]).prSubsetOf(CartesianProductSet(value).sets[i]))
							return false;
					}
					return true;
				}
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
					{
						if (!Set(sets[i]).subsetOf(CartesianProductSet(value).sets[i]))
							return false;
					}
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