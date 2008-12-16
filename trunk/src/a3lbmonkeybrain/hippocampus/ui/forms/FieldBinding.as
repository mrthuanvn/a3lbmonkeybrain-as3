package a3lbmonkeybrain.hippocampus.ui.forms
{
	import a3lbmonkeybrain.brainstem.assert.assert;
	import a3lbmonkeybrain.brainstem.assert.assertNotNull;
	import a3lbmonkeybrain.brainstem.metadata.MetadataUtil;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	
	import mx.core.IPropertyChangeNotifier;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	
	internal final class FieldBinding
	{
		private var data:IPropertyChangeNotifier;
		private var dataProperty:String;
		private var disableValueCommits:Boolean = false;
		private var field:IEventDispatcher;
		private var fieldDestinationProperty:String = "data";
		private var fieldSourceProperty:String = "data";
		public function FieldBinding(data:IPropertyChangeNotifier, property:String,
			field:IEventDispatcher)
		{
			super();
			assertNotNull(data);
			assertNotNull(field);
			assert(Object(data).hasOwnProperty(property));
			this.data = data;
			dataProperty = property;
			this.field = field;
			const fieldType:XML = describeType(field);
			const dbps:XMLList = fieldType.metadata.(@name == "DefaultBindingProperty");
			if (dbps.length() > 0)
			{
				fieldDestinationProperty = MetadataUtil.getArgValue(dbps[0] as XML, "destination")
					as String;
				fieldSourceProperty = MetadataUtil.getArgValue(dbps[0] as XML, "source") as String;
				if (fieldDestinationProperty == null || fieldDestinationProperty == "")
					fieldDestinationProperty = "data";
				if (fieldSourceProperty == null || fieldSourceProperty == "")
					fieldSourceProperty = "data";
			}
			assert(Object(field).hasOwnProperty(fieldSourceProperty));
			assert(Object(field).hasOwnProperty(fieldDestinationProperty));
			fieldValue = dataValue;
			data.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChange);
			field.addEventListener(FlexEvent.VALUE_COMMIT, onValueCommit);
		}
		private function get dataValue():Object
		{
			return data[dataProperty];
		}
		private function set dataValue(value:Object):void
		{
			data[dataProperty] = value;
		}
		private function get fieldValue():Object
		{
			return field[fieldSourceProperty];
		}
		private function set fieldValue(value:Object):void
		{
			field[fieldDestinationProperty] = value;
		}
		private function onPropertyChange(event:PropertyChangeEvent):void
		{
			if (event.property == dataProperty)
				updateFromData();
		}
		private function onValueCommit(event:FlexEvent):void
		{
			if (!disableValueCommits && !Equality.equal(dataValue, fieldValue))
			{
				dataValue = fieldValue;
				updateFromData();
			}
		}
		private function updateFromData():void
		{
			if (!Equality.equal(fieldValue, dataValue))
			{
				disableValueCommits = true;
				fieldValue = dataValue;
				disableValueCommits = false;
			}
		}
	}
}