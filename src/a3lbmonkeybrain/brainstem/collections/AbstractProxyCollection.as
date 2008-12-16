package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;

	internal class AbstractProxyCollection extends Proxy
	{
		/**
		 * Temporary array used to iterate over members.
		 * 
		 * @see nextName()
		 * @see nextNameIndex()
		 * @see nextValue()
		 */
		protected var proxyMembers:Array;
		/**
		 * @inheritDoc
		 */
		override flash_proxy function callProperty(name:*, ...args):*
		{
			return undefined;
		}
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextName(index:int):String
	    {
	    	return proxyMembers[index - 1];
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextNameIndex(index:int):int
	    {
	    	if (index == 0)
	    		proxyMembers = toArray();
			if (index < proxyMembers.length)
            	return index + 1;
            else
            	return 0;
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy function nextValue(index:int):*
	    {
	    	return proxyMembers[index - 1];
	    }
	    public function toArray():Array
	    {
	    	throw new AbstractMethodError();
	    }
	}
}