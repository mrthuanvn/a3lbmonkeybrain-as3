package a3lbmonkeybrain.brainstem.math
{
	/**
	 * Finds the closest power of two, rounding up, with a maximum value of 256.
	 * Can be used for certain optimizations.
	 * <p>
	 * Results for values up to 16:
	 * </p>
	 * <table class="innertable">
	 * <tr><th>Value</th>	<th>Closest Power of Two</th></tr>
	 * <tr><td>0</td>		<td>0</td></tr>
	 * <tr><td>1</td>		<td>1</td></tr>
	 * <tr><td>2</td>		<td>2</td></tr>
	 * <tr><td>3</td>		<td>4</td></tr>
	 * <tr><td>4</td>		<td>4</td></tr>
	 * <tr><td>5</td>		<td>4</td></tr>
	 * <tr><td>6</td>		<td>8</td></tr>
	 * <tr><td>7</td>		<td>8</td></tr>
	 * <tr><td>8</td>		<td>8</td></tr>
	 * <tr><td>9</td>		<td>8</td></tr>
	 * <tr><td>9</td>		<td>8</td></tr>
	 * <tr><td>10</td>		<td>8</td></tr>
	 * <tr><td>11</td>		<td>8</td></tr>
	 * <tr><td>12</td>		<td>16</td></tr>
	 * <tr><td>13</td>		<td>16</td></tr>
	 * <tr><td>14</td>		<td>16</td></tr>
	 * <tr><td>15</td>		<td>16</td></tr>
	 * <tr><td>16</td>		<td>16</td></tr>
	 * </table>
	 * 
	 * @param value
	 * 		Value to find the closest value of two for.
	 * @return
	 * 		0, 1, 2, 4, 8, 16, 32, 64, 128, or 256, whichever is closest to <code>value</code> (rounding up). 
	 */
	public function closestPowerOf2(value:uint):uint
	{
		if (isNaN(value))
			return 0;
		if (value == 0 || value == 1 || value == 2)
			return value;
		if (value < 6)
			return 4;
		if (value < 12)
			return 8;
		if (value < 24)
			return 16;
		if (value < 48)
			return 32;
		if (value < 96)
			return 64;
		if (value < 192)
			return 128;
		return 256;
	}
}