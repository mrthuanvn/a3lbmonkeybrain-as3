package a3lbmonkeybrain.brainstem.filter
{
	/**
	 * Creates a function that will return <code>true</code> for objects of a certain class and <code>false</code>
	 * for anything else.
	 *  
	 * @param filteredClass
	 * 		Class; the returned function will return <code>true</code> for objects of this class.
	 * @return 
	 * 		A function which returns <code>true</code> only for instances of <code>filteredClass</code>.
	 */
	public function filterType(filteredClass:Class):Function
	{
		return new TypeFilter(filteredClass).filter;
	}
}
