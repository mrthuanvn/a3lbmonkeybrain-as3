package a3lbmonkeybrain.brainstem.core
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Gets the class of an object, or the object itself if it is a class.
	 *  
	 * @param value
	 * 		Object to find the class of.
	 * @return 
	 * 		If <code>value</code> is <code>null</code> or <code>undefined</code>, returns <code>null</code>. If
	 * 		<code>value</code> is a class, returns <code>value</code>. Otherwise, returns the class that
	 * 		<code>value</code> is an instance of.
	 */
	public function findClass(value:*):Class
	{
		if (value == undefined || value == null)
			return null;
		if (value is Class)
			return value as Class;
		return getDefinitionByName(getQualifiedClassName(value)) as Class;
	}
}
