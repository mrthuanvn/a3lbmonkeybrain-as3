package a3lbmonkeybrain.hippocampus.validate
{
	import a3lbmonkeybrain.hippocampus.domain.Persistent;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	[Bindable]
	public class EntityValidator extends Validator
	{
		protected var _entityClass:Class = Persistent;
		public var mustBePersisted:Boolean = true;
		public var invalidEntityError:String = "This is not a valid entity.";
		public var notPersistedError:String = "Entity must be persisted.";
		public function EntityValidator()
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
			const results:Array = super.doValidation(value);
			if (!(value is _entityClass) || !(value is Persistent))
				results.push(new ValidationResult(true, null, "invalidEntity", invalidEntityError));
			else if (mustBePersisted && Persistent(value).id == 0)
				results.push(new ValidationResult(true, null, "notPersisted", notPersistedError));
			if (!mustBePersisted)
				return results.concat(new MetadataValidator().validate(value, true).results);
			return results;
		}
	}
}