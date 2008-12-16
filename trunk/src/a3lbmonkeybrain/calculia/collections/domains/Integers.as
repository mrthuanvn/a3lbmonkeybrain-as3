package a3lbmonkeybrain.calculia.collections.domains
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class Integers extends NumberDomain
	{
		public static const INSTANCE:Integers = new Integers(Lock);
		public function Integers(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			rank = 2;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == undefined)
				return undefined;
			return findInteger(name);
		}
		public function toString():String
		{
			return "Integers";
		}
	}
}
class Lock
{
}