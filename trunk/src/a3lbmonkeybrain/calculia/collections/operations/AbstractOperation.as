package a3lbmonkeybrain.calculia.collections.operations
{
	import a3lbmonkeybrain.brainstem.collections.FiniteList;
	import a3lbmonkeybrain.brainstem.collections.Set;
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.brainstem.resolve.Unresolvable;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathMLError;
	import a3lbmonkeybrain.calculia.collections.sets.AbstractSet;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	
	import flash.utils.flash_proxy;
	
	import mx.collections.IList;
	
	use namespace flash_proxy;

	public class AbstractOperation extends AbstractSet implements Operation
	{
		public function AbstractOperation()
		{
			super();
		}
		public function apply(args:Array):Object
		{
			throw new AbstractMethodError();
		}
		protected final function checkArguments(args:Array, entityClass:Class, min:uint = uint.MIN_VALUE,
			max:uint = uint.MAX_VALUE):Boolean
		{
			const n:int = args.length;
			if (min == max)
			{
				if (n != min)
					throw new ArgumentError(String(this) + " requires exactly " + min + " argument"
						+ ((min == 1) ? "" : "s") + "; found " + n + ".");
			}
			else if (n < min)
			{
				throw new ArgumentError(String(this) + " requires at least " + min + " argument"
					+ ((min == 1) ? "" : "s") + "; found " + n + ".");
			}
			else if (n > max)
			{
				throw new ArgumentError(String(this) + " requires no more than " + max + " argument"
					+ ((max == 1) ? "" : "s") + "; found " + n + ".");
			}
			for each (var arg:Object in args)
			{
				if (arg is Unresolvable)
					return false;
				if (!(arg is entityClass))
					throw new MathMLError(String(this) + " requires arguments of type "
						+ findClassName(entityClass) + "; found: " + arg);
			}
			return true;
		}
		protected static function getUnresolvableArgument(args:Array):Unresolvable
		{
			for each (var arg:Object in args)
			{
				if (arg is Unresolvable)
					return arg as Unresolvable;
			}
			return null;
		}
		override public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (!(value is Set))
				return false;
			throw new MathImplError("Cannot detect equality between most operations.");
		}
		override flash_proxy function hasProperty(name:*):Boolean
		{
			try
			{
				if (name[0] == undefined || name[1] == undefined)
					return false;
			}
			catch (e:Error)
			{
				return false;
			}
			var arr:Array;
			if (name[0] is Array)
				arr = name as Array;
			else if (name[0] is FiniteList)
				arr = FiniteList(name[0]).toArray();
			else if (name[0] is IList)
				arr = IList(name[0]).toArray();
			if (arr)
			{
				const mapped:Object = apply(arr);
				return Equality.equal(mapped, name[1]);
			}
			return false;
		}
		override public function prSubsetOf(value:Object):Boolean
		{
			if (this == value)
				return false;
			throw new MathImplError("Cannot resolve proper subset relation for most operations.");
		}
		override public function subsetOf(value:Object):Boolean
		{
			if (this == value)
				return true;
			throw new MathImplError("Cannot resolve subset relation for most operations.");
		}
	}
}