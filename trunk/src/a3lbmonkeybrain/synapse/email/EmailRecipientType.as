package a3lbmonkeybrain.synapse.email
{
	import a3lbmonkeybrain.brainstem.relate.Ordered;
	
	/**
	 * Each instance of this class represents a type of email recipient: <code>To</code>, <code>Cc</code>, or
	 * <code>Bcc</code>.
	 * 
	 * @author T. Michael Keesey
	 * @see EmailRecipient
	 * @see EmailRecipient#type
	 */
	public final class EmailRecipientType implements Ordered
	{
		/**
		 * Instance of the class for <code>Bcc</code> (blind carbon-copy) recipients. These recipients do not
		 * appear in emails to other recipients.
		 */
		public static const BCC:EmailRecipientType = new EmailRecipientType(Lock, "Bcc");
		/**
		 * Instance of the class for <code>Cc</code> (carbon-copy) recipients. 
		 */
		public static const CC:EmailRecipientType = new EmailRecipientType(Lock, "Cc");
		/**
		 * Instance of the class for <code>To</code> recipients. 
		 */
		public static const TO:EmailRecipientType = new EmailRecipientType(Lock, "To");
		private var _name:String;
		/**
		 * Creates a new instance. Do not invoke this constructor; it should only be used by this class' constants.
		 *  
		 * @param lock
		 * 		Lock class; ensures that only this class can make instances.
		 * @param name
		 * 		The name of this type of email recipient.
		 * @throws TypeError
		 * 		<code>TypeError</code>: If there is an attempt to create an instance outside of this class.
		 * @see #BCC
		 * @see #CC
		 * @see #TO
		 * @see #name
		 */
		public function EmailRecipientType(lock:Class, name:String)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
			_name = name;
		}
		/**
		 * The name of this type of email recipient. 
		 */
		public function get name():String
		{
			return _name;
		}
		/**
		 * @inheritDoc
		 */
		public function equals(value:Object):Boolean
		{
			return this == value;
		}
		/**
		 * @inheritDoc
		 */
		public function findOrder(value:Object):int
		{
			if (this == value || !(value is EmailRecipientType))
				return 0;
			if (this == TO)
				return -1;
			if (this == CC)
				return (value == TO) ? 1 : -1;
			return 1; 
		}
		/**
		 * @inheritDoc 
		 */
		public function toString():String
		{
			return "[EmailRecipientType " + name + "]";
		}
	}
}
class Lock
{
}