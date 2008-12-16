package a3lbmonkeybrain.calculia.collections.sets
{
	import a3lbmonkeybrain.brainstem.collections.EmptySet;
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	public class SetDifference extends AbstractSet
	{
		protected var a:Set;
		protected var b:Set;		
		public function SetDifference(a:Set, b:Set)
		{
			super();
			this.a = a;
			this.b = b;
		}
		override public function get empty():Boolean
		{
			return !a.subsetOf(b);
		}
		public static function create(a:Set, b:Set):Set
		{
			if (a.subsetOf(b))
				return EmptySet.INSTANCE;
			return new SetDifference(a, b);
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return a[name] != undefined && b[name] == undefined;
		}
		override public function subsetOf(value:Object):Boolean
		{
			if (!b.intersect(value).empty)
				return false;
			if (a.subsetOf(value))
				return true;
			throw new MathImplError("Cannot resolve the subset relation for some sets.");
		}
		override public function prSubsetOf(value:Object):Boolean
		{
			if (!b.intersect(value).empty)
				return false;
			if (a.prSubsetOf(value))
				return true;
			throw new MathImplError("Cannot resolve the proper subset relation for some sets.");
		}
		public function toString():String
		{
			return "(" + a + " \u2212 " + b + ")";
		}
	}
}