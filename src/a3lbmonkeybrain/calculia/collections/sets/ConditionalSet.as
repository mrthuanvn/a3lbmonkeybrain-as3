package a3lbmonkeybrain.calculia.collections.sets
{
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;

	public class ConditionalSet extends AbstractSet
	{
		protected var condition:Function;
		public function ConditionalSet(condition:Function)
		{
			super();
			if (condition == null)
				throw new TypeError("Null condition.");
			this.condition = condition;
		}
		override public function get empty():Boolean
		{
			throw new MathImplError("Unable to assess the emptiness of certain conditional sets.");
		}
		override public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value is Set)
			{
				if (value is ConditionalSet && condition == ConditionalSet(value).condition)
					return true;
				throw new MathImplError("Unable to assess the equivalence of certain conditional sets.");
			}
			return false;
		}
		override public function has(element:Object):Boolean
		{
			return condition(element) ? true : false;
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return condition(name) ? true : false;
		}
		override public function prSubsetOf(value:Object):Boolean
		{
			if (equals(value))
				return false;
			throw new MathImplError("Unable to assess whether certain conditional sets are proper subsets.");
		}
		override public function subsetOf(value:Object):Boolean
		{
			if (equals(value))
				return true;
			throw new MathImplError("Unable to assess whether certain conditional sets are subsets.");
		}
	}
}