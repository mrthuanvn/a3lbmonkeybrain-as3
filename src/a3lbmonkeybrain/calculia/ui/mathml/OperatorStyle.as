package a3lbmonkeybrain.calculia.ui.mathml
{
	import flash.text.FontStyle;
	
	public final class OperatorStyle
	{
		private var _color:Number = NaN;
		private var _dir:String = null;
		private var _fontFamily:String = null;
		private var _fontStyle:String = null;
		private var _form:String = null;
		private var _lValue:String = null;
		private var _rValue:String = null;
		private var _separator:String = null;
		private var _value:String = null;
		private var baseStyle:OperatorStyle;
		public var reln:Boolean;
		public function OperatorStyle(baseStyle:OperatorStyle = null)
		{
			super();
			this.baseStyle = baseStyle;
		}
		public function get color():uint
		{
			if (isNaN(_color))
			{
				if (baseStyle != null)
					return baseStyle.color;
				return 0x000000;
			}
			return Math.max(0x000000, Math.min(0xFFFFFF, Math.floor(_color)));
		}
		public function set colorString(value:String):void
		{
			if (value == null || value == "")
				_color = NaN;
			else
				_color = parseInt(value.replace(/[^A-Fa-f0-9]/g, ""), 16);
		}
		public function get dir():String
		{
			if (_dir == null && baseStyle != null)
				return baseStyle.dir;
			return _dir;
		}
		public function set dir(value:String):void
		{
			_dir = OperatorStyleDir.isValidDir(value) ? value : null;
		}
		public function get fontFamily():String
		{
			if (_fontFamily == null && baseStyle != null)
				return baseStyle.fontFamily;
			return _fontFamily;
		}
		public function set fontFamily(value:String):void
		{
			_fontFamily = (value == "") ? null : value;
		}
		public function get fontStyle():String
		{
			if (_fontStyle == null && baseStyle != null)
				return baseStyle.fontStyle;
			return _fontStyle;
		}
		public function set fontStyle(value:String):void
		{
			if (value == null || value == "")
				_fontStyle = null;
			else
			{
				switch (value)
				{
					case FontStyle.BOLD :
					case FontStyle.BOLD_ITALIC :
					case FontStyle.ITALIC :
					case FontStyle.REGULAR :
					{
						_fontStyle = value;
						break;
					}
					default :
					{
						trace("[WARNING]", "Unrecognized font style: " + value);
						_fontStyle = null;
					}
				}
			}
		}
		public function get form():String
		{
			if (_form == null && baseStyle != null)
				return baseStyle.form;
			return _form;
		}
		public function set form(value:String):void
		{
			_form = OperatorStyleForm.isValidForm(value) ? value : null;
		}
		public function get lValue():String
		{
			if (_lValue == null)
			{
				if (baseStyle != null && baseStyle.lValue != null)
					return baseStyle.lValue;
				if (form == OperatorStyleForm.FENCE && _rValue == null)
					return value;
			}
			return _lValue;
		}
		public function set lValue(value:String):void
		{
			_lValue = value ? value : null;
		}
		public function get rValue():String
		{
			if (_rValue == null)
			{
				if (baseStyle != null && baseStyle.rValue != null)
					return baseStyle.rValue;
				if (form == OperatorStyleForm.FENCE && _lValue == null)
					return value;
			}
			return _rValue;
		}
		public function set rValue(value:String):void
		{
			_rValue = value ? value : null;
		}
		public function get separator():String
		{
			if (_separator == null && baseStyle != null)
				return baseStyle.separator;
			return _separator;
		}
		public function set separator(value:String):void
		{
			_separator = value;
		}
		public function get value():String
		{
			if (_value == null && baseStyle != null)
				return baseStyle.value;
			return _value;
		}
		public function set value(value:String):void
		{
			_value = value;
		}
		public function hasColor():Boolean
		{
			return !isNaN(_color);
		}
	}
}