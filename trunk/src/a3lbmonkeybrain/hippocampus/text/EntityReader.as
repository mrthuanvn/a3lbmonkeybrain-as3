package a3lbmonkeybrain.hippocampus.text
{
	import a3lbmonkeybrain.hippocampus.domain.EntityClassAssociate;
	
	/**
	 * Interface for objects which read entity data from plain text.
	 * <p>
	 * A class can be associated with a reader using the <code>[Reader]</code> metadata tag.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 * @see a3lbmonkeybrain.hippocampus.domain.Entity
	 */
	public interface EntityReader extends EntityClassAssociate
	{
		/**
		 * Reads data from a string to populate a new instance of an entity.
		 *  
		 * @param s
		 * 		String to read.
		 * @return 
		 * 		New <code>Entity</code> instance, an instance of <code>entityClass</code>.
		 * @see #entityClass
		 * @see a3lbmonkeybrain.hippocampus.domain.Entity
		 */
		function read(s:String):Object;
	}
}