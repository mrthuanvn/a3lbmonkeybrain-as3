package a3lbmonkeybrain.brainstem.strings
{
	public function padLeft(expression:Object, minLength:int, padCharacter:String = "0"):String
	{
		var s:String = String(expression);
		while (s.length < minLength)
		{
			s = padCharacter + s;
		}
		return s;
	}
}
