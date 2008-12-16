package a3lbmonkeybrain.brainstem.math
{
	public function sec(angleRadians:Number):Number
	{
		const cos:Number = Math.cos(angleRadians);
		return (cos == 0.0) ? 1.0 : (1.0 / cos);
	}
}