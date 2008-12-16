package a3lbmonkeybrain.synapse.email
{
	import flexunit.framework.TestCase;

	/**
	 * @private
	 */
	public final class EmailTest extends TestCase
	{
		public function testOpen():void
		{
			var email:Email = new Email();
			email.addRecipient(new EmailRecipient("test@mail.tld"));
			email.addRecipient(new EmailRecipient("foo@bar.tld", EmailRecipientType.BCC));
			email.subject = "test";
			email.body = "This is a test of a3lbmonkeybrain.net.email.Email.";
			email.open();
		}
	}
}