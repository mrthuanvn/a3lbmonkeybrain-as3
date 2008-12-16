package a3lbmonkeybrain.calculia.collections.domains
{
	import a3lbmonkeybrain.brainstem.collections.FiniteSet;
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.core.findClass;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	import a3lbmonkeybrain.brainstem.math.factorial;
	import a3lbmonkeybrain.calculia.collections.sets.AbstractSet;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	import a3lbmonkeybrain.calculia.numbers.ComplexNumber;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;

	internal class NumberDomain extends AbstractSet
	{
		protected var rank:int;
		public function NumberDomain()
		{
			super();
		}
		override public final function get empty():Boolean
		{
			return false;
		}
		override public final function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is Set)
			{
				if (value is NumberDomain)
					return findClass(this) == findClass(value);
				if (value is FiniteSet)
					return false;
				return super.equals(value);
			}
			return false;
		}
		protected static function findComplex(value:Object):*
		{
			if (value is ComplexNumber || (value is Number && !isNaN(value as Number)))
				return value;
			return undefined;
		}
		protected static function findInteger(value:Object):*
		{
			const x:* = findReal(value);
			if (x is Number)
				return (x == Math.floor(x as Number)) ? x : undefined;
			return undefined;
		}
		protected static function findNaturalNumber(value:Object):*
		{
			const x:* = findInteger(value);
			if (x == undefined)
				return undefined;
			return x >= 0 ? x : undefined;
		}
		protected static function findPrime(value:Object):*
		{
			const x:* = findNaturalNumber(value);
			if (x == undefined)
				return undefined;
			return isPrime(x as Number) ? x : undefined;
		}
		protected static function findRational(value:Object):*
		{
			const x:* = findReal(value);
			if (x == undefined)
				return undefined;
			if (x == Math.floor(x as Number) || Number(x).toFixed(20).substr(-4) == "0000")
				return x as Number;
			throw new MathImplError("Cannot resolve whether certain decimal numbers are rational.");
		}
		protected static function findReal(value:Object):*
		{
			value = Number(value);
			if (isNaN(value as Number))
				return undefined;
			if (value is Number || value is int || value is uint)
				return value;
			if (value is ComplexNumber)
				return ComplexNumber(value).imaginary == 0 ? ComplexNumber(value).real : undefined;
			return undefined;
		}
		override flash_proxy function getProperty(name:*):*
		{
			throw new AbstractMethodError();
		}
		override final flash_proxy function hasProperty(name:*):Boolean
		{
			return flash_proxy::getProperty(name) != undefined;
		}
		protected static function isPrime(i:Number):Boolean
		{
			if (i < 2)
				return false;
			var i2:uint = uint(i);
			if (i != i2)
				return false;
			--i2;
			const testValue:Number = Number(factorial(i2) + 1) / i;
			return testValue == Math.floor(testValue);
		}
		override public final function prSubsetOf(value:Object):Boolean
		{
			if (value.empty || value is FiniteSet || equals(value))
				return false;
			if (value is NumberDomain)
				return rank < NumberDomain(value).rank;
			throw new MathImplError("Cannot determine proper subset relation of some sets.");
		}
		override public final function subsetOf(value:Object):Boolean
		{
			if (value.empty || value is FiniteSet)
				return false;
			if (equals(value))
				return true;
			if (value is NumberDomain)
				return rank < NumberDomain(value).rank;
			throw new MathImplError("Cannot determine proper subset relation of some sets.");
		}
	}
}