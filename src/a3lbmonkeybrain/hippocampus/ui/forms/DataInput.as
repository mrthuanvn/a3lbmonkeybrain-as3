package a3lbmonkeybrain.hippocampus.ui.forms
{
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.hippocampus.translate.DataTranslator;
	import a3lbmonkeybrain.hippocampus.translate.IdentityTranslator;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.TextInput;
	import mx.events.FlexEvent;

	public class DataInput extends TextInput
	{
		private var _data:Object;
		private var _translator:DataTranslator = IdentityTranslator.INSTANCE;
		protected var dataInvalidated:Boolean;
		protected var textInvalidated:Boolean;
		public function DataInput()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.RENDER, onRender);
			addEventListener(FlexEvent.ENTER, onEnter);
			addEventListener(FlexEvent.VALUE_COMMIT, onValueCommit);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		[Bindable(event = "dataChange")]
		override public function get data():Object
		{
			return _data;
		}
		override public function set data(value:Object):void
		{
			if (!Equality.equal(_data, value))
			{
				_data = value;
				invalidateText();
				if (hasEventListener(FlexEvent.DATA_CHANGE))
					dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
			}	
		}
		[Bindable(event = "translatorChange")]
		public function get translator():DataTranslator
		{
			return _translator;
		}
		public function set translator(value:DataTranslator):void
		{
			value = (value == null) ? IdentityTranslator.INSTANCE : value;
			if (_translator != value)
			{
				_translator = value;
				invalidateText();
				dispatchEvent(new Event("translatorChange"));
			}
		}
		override protected function focusOutHandler(event:FocusEvent):void
		{
			super.focusOutHandler(event);
			invalidateData();
		}
		protected function invalidateData():void
		{
			if (!dataInvalidated)
			{
				dataInvalidated = true;
				if (stage)
					stage.invalidate();
			}
		}
		protected function invalidateText():void
		{
			if (!textInvalidated)
			{
				textInvalidated = true;
				if (stage)
					stage.invalidate();
			}
		}
		protected function onAddedToStage(event:Event):void
		{
			updateData();
			updateText();
		}
		protected function onEnter(event:FlexEvent):void
		{
			invalidateData();
			invalidateText();
		}
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ESCAPE)
				invalidateText();
		}
		protected function onRender(event:Event):void
		{
			updateData();
			updateText();
		}
		protected function onValueCommit(event:FlexEvent):void
		{
			invalidateData();
			invalidateText();
		}
		protected function updateData():void
		{
			if (dataInvalidated)
			{
				dataInvalidated = false;
				try
				{
					data = translator.read(text);
				}
				catch (e:Error)
				{
					data = null;
					throw e;
				}
			}
		}
		protected function updateText():void
		{
			if (textInvalidated)
			{
				textInvalidated = false;
				try
				{
					text = translator.write(_data);
					validateNow();
				}
				catch (e:Error)
				{
					text = "<error>";
					throw e;
				}
			}
		}
	}
}