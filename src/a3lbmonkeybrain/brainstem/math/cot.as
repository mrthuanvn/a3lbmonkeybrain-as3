package a3lbmonkeybrain.brainstem.math
{
	public function cot(angleRadians:Number):Number
	{
		const cos:Number = Math.cos(angleRadians);
		if (cos == 0.0)
			return Number.POSITIVE_INFINITY;
		return Math.sin(angleRadians) / cos;
	}
}