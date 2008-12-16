package a3lbmonkeybrain.brainstem.colors
{
	/**
	 * Calculates the RGB color between two other RGB colors.
	 * 
	 * @param c0
	 * 		RGB color.
	 * @param c1
	 * 		RGB color.
	 * @param f1
	 * 		Ratio. If 0, the result is the same as <code>c0</code>. If 1, the result is the same as <code>c1</code>.
	 * 		If 0.5, the result is exactly in between both colors.
	 * @return
	 * 		Interpolated RGB color.
	 */
	public function interpolateColors(c0:uint, c1:uint, f1:Number):uint
	{
		const f0:Number = 1 - f1;
		return (uint(((c0 & 0xFF0000) >> 16) * f0 + ((c1 & 0xFF0000) >> 16) * f1) << 16)
			| (uint(((c0 & 0xFF00) >> 8) * f0 + ((c1 & 0xFF00) >> 8) * f1) << 8)
			| uint((c0 & 0xFF) * f0 + (c1 & 0xFF) * f1);
	}
}