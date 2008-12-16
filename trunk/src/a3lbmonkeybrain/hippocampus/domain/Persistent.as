package a3lbmonkeybrain.hippocampus.domain
{
	import mx.core.IPropertyChangeNotifier;
	
	import a3lbmonkeybrain.brainstem.relate.Ordered;
	
	/**
	 * Interface for a persistent entity that might be saved in a database.
	 * 
	 * @author T. Michael Keesey
	 * @see AbstractEntity
	 */
	public interface Persistent extends IPropertyChangeNotifier, Ordered
	{
		/**
		 * The primary key of the entity. If <code>0</code>, then this entity has not been persisted.
		 * 
		 * @defaultValue 0
		 */
		function get id():uint;
		/**
		 * @private
		 */		
		function set id(value:uint):void;
		/**
		 * The current version of the entity.
		 * 
		 * @defaultValue 0
		 */
		function get version():uint;
		/**
		 * @private
		 */		
		function set version(value:uint):void;
	}
}