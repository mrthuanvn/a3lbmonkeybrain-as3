package a3lbmonkeybrain.brainstem.math
{
	public function factorial(x:uint):Number
	{
		if (x <= 2)
		{
			if (x == 2)
				return 2;
			return 1;
		}
		return Number(x) * factorial(x - 1);
	}
}
