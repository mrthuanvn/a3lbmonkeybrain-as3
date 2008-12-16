package a3lbmonkeybrain.synapse.email
{
	import a3lbmonkeybrain.brainstem.relate.Ordered;
	import a3lbmonkeybrain.brainstem.strings.Expressions;
	
	/**
	 * Stores information on the recipient of an email.
	 * 
	 * @author T. Michael Keesey
	 */
	public final class EmailRecipient implements Ordered
	{
		private var _address:String = "";
		private var _type:EmailRecipientType;
		/**
		 * Creates a new instance.
		 *  
		 * @param address
		 * 		Email address, retrievable as <code>EmailRecipient.address</code>.
		 * @param type
		 * 		Type of recipient, retrievable as <code>EmailRecipient.type</code>. Defaults to
		 * 		<code>EmailRecipientType.TO</code>.
		 * @see #address
		 * @see #type
		 * @see EmailRecipientType
		 * @see EmailRecipientType#TO
		 * @throws ArgumentError
		 * 		<code>ArgumentError</code>: If <code>address</code> is not a validly-formatted email address. 
		 */
		public function EmailRecipient(address:String, type:EmailRecipientType = null)
		{
			super();
			this.address = address;
			this.type = type;
		}
		/**
		 * The recipient's email address.
		 * 
		 * @throws ArgumentError
		 * 		<code>ArgumentError</code>: If <code>address</code> is not a validly-formatted email address. 
		 */
		public function get address():String
		{
			return _address;
		}
		/**
		 * @private
		 */
		public function set address(value:String):void
		{
			if (value == null)
				throw new TypeError("Null email address");
			if (!Expressions.EMAIL.test(value))
				throw new ArgumentError("Invalid email address.");
			_address = value;
		}
		/**
		 * Type of recipient.
		 * 
		 * @defaultValue EmailRecipientType.TO
		 * @see EmailRecipientType
		 * @see EmailRecipientType#TO
		 */
		public function get type():EmailRecipientType
		{
			return _type;
		}
		/**
		 * @private
		 */
		public function set type(value:EmailRecipientType):void
		{
			_type = (type == null) ? EmailRecipientType.TO : type;
		}
		/**
		 * Creates a copy of this object.
		 *  
		 * @return 
		 * 		New <code>EmailRecipient</code> instance with the same data as this one.
		 */
		public function clone():EmailRecipient
		{
			return new EmailRecipient(address, type);
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
			if (value is EmailRecipient)
				return address == EmailRecipient(value).address && EmailRecipient(type) == value.type;
			return false;
		}
		/**
		 * @inheritDoc
		 */
		public function findOrder(value:Object):int
		{
			if (value is EmailRecipient)
			{
				const order:int = _type.findOrder(EmailRecipient(value)._type);
				if (order != 0)
					return order;
				const otherAddress:String = EmailRecipient(value)._address;
				if (_address < otherAddress)
					return -1;
				if (_address != otherAddress)
					return 1;
			} 
			return 0;
		}
		/**
		 * Joins the address in an array of <code>EmailRecipient</code> objects.
		 * 
		 * @param values
		 * 		Array of <code>EmailRecipient</code> objects.
		 * @return 
		 * 		String of comma-separated email addresses (no spaces).
		 */
		public static function joinAddresses(values:Array /* .<EmailRecipient> */):String
		{
			if (values == null || values.length == 0)
				return "";
			const addresses:Array /* .<String> */ = [];
			for each (var recipient:EmailRecipient in values)
			{
				addresses.push(recipient.address);
			}
			return addresses.join(",");
		}
		/**
		 * @inheritDoc 
		 */
		public function toString():String
		{
			return "[EmailRecipient address=\"" + address + "\" type=\"" + type.name + "\"]";
		}
	}
}