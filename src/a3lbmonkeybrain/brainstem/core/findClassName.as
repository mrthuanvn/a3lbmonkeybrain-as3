package a3lbmonkeybrain.brainstem.core
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Finds the unqualified name of an object's class.
	 *  
	 * @param value
	 * 		Object to find the class name of.
	 * @return 
	 * 		If <code>value</code> is <code>null</code> or <code>undefined</code>, returns <code>&quot;&quot;</code>.
	 * 		If <code>value</code> is a class, returns the unqualified name of that class. Otherwise, returns the
	 * 		unqualified name of the class that <code>value</code> is an instance of.
	 */
	public function findClassName(value:*):String
	{
		if (value == undefined || value == null)
			return "";
		const parts:Array /* .<String> */ = getQualifiedClassName(value).split("::");
		if (parts.length == 0)
			return "";
		return parts[parts.length - 1] as String;
	}
}
