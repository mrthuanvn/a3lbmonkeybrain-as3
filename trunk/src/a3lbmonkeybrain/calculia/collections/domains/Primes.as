package a3lbmonkeybrain.calculia.collections.domains
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class Primes extends NumberDomain
	{
		public static const INSTANCE:Primes = new Primes(Lock);
		public function Primes(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			rank = 0;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == undefined)
				return undefined;
			return findPrime(name);
		}
		public function toString():String
		{
			return "Primes";
		}
	}
}
class Lock
{
}