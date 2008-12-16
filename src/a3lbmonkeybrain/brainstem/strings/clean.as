package a3lbmonkeybrain.brainstem.strings
{
	/**
	 * Trims leading and trailing whitespace from a string, and collapses all other whitespace to single spaces.
	 * 
	 * @param value
	 * 		String to clean.
	 * @return 
	 * 		Cleaned string, with no leading or trailing whitespace, and only single spaces for whitespace.
	 */
	public function clean(value:String):String
	{
		if (value == null)
			return value;
		return value.replace(/\s+/g, " ").replace(/(^\s|\s$)/g, "");
	}
}
