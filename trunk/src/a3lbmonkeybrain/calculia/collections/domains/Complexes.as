package a3lbmonkeybrain.calculia.collections.domains
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public final class Complexes extends NumberDomain
	{
		public static const INSTANCE:Complexes = new Complexes(Lock);
		public function Complexes(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			rank = 5;
		}
		override flash_proxy function getProperty(name:*):*
		{
			if (name == undefined)
				return undefined;
			return findComplex(name);
		}
		public function toString():String
		{
			return "Complexes";
		}
	}
}
class Lock
{
}