package a3lbmonkeybrain.brainstem.strings.en
{
	/**
	 * Makes a best guess at pluralizing an English word.
	 * 
	 * @author T. Michael Keesey
	 * @param value
	 * 		English word to pluralize.
	 * @return 
	 * 		Pluralized word.
	 */
	public function pluralize(s:String):String
	{
		if (RegExp(/(ch|j|o|s|sh|x|z)$/i).test(s))
			return s + "es";
		if (RegExp(/[bcdfghjklmnpqrstvwxz]y$/i).test(s))
			return s.substr(0, s.length - 1) + "ies";
		return s + "s";
	}
}
