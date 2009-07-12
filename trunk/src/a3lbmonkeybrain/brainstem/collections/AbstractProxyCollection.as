package a3lbmonkeybrain.brainstem.collections
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;

	public class AbstractProxyCollection extends Proxy
	{
		/**
		 * Temporary vector used to iterate over members.
		 * 
		 * @see nextName()
		 * @see nextNameIndex()
		 * @see nextValue()
		 */
		protected var proxyMembers:Vector.<Object>;
		/**
		 * @inheritDoc
		 */
		override flash_proxy final function callProperty(name:*, ...args):*
		{
			return undefined;
		}
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy final function nextName(index:int):String
	    {
	    	return String(proxyMembers[index - 1]);
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy final function nextNameIndex(index:int):int
	    {
	    	if (index == 0)
	    		proxyMembers = toVector();
			if (index < proxyMembers.length)
            	return index + 1;
            else
            	return 0;
	    }
	    /**
	     * @inheritDoc
	     */
	    override flash_proxy final function nextValue(index:int):*
	    {
	    	return proxyMembers[index - 1];
	    }
	    public function toVector():Vector.<Object>
	    {
	    	throw new AbstractMethodError();
	    }
	}
}