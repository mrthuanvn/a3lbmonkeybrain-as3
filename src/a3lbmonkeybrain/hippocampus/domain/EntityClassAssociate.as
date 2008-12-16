package a3lbmonkeybrain.hippocampus.domain
{
	/**
	 * Interface for objects which are associated with a class of entity.
	 *  
	 * @author T. Michael Keesey
	 */
	public interface EntityClassAssociate
	{
		/**
		 * The class of entity associated with this object. 
		 */
		function get entityClass():Class;
	}
}