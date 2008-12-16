package a3lbmonkeybrain.hippocampus.validate
{
	import a3lbmonkeybrain.hippocampus.domain.Persistent;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import mx.collections.IList;
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	[Bindable]
	public class EntityListValidator extends Validator
	{
		protected var _entityClass:Class = Persistent;
		public var invalidElementError:String = "This list has an invalid element.";
		public var maxElements:uint = uint.MAX_VALUE;
		public var minElements:uint = 0;
		public var mustBePersisted:Boolean = true;
		public var notListError:String = "The value is not a list. (Must implement mx.collections::IList.)";
		public var notPersistedError:String = "An element has not been persisted.";
		public var tooFewElementsError:String = "There must be at least %minElements elements.";
		public var tooManyElementsError:String = "There must be no more than %maxElements elements.";
		public function EntityListValidator()
		{
			super();
		}
		[Bindable(event = "entityClassChange")]
		public function get entityClass():Class
		{
			return _entityClass;
		}
		public function set entityClass(value:Class):void
		{
			if (_entityClass != value)
			{
				_entityClass = value;
				dispatchEvent(new Event("entityClassChange"));
			}
		}
		public function set entityClassName(value:String):void
		{
			entityClass = getDefinitionByName(value) as Class;
		}
		override protected function doValidation(value:Object):Array
		{
			var results:Array = super.doValidation(value);
			if (value is IList)
			{
				const list:IList = value as IList;
				const n:uint = list.length;
				if (n < minElements)
				{
					results.push(new ValidationResult(true, null, "tooFewElements",
						tooFewElementsError.replace("%minElement", minElements)));
				}
				if (n > maxElements)
				{
					results.push(new ValidationResult(true, null, "tooManyElements",
						tooManyElementsError.replace("%maxElement", maxElements)));
				}
				const elementValidator:Validator = new MetadataValidator();
				for (var i:int = 0; i < n; ++i)
				{
					var element:Object = list.getItemAt(i);
					if (!(element is Persistent) || !(element is _entityClass))
					{
						results.push(new ValidationResult(true, null, "invalidElement", invalidElementError));
					}
					else if (mustBePersisted && Persistent(element).id == 0)
					{
						results.push(new ValidationResult(true, null, "notPersisted", notPersistedError));
						results = results.concat(elementValidator.validate(element, true).results);
					}
				}
			}
			else
			{
				results.push(new ValidationResult(true, null, "notList", notListError));
			}
			return results;
		}
	}
}