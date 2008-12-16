package a3lbmonkeybrain.calculia.collections.sets
{
	import a3lbmonkeybrain.brainstem.collections.EmptySet;
	import a3lbmonkeybrain.brainstem.collections.Set;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public class SetUnion extends AbstractSet
	{
		protected var a:Set;
		protected var b:Set;		
		public function SetUnion(a:Set, b:Set)
		{
			super();
			this.a = a;
			this.b = b;
		}
		override public function get empty():Boolean
		{
			return a.empty && b.empty;
		}
		public static function create(a:Set, b:Set):Set
		{
			if (a.equals(b))
				return a;
			if (a.empty && b.empty)
				return EmptySet.INSTANCE;
			return new SetIntersection(a, b);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return a[name] != undefined || b[name] != undefined;
		}
		override public function prSubsetOf(value:Object):Boolean
		{
			return a.prSubsetOf(value) && b.prSubsetOf(value);
		}
		override public function subsetOf(value:Object):Boolean
		{
			return a.subsetOf(value) && b.subsetOf(value);
		}
		public function toString():String
		{
			return "(" + a + " \u222A " + b + ")";
		}
	}
}