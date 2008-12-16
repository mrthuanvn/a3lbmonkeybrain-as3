package a3lbmonkeybrain.brainstem.math
{
	public function csc(angleRadians:Number):Number
	{
		const sin:Number = Math.sin(angleRadians);
		return (sin == 0.0) ? 1.0 : (1.0 / sin);
	}
}