package a3lbmonkeybrain.brainstem.strings
{
	/**
	 * Trims leading and trailing whitespace from a string.
	 * 
	 * @author T. Michael Keesey
	 * @param value
	 * 		String to trim.
	 * @return 
	 * 		Trimmed string, with no leading or trailing whitespace.
	 */
	public function trim(value:String):String
	{
		if (value == null) return null;
		return value.replace(/^\s+/, "").replace(/\s+$/, "");
	}
}
