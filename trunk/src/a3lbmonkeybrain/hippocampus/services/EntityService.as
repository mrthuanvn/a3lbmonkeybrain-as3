package a3lbmonkeybrain.hippocampus.services
{
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.hippocampus.domain.EntityClassAssociate;
	import a3lbmonkeybrain.hippocampus.domain.Persistent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;

	[Bindable]
	/**
	 * Basic CRUD service for persistent entities.
	 * 
	 * @author T. Michael Keesey
	 */
	public class EntityService extends RemoteObject implements EntityClassAssociate
	{
		/**
		 * The minimum length for text to make a search.
		 * 
		 * @see #search() 
		 */
		public var minSearchTextLength:uint = 1;
		/**
		 * If set to <code>true</code>, then setting <code>entityClass</code> will set
		 * <code>destination</code> to the (unqualified) name of the class, converted to lower case.
		 * 
		 * @see #destination
		 * @see #entityClass
		 */
		public var setDestinationFromClassName:Boolean = true;
		private var _entityClass:Class;
		/**
		 * Creates a new instance.
		 *  
		 * @param entityClass
		 * 		Initial value for <code>entityClass</code>. If <code>null</code>, does not set it.
		 * @see #entityClass
		 */
		public function EntityService(entityClass:Class = null)
		{
			super();
			if (entityClass != null)
				this.entityClass = entityClass;
		}
		/**
		 * The class of entity associated with this service. 
		 * 
		 * @see #setDestinationFromClassName
		 */
		public function get entityClass():Class
		{
			return _entityClass;
		}
		/**
		 * @private
		 */
		public function set entityClass(value:Class):void
		{
			_entityClass = value;
			if (setDestinationFromClassName)
				destination = findClassName(value).toLowerCase();
		}
		/**
		 * Sends a new persistent object to the remote service, so that the item can be stored in a
		 * database.
		 * 
		 * @param item
		 * 		Item to persist on the server.
		 * @param updateID
		 * 		If <code>true</code>, then the <code>id</code> property of <code>item</code> is
		 * 		automatically updated after successful calls.
		 * @return 
		 * 		An asynchronous token for tracking the server response. On success, responders are passed
		 * 		a <code>ResultEvent</code> object, where the <code>result</code> property is the new
		 * 		<code>id</code> value for the object. On failure, responders are passed a
		 * 		<code>FaultEvent</code> object.
		 * @throws ArgumentError
		 * 		ArgumentError - If <code>item</code> is null, or of its <code>id</code> or
		 * 		<code>version</code> property is not <code>0</code>.
		 * @see a3lbmonkeybrain.hippocampus.domain.Persistent#id
		 * @see a3lbmonkeybrain.hippocampus.domain.Persistent#version
		 * @see http://livedocs.adobe.com/flex/3/langref/ArgumentError.html
		 * 		ArgumentError
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/AsyncToken.html
		 * 		mx.rpc.AsyncToken
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/IResponder.html
		 * 		mx.rpc.IResponder
		 */
		public function createItem(item:Persistent, updateID:Boolean = true):AsyncToken
		{
			if (item == null)
				throw new ArgumentError("Null argument.");
			if (item.id > 0)
				throw new ArgumentError("ID must be 0 for uncreated items.");
			if (item.version > 0)
				throw new ArgumentError("Version must be 0 for uncreated items.");
			const token:AsyncToken = getOperation("createItem").send(item);
			if (updateID)
				token.addResponder(new CreateItemResponder(item));
			return token;
		}
		/**
		 * Sends a request to remove certain item from the database. 
		 * 
		 * @param item
		 * 		The item to remove.
		 * @param updateID
		 * 		If <code>true</code>, then the <code>id</code> property of <code>item</code> is
		 * 		automatically updated after successful calls.
		 * @return 
		 * 		An asynchronous token for tracking the server response. On success, responders are passed
		 * 		a <code>ResultEvent</code> object, where the <code>result</code> property is
		 * 		<code>null</code>. On failure, responders are passed a <code>FaultEvent</code> object.
		 * @throws ArgumentError
		 * 		ArgumentError - If <code>item</code> is null, or of its <code>id</code> property is
		 * 		<code>0</code> (indicating that it has not yet been persisted).
		 * @see a3lbmonkeybrain.hippocampus.domain.Persistent#id
		 * @see http://livedocs.adobe.com/flex/3/langref/ArgumentError.html ArgumentError
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/AsyncToken.html mx.rpc.AsyncToken
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/IResponder.html mx.rpc.IResponder
		 */
		public function deleteItem(item:Persistent, updateID:Boolean = true):AsyncToken
		{
			if (item == null)
				throw new ArgumentError("Null argument.");
			if (item.id == 0)
				throw new ArgumentError("Cannot delete uncreated item.");
			const token:AsyncToken = getOperation("deleteItem").send(item.id);
			if (updateID)
				token.addResponder(new DeleteItemResponder(item));
			return token;
		}
		/**
		 * Sends a request to find all items that would conflict with an item if it were saved in the
		 * database.
		 *  
		 * @param item
		 * 		Item to check on the server.
		 * @return
		 * 		An asynchronous token for tracking the server response. On success, responders are passed
		 * 		a <code>ResultEvent</code> object, where the <code>result</code> property is an
		 * 		<code>ArrayCollection</code> object (possibly empty) containing references
		 * 		(<code>PersistentRef</code> objects) to all matching objects. On failure, responders are
		 * 		passed a <code>FaultEvent</code> object.
		 * @throws ArgumentError
		 * 		ArgumentError - If <code>item</code> is null.
		 * @see a3lbmonkeybrain.hippocampus.domain.PersistentRef
		 * @see http://livedocs.adobe.com/flex/3/langref/ArgumentError.html ArgumentError
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/AsyncToken.html mx.rpc.AsyncToken
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/IResponder.html mx.rpc.IResponder
		 */
		public function findMatches(item:Persistent):AsyncToken
		{
			if (item == null)
				throw new ArgumentError("Null argument.");
			return getOperation("findMatches").send(item);
		}
		/**
		 * Retrieves a single item from the server.
		 *  
		 * @param id
		 * 		The ID number (primary key) of the item.
		 * @return 
		 * 		An asynchronous token for tracking the server response. On success, responders are passed
		 * 		a <code>ResultEvent</code> object, where the <code>result</code> property is
		 * 		the requested item. On failure, responders are passed a <code>FaultEvent</code> object.
		 * @throws ArgumentError
		 * 		ArgumentError - If <code>id</code> is <code>0</code>.
		 * @see http://livedocs.adobe.com/flex/3/langref/ArgumentError.html ArgumentError
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/AsyncToken.html mx.rpc.AsyncToken
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/IResponder.html mx.rpc.IResponder
		 */
		public function getItem(id:uint):AsyncToken
		{
			if (id == 0)
				throw new ArgumentError("Cannot get uncreated item.");
			return getOperation("getItem").send(id);
		}
		/**
		 * Searches for an item that matches a textual string.
		 *  
		 * @param text
		 * 		Textual string to search. This gets trimmed before sending.
		 * @return
		 * 		If <code>text.length</code> is less than <code>minSearchTextLength</code>, then this
		 * 		method returns <code>null</code>. Otherwise, this method retrurns an asynchronous token
		 * 		for tracking the server response. On success, responders are passed a
		 * 		<code>ResultEvent</code> object, where the <code>result</code> property is an
		 * 		<code>ArrayCollection</code> object (possibly empty) containing references
		 * 		(<code>PersistentRef</code> objects) to all matching objects. On failure, responders are
		 * 		passed a <code>FaultEvent</code> object.

		 * @throws ArgumentError
		 * 		ArgumentError - If <code>id</code> is <code>0</code>.
		 * @see #minSearchTextLength
		 * @see a3lbmonkeybrain.hippocampus.domain.PersistentRef
		 * @see a3lbmonkeybrain.brainstem.utils.core.StringUtil#trim
		 * @see http://livedocs.adobe.com/flex/3/langref/ArgumentError.html ArgumentError
		 * @see http://livedocs.adobe.com/flex/3/langref/String.html#length String.length
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/AsyncToken.html mx.rpc.AsyncToken
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/IResponder.html mx.rpc.IResponder
		 */
		public function search(text:String):AsyncToken
		{
			if (text == null);
				throw new ArgumentError("Null argument.");
			text = StringUtil.trim(text);
			if (text.length < minSearchTextLength)
				return null;
			else
				return getOperation("search").send(text);
		}
		/**
		 * Sends a request to update an item on the server.
		 * 
		 * @param item
		 * 		Item to update.
		 * @param updateVersion
		 * 		If <code>true</code>, automatically increments the <code>version</code> property
		 * 		of <code>item</code> after a successful response.
		 * @return 
		 * 		An asynchronous token for tracking the server response. On success, responders are passed
		 * 		a <code>ResultEvent</code> object, where the <code>result</code> property is
		 * 		<code>null</code>. On failure, responders are passed a <code>FaultEvent</code> object.
		 * @throws ArgumentError
		 * 		ArgumentError - If <code>item</code> is null, or of its <code>id</code> property is
		 * 		<code>0</code> (indicating that it has not yet been persisted).
		 * @see a3lbmonkeybrain.hippocampus.domain.Persistent#id
		 * @see a3lbmonkeybrain.hippocampus.domain.Persistent#version
		 * @see http://livedocs.adobe.com/flex/3/langref/ArgumentError.html ArgumentError
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/AsyncToken.html mx.rpc.AsyncToken
		 * @see http://livedocs.adobe.com/flex/3/langref/mx/rpc/IResponder.html mx.rpc.IResponder
		 */
		public function updateItem(item:Persistent, updateVersion:Boolean = true):AsyncToken
		{
			if (item == null)
				throw new ArgumentError("Null argument.");
			if (item.id == 0)
				throw new ArgumentError("Cannot update uncreated item.");
			const token:AsyncToken = getOperation("updateItem").send(item.id);
			if (updateVersion)
				token.addResponder(new UpdateItemResponder(item));
			return token;
		}
	}
}
	import mx.rpc.IResponder;
	import a3lbmonkeybrain.hippocampus.domain.Persistent;
	
class CreateItemResponder implements IResponder
{
	private var item:Persistent;
	public function CreateItemResponder(item:Persistent):void
	{
		super();
		this.item = item;	
	}
	public function fault(faultEvent:Object):void
	{
		// Ignore.
	}
	public function result(resultEvent:Object):void
	{
		item.id = resultEvent.result as uint;
		item = null;
	}
}
class DeleteItemResponder implements IResponder
{
	private var item:Persistent;
	public function DeleteItemResponder(item:Persistent):void
	{
		super();
		this.item = item;	
	}
	public function fault(faultEvent:Object):void
	{
		// Ignore.
	}
	public function result(resultEvent:Object):void
	{
		item.id = 0;
		item = null;
	}
}
class UpdateItemResponder implements IResponder
{
	private var item:Persistent;
	public function UpdateItemResponder(item:Persistent):void
	{
		super();
		this.item = item;
	}
	public function fault(faultEvent:Object):void
	{
		// Ignore.
	}
	public function result(resultEvent:Object):void
	{
		item.version++;
		item = null;
	}
}