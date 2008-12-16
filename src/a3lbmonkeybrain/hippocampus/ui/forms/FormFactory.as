package a3lbmonkeybrain.hippocampus.ui.forms
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.controls.CheckBox;
	import mx.controls.List;
	import mx.controls.NumericStepper;
	import mx.controls.TextInput;
	import mx.core.Container;
	import mx.core.IDataRenderer;
	import mx.core.IPropertyChangeNotifier;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.validators.Validator;
	
	import a3lbmonkeybrain.brainstem.metadata.MetadataError;
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;
	import a3lbmonkeybrain.hippocampus.validate.MetadataValidator;
	
	public final class FormFactory
	{
		private var type:XML;
		private var form:Container;
		private var validator:MetadataValidator;
		public function FormFactory()
		{
			super();
		}
		private function createField(metadata:XML, formItem:FormItem):UIComponent
		{
			const parent:XML = metadata.parent() as XML;
			if (!isValidFieldParent(parent))
			{
				throw new MetadataError("Cannot create a [Field] tag on anything except a class, a variable, or a readable and writeable property ("
					+ parent.@name + ").");
			}
			const field:UIComponent = MetadataUtil.createObject(metadata, "type", UIComponent,
				getDefaultFieldClass(parent)) as UIComponent;
			if (!(field is IDataRenderer))
			{
				throw new MetadataError("Class does not implement mx.core::IDataRenderer: "
					+ getQualifiedClassName(field));
			}
			field.initialize();
			if (QName(parent.name()).localName == "type")
			{
				IDataRenderer(field).data = form.data;
			}
			else
			{
				const data:IPropertyChangeNotifier = form.data as IPropertyChangeNotifier;
				const property:String = parent.@name;
				new FieldBinding(form.data as IPropertyChangeNotifier, property, field);
				//BindingUtils.bindProperty(field, "data", form.data, property);
				//BindingUtils.bindProperty(form.data, property, field, "data");
			}
			field.percentWidth = 100;
			MetadataUtil.copyArgs(metadata, field, ["label", "required", "type", "index",
				"validator"]);
			initFieldValidator(field, metadata, formItem);
			field.addEventListener(FlexEvent.VALUE_COMMIT, form.dispatchEvent);
			return field;
		}
		private function createFormItem(metadata:XML):FormItem
		{
			const required:Boolean = MetadataUtil.getArgValue(metadata, "required") as Boolean;
			const formItem:FormItem = new FormItem();
			formItem.initialize();
			const label:String = MetadataUtil.getArgValue(metadata, "label") as String;
			if (label != null)
				formItem.label = label;
			formItem.percentWidth = 100;
			formItem.required = required;
			const field:UIComponent = createField(metadata, formItem);
			formItem.addChild(field);
			return formItem;
		}
		private function createFormItems():void
		{
			const indexedFormItems:Array = [];
			const unindexedFormItems:Array = [];
			for each (var metadata:XML in type..metadata.(@name == "Field"))
			{
				var formItem:FormItem = createFormItem(metadata);
				var index:Number = MetadataUtil.getArgValue(metadata, "index") as Number;
				if (isNaN(index))
				{
					unindexedFormItems.push(formItem);
				}
				else
				{
					index = Math.floor(index);
					if (indexedFormItems[index] != undefined)
						throw new MetadataError("Field index used more than once: " + index);
					indexedFormItems[index] = formItem;
				}
			}
			const n:int = indexedFormItems.length;
			const formItems:Array = new Array(n);
			for (var i:int = 0; i < n; ++i)
			{
				if (indexedFormItems[i] is UIComponent)
					formItems[i] = indexedFormItems[i];
				else
					formItems[i] = unindexedFormItems.shift();
			}
			while (unindexedFormItems.length > 0)
			{
				formItems.push(unindexedFormItems.shift());
			}
			form.tabChildren = true;
			var tabIndex:int = 0;
			for each (formItem in formItems)
			{
				if (formItem is FormItem)
				{
					formItem.tabIndex = tabIndex++;
					form.addChild(formItem);
				}
			}
		}
		public function createForData(data:IPropertyChangeNotifier):Container
		{
			type = describeType(data);
			createForm();
			form.data = data;
			createValidator();
			validator.prepareForValue(data);
			createFormItems();
			initTypeValidators();
			//validator.addEventListener(ValidationResultEvent.INVALID, form.dispatchEvent);
			//validator.addEventListener(ValidationResultEvent.VALID, form.dispatchEvent);
			type = null
			validator = null
			const tempForm:Container = form;
			form = null;
			return tempForm;
		}
		private function createForm():void
		{
			const forms:XMLList = type.metadata.(@name == "Form");
			if (forms.length() == 1)
			{
				const metadata:XML = forms[0] as XML;
				form = MetadataUtil.createObject(metadata, "type", Container, Form) as Container;
				MetadataUtil.copyArgs(metadata, form, ["type"]);
			}
			else
			{
				form = new Form();
			}
		}
		private function createValidator():void
		{
			validator = new MetadataValidator();
			validator.listener = form;
			validator.source = form;
			validator.property = "data";
			validator.trigger = form;
			validator.triggerEvent = FlexEvent.VALUE_COMMIT;
		}
		private static function getDefaultFieldClass(parent:XML):Class
		{
			const dataClassname:String = parent.name() == "type" ? parent.@name.toXMLString()
				: parent.@type.toXMLString();
			const dataClass:Class = getDefinitionByName(dataClassname) as Class;
			const dataType:XML = describeType(dataClass);
			if (dataClass == Array || dataClass == XML
				|| dataType.extendsClass.(@type == "Array"
				|| @type == "mx.collections::IList").length() > 0)
			{
				return List;
			}
			switch (dataClass)
			{
				case Boolean :
					return CheckBox;
				case int :
				case uint :
				case Number :
					return NumericStepper;
				default :
					return TextInput;
			}
		}
		private function initFieldValidator(field:UIComponent, metadata:XML, formItem:FormItem):void
		{
			var fieldValidator:Validator;
			const validatorName:String = MetadataUtil.getArgValue(metadata, "validator") as String;
			if (validatorName != null && validatorName.length > 0)
				fieldValidator = validator.getByName(validatorName);
			const property:String = metadata.parent().name() == "type" ? null
				: metadata.parent().@name;
			if (property != null && property.length > 0 && fieldValidator == null)
				fieldValidator = validator.getByProperty(property);
			if (fieldValidator != null)
			{
				const fieldType:XML = describeType(field);
				const dbps:XMLList = fieldType.metadata.(@name == "DefaultBindingProperty");
				if (dbps.length() > 0)
				{
					fieldValidator.property = MetadataUtil.getArgValue(dbps[0] as XML, "source") as String;
					if (fieldValidator.property == null || fieldValidator.property == "")
						fieldValidator.property = "data";
				}
				else
				{
					fieldValidator.property = "data";
				}
				fieldValidator.required ||= formItem.required;
				formItem.required = fieldValidator.required;
				fieldValidator.listener = field;
				fieldValidator.source = field;
				fieldValidator.trigger = field;
				fieldValidator.triggerEvent = FlexEvent.VALUE_COMMIT;
			}
		}
		private function initTypeValidators():void
		{
			for each (var typeValidator:Validator in validator.getForType())
			{
				if (typeValidator.source == null)
					typeValidator.source = form;
				if (typeValidator.property == null || typeValidator.property == "")
					typeValidator.property = "data";
				if (typeValidator.trigger == null)
					typeValidator.trigger = form;
				if (typeValidator.triggerEvent == null || typeValidator.triggerEvent == "")
					typeValidator.triggerEvent = FlexEvent.VALUE_COMMIT;
			}
		}
		private static function isValidFieldParent(parent:XML):Boolean
		{
			if (parent.name() == "variable" || parent.name() == "type")
				return true;
			if (parent.name() == "accessor")
				return parent.@access == "readwrite";
			return false;
		}
	}
}