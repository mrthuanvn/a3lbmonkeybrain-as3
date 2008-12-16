package a3lbmonkeybrain.brainstem.strings.en
{
	/**
	 * Makes a best guess as to the indefinite article (&quot;a&quot; or &quot;an&quot;) for an English word.
	 * 
	 * @author T. Michael Keesey
	 * @param value
	 * 		English word to find the indefinite article of.
	 * @return 
	 * 		An indefinite article (&quot;a&quot; or &quot;an&quot;).
	 */
	public function findIndefiniteArticle(s:String):String
	{
		if (s.charAt(0).match(/^[aeiou]/i))
		{
			if (s.substr(0, 3).toLowerCase() == "uni")
				return "a";
			return "an";
		}
		if (s.substr(0, 4) == "hour")
			return "an";
		return "a";
	}
}
