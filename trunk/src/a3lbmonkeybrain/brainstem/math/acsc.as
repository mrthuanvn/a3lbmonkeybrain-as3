package a3lbmonkeybrain.brainstem.math
{
	public function acsc(angleRadians:Number):Number
	{
		return angleRadians == 0.0 ? angleRadians : Math.asin(1 / angleRadians);
	}
}