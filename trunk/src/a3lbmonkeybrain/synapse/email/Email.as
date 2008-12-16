package a3lbmonkeybrain.synapse.email
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	/**
	 * Stores information for email links (<code>mailto</code> protocol).
	 * <p>
	 * This class may be extended to create standardized email formats.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 */
	public class Email
	{
		/**
		 * @private 
		 */
		protected var _body:String = "";
		/**
		 * @private 
		 */
		protected var _recipients:Array /* .<EmailRecipient> */;
		/**
		 * @private 
		 */
		protected var _subject:String = "";
		/**
		 * Creates a new instance.
		 */
		public function Email()
		{
			super();
			_recipients = [];
		}
		/**
		 * The body of this email message. 
		 */
		public function get body():String
		{
			return _body;
		}
		/**
		 * @private
		 */
		public function set body(value:String):void
		{
			_body = value || ""; 
		}
		/**
		 * The list of recipients. Each element is an <code>EmailRecipient</code> object.
		 * <p>
		 * This property cannot be modified directly. You must use methods of the <code>Email</code> class to modify it.
		 * </p> 
		 * 
		 * @see #addRecipient()
		 * @see #findRecipientsByAddress()
		 * @see #findRecipientsByType()
		 * @see #hasRecipient()
		 * @see #removeAllRecipients()
		 * @see #removeRecipient()
		 * @see #removeRecipientsByAddress()
		 * @see #removeRecipientsByType()
		 * @see EmailRecipient
		 */
		public function get recipients():Array /* .<EmailRecipient> */
		{
			return _recipients.concat();
		}
		/**
		 * The subject of the email. 
		 */
		public function get subject():String
		{
			return _subject;
		}
		/**
		 * @private
		 */
		public function set subject(value:String):void
		{
			_subject = value || ""; 
		}
		/**
		 * Converts this object to a URL request (<code>mailto</code> protocol).
		 * 
		 * @see flash.net.URLRequest
		 */
		public function get urlRequest():URLRequest
		{
			const request:URLRequest = new URLRequest("mailto:"
				+ EmailRecipient.joinAddresses(findRecipientsByType(EmailRecipientType.TO)));
			request.data = urlVariables;
			request.method = URLRequestMethod.GET;
			return request;
		}
		/**
		 * Converts the data in this object to a <code>URLVariables</code> object.
		 * 
		 * @see flash.net.URLVariables
		 */
		public function get urlVariables():URLVariables
		{
			const vars:URLVariables = new URLVariables();
			addRecipientsToURLVariables(vars, EmailRecipientType.CC);
			addRecipientsToURLVariables(vars, EmailRecipientType.BCC);
			if (subject.length > 0)
				vars["subject"] = subject;
			if (body.length > 0)
				vars["body"] = body;
			return vars;
		}
		/**
		 * Adds a recipient to the list.
		 *  
		 * @param value
		 * 		Object detailing recipient information.
		 * @see #recipients
		 */
		public function addRecipient(value:EmailRecipient):void
		{
			if (!hasRecipient(value))
				_recipients.push(value.clone());
		}
		/**
		 * Adds recipients of a certain type to a <code>URLVariables</code> object.
		 *  
		 * @param vars
		 * 		<code>URLVariables</code> object to add data to.
		 * @param type
		 * 		The type of email recipient to add to <code>vars</code>.
		 * @see #recipients
		 * @see flash.net.URLVariables
		 */
		protected function addRecipientsToURLVariables(vars:URLVariables, type:EmailRecipientType):void
		{
			const recipients:Array /* .<EmailRecipient> */ = findRecipientsByType(type);
			if (recipients.length > 0)
				vars[type.name] = EmailRecipient.joinAddresses(recipients);
		}
		/**
		 * Retrieves all recipients with a certain address.
		 *  
		 * @param address
		 * 		The address to retrieve entries for.
		 * @return 
		 * 		An array of <code>EmailRecipient</code> objects. May be empty.
		 * @see #recipients
		 * @see EmailRecipient#address
		 */
		public function findRecipientsByAddress(address:String):Array /* .<EmailRecipient> */
		{
			const results:Array /* .<EmailRecipient> */ = [];
			for each (var recipient:EmailRecipient in _recipients)
			{
				if (recipient.address == address)
					results.push(recipient)
			}
			return results;
		}
		/**
		 * Retrieves all recipients of a certain type.
		 *  
		 * @param type
		 * 		The type of email recipient to retrieve.
		 * @return 
		 * 		An array of <code>EmailRecipient</code> objects. May be empty.
		 * @see #recipients
		 * @see EmailRecipient#type
		 */
		public function findRecipientsByType(type:EmailRecipientType):Array /* .<EmailRecipient> */
		{
			const results:Array /* .<EmailRecipient> */ = [];
			for each (var recipient:EmailRecipient in _recipients)
			{
				if (recipient.type == type)
					results.push(recipient)
			}
			return results;
		}
		/**
		 * Opens the user's email client using the data stored in this object. 
		 */
		public function open():void
		{
			navigateToURL(urlRequest, "_self");
		}
		/**
		 * Checks if a certain recipient is in the recipient list.
		 *  
		 * @param value
		 * 		Recipient to check for. Does not have to be the same object as the object being searched for; only has
		 * 		to store the same information.
		 * @return 
		 * 		A value of <code>true</code> if a matching object was found in <code>recipients</code>;
		 * 		<code>false</code> if not.
		 * @see #recipients
		 * @see EmailRecipient#equals()
		 */
		public function hasRecipient(value:EmailRecipient):Boolean
		{
			for each (var recipient:EmailRecipient in _recipients)
			{
				if (recipient.equals(value))
					return true;
			}
			return false;
		}
		/**
		 * Removes all recipients from the list. 
		 * 
		 * @see #recipients
		 */
		public function removeAllRecipients():void
		{
			_recipients = [];
		}
		/**
		 * Removes a recipient from the list.
		 *  
		 * @param value
		 * 		Recipient to remove. Does not have to be the same object as the object being searched for; only has
		 * 		to store the same information.
		 * @see #recipients
		 */
		public function removeRecipient(value:EmailRecipient):void
		{
			const n:int = _recipients.length
			for (var i:int = 0; i < n; ++i)
			{
				if (EmailRecipient(_recipients[i]).equals(value))
				{
					_recipients.splice(i, 1);
					return;	
				}
			}
		}
		/**
		 * Removes all recipients of a certain type
		 *  
		 * @param address
		 * 		Email address; removes all entries matching this address.
		 * @see #recipients
		 * @see EmailRecipient#address
		 */
		public function removeRecipientsByAddress(address:String):void
		{
			for (var i:int = _recipients.length - 1; i >= 0; --i)
			{
				if (EmailRecipient(_recipients[i]).address == address)
					_recipients.splice(i, 1);
			}
		}
		/**
		 * Removes all recipients of a certain type.
		 *  
		 * @param type
		 * 		Type of recipient to remove.
		 * @see #recipients
		 * @see EmailRecipient#type
		 */
		public function removeRecipientsByType(type:EmailRecipientType):void
		{
			for (var i:int = _recipients.length - 1; i >= 0; --i)
			{
				if (EmailRecipient(_recipients[i]).type == type)
					_recipients.splice(i, 1);
			}
		}
		/**
		 * @inheritDoc 
		 */
		public function toString():String
		{
			return "[Email " + urlRequest + "]";
		}
	}
}