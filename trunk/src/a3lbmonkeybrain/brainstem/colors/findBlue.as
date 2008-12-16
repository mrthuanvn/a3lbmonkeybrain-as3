package a3lbmonkeybrain.brainstem.colors
{
	/**
	 * Extracts the blue component of an ARGB or RGB number.
	 * 
	 * @param c
	 * 		ARGB or RGB color.
	 * @return
	 * 		Blue value, from 0 to 255.
	 */
	public function findBlue(c:uint):uint
	{
		return c & 0xFF;
	}
}