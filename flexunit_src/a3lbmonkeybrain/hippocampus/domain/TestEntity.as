package a3lbmonkeybrain.hippocampus.domain
{
	import a3lbmonkeybrain.brainstem.strings.capitalize;
	import a3lbmonkeybrain.brainstem.strings.clean;
	import a3lbmonkeybrain.brainstem.strings.trim;
	import a3lbmonkeybrain.hippocampus.text.TestEntityReader;
	import a3lbmonkeybrain.hippocampus.text.TestEntityWriter;
	
	import mx.collections.ArrayCollection;
	import mx.validators.RegExpValidator;

	[Bindable]
	[Description("This is a test implementation of &lt;code&gt;Entity&lt;/code&gt;.")]
	[Event(name = "propertyChange", type = "mx.events.PropertyChangeEvent")]
	[Reader("a3lbmonkeybrain.hippocampus.text.TestEntityReader")]
	[RemoteClass(alias = "a3lbmonkeybrain.hippocampus.domain.TestEntity")]
	[Writer("a3lbmonkeybrain.hippocampus.text.TestEntityWriter")]
	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class TestEntity extends AbstractPersistent
	{
		private static const REQUIRED_CLASSES:Array
			= [RegExpValidator, TestEntityReader, TestEntityWriter];
		private const _children:ArrayCollection = createEntityCollection(TestEntity);
		private var _name:String = "";
		private var _vernacular:String = "";
		[Field(index = 3, label = "Checked:")]
		public var checked:Boolean = false;
		[Field(index = 2, label = "Number:")]
		public var number:uint;
		public function TestEntity()
		{
			super();
		}
		//[Field(type = "a3lbmonkeybrain.hippocampus.fields.EntityListField",
		//	entityClassName = "a3lbmonkeybrain.hippocampus.domain.TestEntity")]
		public function get children():ArrayCollection
		{
			return _children;
		}
		public function set children(value:ArrayCollection):void
		{
			_children.source = value ? value.source : [];
			_children.refresh();
		}
		[Field(type = "a3lbmonkeybrain.hippocampus.ui.forms.StackField",
			index = 0,
			label = "Name:",
			maxChars = 64,
			restrict="A-Za-z")]
		[Validator(type = "mx.validators.RegExpValidator",
			expression="^[A-Z][a-z]*$",
			noMatchError = "Name must be a single, capitalized word.",
			required = true,
			requiredFieldError = "Name is required.")] 
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			_name = assessPropertyValue("name", trim(capitalize(value))) as String;
			flushPendingPropertyEvents();
		}
		[Field(type = "a3lbmonkeybrain.hippocampus.ui.forms.StackField",
			index = 1,
			label = "Vernacular:",
			maxChars = 64,
			restrict = "a-z '-'")]
		[Validator(type = "mx.validators.RegExpValidator",
			expression="^[^\\s]+( [^\\s]+)*$",
			noMatchError = "Vernacular form must be one or more lower-case words.",
			required = true,
			requiredFieldError = "Vernacular form is required.")] 
		public function get vernacular():String
		{
			return _vernacular;
		}
		public function set vernacular(value:String):void
		{
			_vernacular = assessPropertyValue("vernacular", clean(value)) as String;
			flushPendingPropertyEvents();
		}
	}
}