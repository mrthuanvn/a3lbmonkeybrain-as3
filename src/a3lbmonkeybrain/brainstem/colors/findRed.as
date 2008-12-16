package a3lbmonkeybrain.brainstem.colors
{
	/**
	 * Extracts the red component of an ARGB or RGB number.
	 * 
	 * @param c
	 * 		ARGB or RGB color.
	 * @return
	 * 		Red value, from 0 to 255.
	 */
	public function findRed(c:uint):uint
	{
		return (c & 0xFF0000) >> 16;
	}
}