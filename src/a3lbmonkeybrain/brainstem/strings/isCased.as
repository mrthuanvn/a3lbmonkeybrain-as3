package a3lbmonkeybrain.brainstem.strings
{
	/**
	 * Checks if a string contains of cased characters (that is, letters).
	 * 
	 * @author T. Michael Keesey
	 * @param s
	 * 		String to check.
	 * @param locale
	 * 		If <code>true</code>, uses localized case settings.
	 * @return 
	 * 		A value of <code>true</code> if <code>s</code> contains any cased characters; <code>false</code> otherwise.
	 */
	public function isCased(s:String, locale:Boolean = true):Boolean
	{
		if (locale)
			return s != s.toLocaleLowerCase() || s != s.toLocaleUpperCase();
		return s != s.toLowerCase() || s != s.toUpperCase();
	}
}
