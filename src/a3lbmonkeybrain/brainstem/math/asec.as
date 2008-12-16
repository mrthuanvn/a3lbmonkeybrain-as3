package a3lbmonkeybrain.brainstem.math
{
	public function asec(angleRadians:Number):Number
	{
		return angleRadians == 0.0 ? angleRadians : Math.acos(1 / angleRadians);
	}
}