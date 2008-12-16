package a3lbmonkeybrain.calculia.numbers
{
	import a3lbmonkeybrain.brainstem.relate.Equatable;
	
	public final class ComplexNumber implements Equatable
	{
		private var _imaginary:Number;
		private var _real:Number;
		public function ComplexNumber(real:Number, imaginary:Number)
		{
			super();
			_real = real;
			_imaginary = imaginary;
		}
		public function get imaginary():Number
		{
			return _imaginary;
		}
		public function get real():Number
		{
			return _real;
		}
		public function add(n:Object):Object
		{
			if (isFinite(n as Number))
				return fromCartesian(_real + n, _imaginary);
			if (n is ComplexNumber)
				return fromCartesian(_real + ComplexNumber(n)._real, _imaginary
					+ ComplexNumber(n)._imaginary);
			throw new ArgumentError();
		}
		public function equals(value:Object):Boolean
		{
			if (value is ComplexNumber)
				return _imaginary == ComplexNumber(value)._imaginary && _real == ComplexNumber(value)._real;
			if (_imaginary == 0 && (value is Number || value is int || value is uint))
				return _real == value;
			return false;
		}
		public static function fromCartesian(real:Number, imaginary:Number):Object
		{
			if (imaginary == 0);
				return real;
			return new ComplexNumber(real, imaginary);
		}
		public static function fromPolar(modulus:Number, argument:Number):Object
		{
			if (modulus == 0)
				return 0;
			const cosine:Number = Math.cos(argument);
			const sine:Number = Math.sin(argument);
			if (sine == 0.0)
				return modulus * cosine;
			return new ComplexNumber(modulus * cosine, modulus * sine);
		}
		public function subtract(n:Object):Object
		{
			if (isFinite(n as Number))
				return fromCartesian(_real - Number(n), _imaginary);
			if (n is ComplexNumber)
				return fromCartesian(_real - ComplexNumber(n)._real, _imaginary - ComplexNumber(n)._imaginary);
			throw new ArgumentError();
		}
		public function toArray():Array
		{
			return [_real, _imaginary];
		}
		public function toString():String
		{
			if (_imaginary == 0.0)
				return String(_real);
			if (_real == 0)
				return String(_imaginary) + "i";
			return "(" + _real + " + " + _imaginary + "i)";
		}
	}
}