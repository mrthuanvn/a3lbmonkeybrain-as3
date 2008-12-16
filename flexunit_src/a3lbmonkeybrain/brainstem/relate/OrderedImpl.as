package a3lbmonkeybrain.brainstem.relate
{
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	internal final class OrderedImpl extends EquatableImpl implements Ordered
	{
		public function OrderedImpl(indexA:uint, indexB:uint)
		{
			super(indexA, indexB);
		}
		public final function findOrder(value:Object):int
		{
			if (value is OrderedImpl)
			{
				if (indexA != OrderedImpl(value).indexA)
					return (indexA < OrderedImpl(value).indexA) ? -1 : 1;
				if (indexB != OrderedImpl(value).indexB)
					return (indexB < OrderedImpl(value).indexB) ? -1 : 1;
			}
			return 0;
		}
	}
}