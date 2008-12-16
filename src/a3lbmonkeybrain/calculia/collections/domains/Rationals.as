package a3lbmonkeybrain.calculia.collections.domains
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class Rationals extends NumberDomain
	{
		public static const INSTANCE:Rationals = new Rationals(Lock);
		public function Rationals(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			rank = 3;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == undefined)
				return undefined;
			return findRational(name);
		}
		public function toString():String
		{
			return "Rationals";
		}
	}
}
class Lock
{
}