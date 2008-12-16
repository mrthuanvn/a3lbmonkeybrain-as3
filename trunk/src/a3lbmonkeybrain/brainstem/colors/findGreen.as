package a3lbmonkeybrain.brainstem.colors
{
	/**
	 * Extracts the green component of an ARGB or RGB number.
	 * 
	 * @param c
	 * 		ARGB or RGB color.
	 * @return
	 * 		Green value, from 0 to 255.
	 */
	public function findGreen(c:uint):uint
	{
		return (c & 0xFF00) >> 8;
	}
}