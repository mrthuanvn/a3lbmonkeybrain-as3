package a3lbmonkeybrain.brainstem.core
{
	import flash.utils.ByteArray;
	
	/**
	 * Creates a copy of an object.
	 * <p>
	 * User-created classes may require a <code>RemoteClass</code> metadata tag for this to work properly. For
	 * example, to use this method to clone an instance of <code>myPackage.MyClass</code>, that class should be
	 * prefaced with the following metadata tag:
	 * </p>
	 * <pre>[RemoteClass(alias = &quot;myPackage.MyClass&quot;)]</pre>
	 * 
	 * @param value
	 * 		Object to clone. The constructor of this object's class must be able to take no arguments. If this
	 * 		value is <code>null</code>, then <code>null</code> is returned.
	 * @return
	 * 		New object, or <code>null</code> if <code>value</code> is <code>null</code>.
	 * @throws ArgumentError
	 * 		<code>ArgumentError</code>: If the constructor of <code>value</code>'s class requires one or more arguments.
	 * @see http://livedocs.adobe.com/livecycle/es/sdkHelp/programmer/lcds/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=serialize_data_3.html
	 * 		Explicitly mapping ActionScript and Java objects
	 */		
	public function clone(value:Object):Object
	{
		if (value == null)
			return null;
		const byteArray:ByteArray = new ByteArray();
		byteArray.writeObject(value);
		byteArray.position = 0;
		return byteArray.readObject() as Object;
	}
}
