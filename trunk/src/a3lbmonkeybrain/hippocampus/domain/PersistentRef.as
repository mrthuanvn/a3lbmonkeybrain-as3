package a3lbmonkeybrain.hippocampus.domain
{
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.brainstem.relate.Ordered;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;

	[Bindable]
	[RemoteClass(alias = "a3lbmonkeybrain.hippocampus.domain.PersistentRef")]
	/**
	 * A lightweight reference to an entity, containing a textual description (optionally with
	 * HTML markup), the qualified name of its class, and its ID number (primary key).
	 * <p>
	 * If transmitted via AMF, then the corresponding server-side class should have the alias
	 * <code>&quot;a3lbmonkeybrain.hippocampus.domain.EntityRef&quot;</code>.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see Entity
	 * @see Entity#id
	 * @see flash.utils.getQualifiedClassName()
	 */
	public final class PersistentRef extends EventDispatcher implements EntityClassAssociate, Ordered
	{
		private var _entityClassName:String = "";
		private var _htmlText:String = "";
		private var _id:uint = 0;
		/**
		 * Creates a new instance.
		 */
		public function PersistentRef()
		{
			super();
		}
		[Bindable(event = "entityClassNameChange")]
		/**
		 * The class referred to by <code>entityClassName</code>.
		 * 
		 * @see #entityClassName
		 */
		public function get entityClass():Class
		{
			return getDefinitionByName(_entityClassName) as Class;
		}
		[Bindable(event = "entityClassNameChange")]
		/**
		 * The qualified name of the referenced entity's class.
		 * 
		 * @see #entityClass
		 * @see flash.utils.getQualifiedClassName()
		 */
		public function get entityClassName():String
		{
			return _entityClassName;
		}
		/**
		 * @private
		 */
		public function set entityClassName(value:String):void
		{
			value = value ? value : "";
			if (_entityClassName != value)
			{
				_entityClassName = value;
				if (hasEventListener("entityClassNameChange"))
					dispatchEvent(new Event("entityClassNameChange"));
			}
		}
		[Bindable(event = "htmlTextChange")]
		/**
		 * A textual description of the referenced entity, optionally with HTML markup.
		 * 
		 * @see #text
		 */
		public function get htmlText():String
		{
			return _htmlText;
		}
		/**
		 * @private
		 */
		public function set htmlText(value:String):void
		{
			value = value ? value : "";
			if (_htmlText != value)
			{
				_htmlText = value;
				dispatchEvent(new Event("htmlTextChange"));
			}
		}
		[Bindable(event = "idChange")]
		/**
		 * The ID number (primary key) of the referenced entity. 
		 * 
		 * @see Entity#id
		 */
		public function get id():uint
		{
			return _id;
		}
		/**
		 * @private
		 */
		public function set id(value:uint):void
		{
			if (_id != value)
			{
				_id = value;
				dispatchEvent(new Event("idChange"));
			}
		}
		[Bindable(event = "htmlTextChange")]
		/**
		 * A plain-text description of the referenced entity. Italicized text is changed to capitals.
		 * 
		 * @see #htmlText
		 */
		public function get text():String
		{
			var s:String = "";
			var upper:Boolean = false;
			const n:int = _htmlText.length;
			for (var i:int = 0; i < n; ++i)
			{
				if (!upper)
				{
					if (_htmlText.substr(i, 3) == "<i>")
						upper = true;
				}
				else if (_htmlText.substr(i, 4) == "</i>")
				{
					upper = false;
				}
				s += upper ? _htmlText.charAt(i).toUpperCase() : _htmlText.charAt(i);
			}
			return s.replace(/<[^>]+>/g, "").replace("&quot;", "\"").replace("&amp;", "&")
				.replace("&lt;", "<").replace("&gt;", ">").replace("&apos;", "'");
		}
		/**
		 * @inheritDoc
		 */
		public function equals(value:Object):Boolean
		{
			if (value is PersistentRef)
			{
				const other:PersistentRef = value as PersistentRef;
				return _entityClassName == other._entityClassName && _id == other._id;
			}
			return false;
		}
		/**
		 * @inheritDoc
		 */
		public function findOrder(value:Object):int
		{
			if (value is PersistentRef)
			{
				const other:PersistentRef = value as PersistentRef;
				if (other._entityClassName != _entityClassName)
					return _entityClassName < other._entityClassName ? -1 : 1;
				const t:String = text;
				const otherT:String = other.text;
				if (t != otherT)
					return t < otherT ? -1 : 1;
			}
			return 0;
		}
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return "[" + findClassName(entityClass) + "Ref #" + id + " " + text + "]";
		}
	}
}