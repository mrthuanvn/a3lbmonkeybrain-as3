package a3lbmonkeybrain.brainstem.strings
{
	/**
	 * <code>Exressions</code> is a static class with commonly-used regular expressions.
	 * 
	 * @author T. Michael Keesey
	 */
	public final class Expressions
	{
		/**
		 * Regular expression for validating email addresses.
		 * 
		 * @see http://www.regular-expressions.info/email.html
		 * 		How to Find or Validate an Email Address 
		 */		
		public static const EMAIL:RegExp = /^[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)$/i;
		/**
		 * Regular expression for validating universal resource identifiers (URIs).
		 * 
		 * @see http://tools.ietf.org/html/rfc3986#appendix-B
		 * 		Uniform Resource Identifier (URI): Generic Syntax - Appendix B. Parsing a URI Reference with a Regular Expression
		 */
		public static const URI:RegExp = /^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\\?([^#]*))?(#(.*))?::.+$/;
		/**
		 * @private 
		 */
		public function Expressions()
		{
			super();
			throw new TypeError();
		}
	}
}