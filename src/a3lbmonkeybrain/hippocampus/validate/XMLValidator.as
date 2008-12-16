package a3lbmonkeybrain.hippocampus.validate
{
	import a3lbmonkeybrain.brainstem.w3c.xml.XMLNodeKind;
	
	import mx.validators.ValidationResult;
	import mx.validators.Validator;

	[Bindable]
	public class XMLValidator extends Validator
	{
		public var childrenMissingError:String = "Empty XML element.";
		public var childrenRequired:Boolean = true;
		public var rootIsElement:Boolean = true;
		public var rootNotElementError:String = "Root XML object is not an element.";
		public var xmlParseError:String = "Error parsing XML: %message";
		public function XMLValidator()
		{
			super();
		}
		override protected function doValidation(value:Object):Array
		{
			var results:Array = super.doValidation(value);
			try
			{
				var xml:XML = value is XML ? value as XML : new XML(value);
			}
			catch (e:TypeError)
			{
				results.push(new ValidationResult(true, null, "xmlParse",
					xmlParseError.replace("%message", e.message)));
			}
			if (rootIsElement)
			{
				if (xml.nodeKind() != XMLNodeKind.ELEMENT)
					results.push(new ValidationResult(true, null, "rootNotElement", rootNotElementError));
			}
			if (childrenRequired)
			{
				if (xml.children().length() == 0)
					results.push(new ValidationResult(true, null, "childrenMissing", childrenMissingError));
			}
			return results;
		}
	}
}