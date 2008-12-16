package a3lbmonkeybrain.brainstem.colors
{
	/**
	 * Extracts the alpha component of an ARGB number.
	 * 
	 * @param c
	 * 		ARGB color.
	 * @return
	 * 		Alpha value, from 0 to 255.
	 */
	public function findAlpha(c:uint):uint
	{
		return uint(c & 0xFF000000) / 0x1000000;
	}
}