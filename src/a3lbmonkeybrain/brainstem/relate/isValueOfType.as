package a3lbmonkeybrain.brainstem.relate
{
	/**
	 * @private 
	 */
	internal function isValueOfType(o:Object):Boolean
	{
		return o is Date || o is Namespace || o is QName;
	}
}
