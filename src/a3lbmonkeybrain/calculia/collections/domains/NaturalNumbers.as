package a3lbmonkeybrain.calculia.collections.domains
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class NaturalNumbers extends NumberDomain
	{
		public static const INSTANCE:NaturalNumbers = new NaturalNumbers(Lock);
		public function NaturalNumbers(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			rank = 1;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == undefined)
				return undefined;
			return findNaturalNumber(name);
		}
		public function toString():String
		{
			return "NaturalNumbers";
		}
	}
}
class Lock
{
}