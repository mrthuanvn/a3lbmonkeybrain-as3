package a3lbmonkeybrain.calculia.collections.domains
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class Reals extends NumberDomain
	{
		public static const INSTANCE:Reals = new Reals(Lock);
		public function Reals(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			rank = 4;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == undefined)
				return undefined;
			return findReal(name);
		}
		public function toString():String
		{
			return "Reals";
		}
	}
}
class Lock
{
}