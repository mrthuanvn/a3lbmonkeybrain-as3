package a3lbmonkeybrain.brainstem.strings
{
	/**
	 * Capitalizes a string.
	 * 
	 * @param value
	 * 		String to capitalize.
	 * @param locale
	 * 		If <code>true</code>, uses localized case settings.
	 * @return 
	 * 		Capitalized string.
	 */
	public function capitalize(value:String, locale:Boolean = true):String
	{
		if (value == null)
			return null;
		const n:int = value.length;
		var capitalizeNext:Boolean = true;
		var s:String = "";
		for (var i:int = 0; i < n; ++i)
		{
			var c:String = value.charAt(i);
			if (isCased(c, locale))
			{
				if (capitalizeNext)
				{
					s += locale ? c.toLocaleUpperCase() : c.toUpperCase();
					capitalizeNext = false;
				}
				else
				{
					s += c;
				}
			}
			else
			{
				s += c;
				capitalizeNext = true;
			}
		}
		return s;
	}
}
