package a3lbmonkeybrain.synapse.streamClient
{
	import a3lbmonkeybrain.brainstem.core.findClass;
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.brainstem.core.Property;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.brainstem.relate.Equatable;
	
	/**
	 * Abstract superclass for information wrappers used by <code>NetStreamClient</code> events.
	 * <p>
	 * This class should not be extended by classes in other packages.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 */
	public class AbstractNetStreamInfo implements Equatable
	{
		private var _propertyNames:Array /* .<String> */;
		/**
		 * @private 
		 */
		protected var info:Object;
		/**
		 * Creates a new instance.
		 *  
		 * @param info
		 * 		Information object to wrap.
		 * @private
		 */
		public function AbstractNetStreamInfo(info:Object)
		{
			super();
			this.info = (info == null) ? {} : info;
		}
		/**
		 * A list of the names of all properties available from this object.
		 * 
		 * @see #getProperty()
		 */
		public function get propertyNames():Array /* .<String> */
		{
			if (_propertyNames == null)
			{
				_propertyNames = [];
				for (var p:String in info)
				{
					_propertyNames.push(p);
				}
			} 
			return _propertyNames.concat();
		}
		/**
		 * @inheritDoc
		 */
		public function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (value == null)
				return false;
			if (findClass(value) != findClass(this))
				return false;
			const other:AbstractNetStreamInfo = value as AbstractNetStreamInfo;
			if (!Equality.arraysEqual(propertyNames, other.propertyNames, false, false))
				return false;
			return Equality.equal(info, other.info, Property.AUTO_PROPERTIES, false, false); 
		}
		/**
		 * Retrieves a property from this object.
		 *  
		 * @param name
		 * 		The name of the property.
		 * @return 
		 * 		Object, or <code>undefined</code> if there is no such property.
		 * @see #propertyNames
		 */
		public function getProperty(name:String):*
		{
			if (info.hasOwnProperty(name))
				return info[name];
			return undefined;
		}
		/**
		 * @inheritDoc 
		 */
		public final function toString():String
		{
			var s:String = "[" + findClassName(this);
			const fields:Array /* .<String> */ = [];
			for (var p:String in info)
			{
				var field:String = p + "=";
				try
				{
					if (info[p] is String)
						field += "\"" + info[p] + "\"";
					else
						field += info[p];
				}
				catch (e:Error)
				{
					field += "<Error:\"" + e.message + "\">";
				}
				fields.push(field);
			} 
			if (fields.length > 0)
				s += " " + fields.join(" ");
			return s + "]";
		}
	}
}