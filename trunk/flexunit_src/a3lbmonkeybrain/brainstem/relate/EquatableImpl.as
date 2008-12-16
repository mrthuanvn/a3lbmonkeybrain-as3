package a3lbmonkeybrain.brainstem.relate
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	internal class EquatableImpl implements Equatable
	{
		private var _indexA:uint;
		private var _indexB:uint;
		public function EquatableImpl(indexA:uint, indexB:uint)
		{
			super();
			_indexA = indexA;
			_indexB = indexB;
		}
		public final function get indexA():uint
		{
			return _indexA;
		}
		public final function get indexB():uint
		{
			return _indexB;
		}
		public final function equals(value:Object):Boolean
		{
			if (value is EquatableImpl)
				return _indexA == EquatableImpl(value)._indexA && _indexB == EquatableImpl(value)._indexB; 
			return false;
		}
		public final function toString():String
		{
			return "[" + getQualifiedClassName(this).split("::", 2)[1] + " indexA=" + indexA + " indexB=" + indexB
				+ "]";
		}
	}
}