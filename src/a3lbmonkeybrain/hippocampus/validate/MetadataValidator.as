package a3lbmonkeybrain.hippocampus.validate
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.ValidationResultEvent;
	import mx.validators.Validator;
	
	import a3lbmonkeybrain.brainstem.metadata.MetadataError;
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;

	public final class MetadataValidator extends Validator
	{
		private const nameHash:Object = {};
		private const propertyHash:Object = {};
		private const typeList:Array = [];
		private const validators:Array = [];
		private var _entityClass:Class;
		private var _useValueDirectly:Boolean = false;
		public function MetadataValidator()
		{
			super();
			requiredFieldError = "The entity has not been set.";
		}
		[Bindable(event = "useValueDirectlyChange")]
		public function get useValueDirectly():Boolean
		{
			return _useValueDirectly;
		}
		public function set useValueDirectly(value:Boolean):void
		{
			if (_useValueDirectly != value)
			{
				_useValueDirectly = value;
				_entityClass = null;
				clearValidators();
				dispatchEvent(new Event("useValueDirectlyChange"));
			}
		}
		private function clearValidators():void
		{
			while (validators.length > 0)
			{
				validators.pop();
			}
			while (typeList.length > 0)
			{
				typeList.pop();
			}
			var name:String;
			for (name in nameHash)
			{
				delete nameHash[name];
			}
			for (name in propertyHash)
			{
				delete propertyHash[name];
			}
		}
		private function createValidator(metadata:XML, value:Object):Validator
		{
			const validator:Validator = MetadataUtil.createObject(metadata, "type", Validator, Validator)
				as Validator;
			MetadataUtil.copyArgs(metadata, validator, ["type", "name"]);
			const name:String = MetadataUtil.getArgValue(metadata, "name") as String;
			if (name != null && name.length > 0)
			{
				if (nameHash[name] is Validator)
					throw new MetadataError("Validator name used more than once: " + name);
				nameHash[name] = validator;
			}
			const parent:XML = metadata.parent() as XML;
			if (_useValueDirectly && value is IEventDispatcher)
			{
				const validate:Function = function(event:Event):void
				{
					validator.validate();
				}
				for each (var bindable:XML in parent..metadata.(@name == "Bindable"))
				{
					var type:String = MetadataUtil.getArgValue(bindable, "event") as String;
					if (type != null && type.length > 0)
						IEventDispatcher(value).addEventListener(type, validate, false, 0, true);
				}
			}
			switch (QName(parent.name()).localName)
			{
				case "accessor" :
				{
					prepareValidatorForAccessor(validator, value, parent);
					break;
				}
				case "type" :
				{
					prepareValidatorForType(validator, value, parent);
					break;
				}
				case "variable" :
				{
					prepareValidatorForVariable(validator, value, parent);
					break;
				}
				default :
				{
					trace("[WARNING]", "Cannot prepare validator for " + parent.name() + ".");
					break;
				}
			}
			return validator;
		}
		override protected function doValidation(value:Object):Array
		{
			prepareForValue(value);
			var results:Array = super.doValidation(value);
			for each (var validator:Validator in validators)
			{
				var event:ValidationResultEvent = validator.validate();
				if (event.results.length > 0)
					results = results.concat(event.results);
			}
			return results;
		}
		public static function fromEntity(entity:Object):MetadataValidator
		{
			const validator:MetadataValidator = new MetadataValidator();
			validator.prepareForValue(entity);
			return validator;
		}
		public function getByName(name:String):Validator
		{
			if (nameHash.hasOwnProperty(name))
				return nameHash[name] as Validator;
			return null;
		}
		public function getByProperty(property:String):Validator
		{
			if (propertyHash.hasOwnProperty(property))
				return propertyHash[property] as Validator;
			return null;
		}
		public function getForType():Array
		{
			return typeList.concat();
		}
		private function prepareValidatorForAccessor(validator:Validator, value:Object, accessor:XML):void
		{
			if (_useValueDirectly)
			{
				if (accessor.@type == "writeonly")
				{
					validator.source = {value: value};
					validator.property = "value";
				}
				else
				{
					validator.source = value;
					validator.property = accessor.@name;
				}
			}
			propertyHash[accessor.@name] = validator;
		}
		private function prepareValidatorForType(validator:Validator, value:Object, type:XML):void
		{
			if (_useValueDirectly)
			{
				validator.source = {value: value};
				validator.property = "value";
			}
			typeList.push(validator);
		}
		private function prepareValidatorForVariable(validator:Validator, value:Object, variable:XML):void
		{
			if (_useValueDirectly)
			{
				validator.source = value;
				validator.property = variable.@name;
			}
			propertyHash[variable.@name] = validator;
		}
		public function prepareForValue(value:Object):void
		{
			if (value == null)
			{
				clearValidators();
			}
			else
			{
				const valueClass:Class = getDefinitionByName(getQualifiedClassName(value)) as Class;
				if (_entityClass != valueClass)
				{
					_entityClass = valueClass;
					updateValidators(value);
				}
			}
		}
		public static function test(entity:Object):Boolean
		{
			return ValidatorUtil.test(fromEntity(entity), entity);
		}
		private function updateValidators(value:Object):void
		{
			clearValidators();
			if (value == null)
				return;
			const type:XML = describeType(value);
			for each (var metadata:XML in type..metadata.(@name == "Validator"))
			{
				var validator:Validator = createValidator(metadata, value);
				if (validator != null)
					validators.push(validator);
			}
		}
	}
}