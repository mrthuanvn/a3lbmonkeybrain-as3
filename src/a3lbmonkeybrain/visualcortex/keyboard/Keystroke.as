package a3lbmonkeybrain.visualcortex.keyboard
{
	import flash.events.KeyboardEvent;
	import flash.ui.KeyLocation;
	import flash.utils.Dictionary;
	
	public final class Keystroke
	{
		public static const KEY_CODE_DICTIONARY:Dictionary = createKeyCodeDictionary();
		public var altKey:*;
		public var charCode:*;
		public var ctrlKey:*;
		public var keyCode:*;
		public var keyLocation:*;
		public var shiftKey:*;
		public function Keystroke(lock:Class)
		{
			super();
			if (lock != Lock)
				throw new TypeError();
		}
		public static function createAlte(keyCode:uint):Keystroke
		{
			var stroke:Keystroke = new Keystroke(Lock);
			stroke.keyCode = keyCode;
			stroke.altKey = true;
			stroke.ctrlKey = false;
			stroke.shiftKey = false;
			return stroke;
		}
		public static function createCtrlStroke(keyCode:uint):Keystroke
		{
			var stroke:Keystroke = new Keystroke(Lock);
			stroke.keyCode = keyCode;
			stroke.altKey = false;
			stroke.ctrlKey = true;
			stroke.shiftKey = false;
			return stroke;
		}
		private static function createKeyCodeDictionary():Dictionary
		{
			var d:Dictionary = new Dictionary();
			for (var i:uint = 65; i <= 90; ++i)
			{
				d[i] = String.fromCharCode(i);
			}
			for (i = 1; i <= 12; ++i)
			{
				d[111 + i] = "F" + i;
			}
			for (i = 0; i < 10; ++i)
			{
				d[48 + i] = String(i);
			}
			for (i = 0; i < 10; ++i)
			{
				d[97 + i] = "Numpad " + i;
			}
			d[8] = "Bksp";
			d[9] = "Tab";
			d[13] = "Enter";
			d[15] = "Cmd";
			d[16] = "Shift";
			d[17] = "Ctrl";
			d[18] = "Alt";
			d[20] = "Caps";
			d[21] = "Numpad";
			d[27] = "Esc";
			d[32] = "Space";
			d[33] = "PageUp";
			d[34] = "PageDn";
			d[35] = "End";
			d[36] = "Home";
			d[37] = "Left";
			d[38] = "Up";
			d[39] = "Right";
			d[40] = "Down";
			d[45] = "Ins";
			d[46] = "Del";
			d[106] = "Numpad *";
			d[107] = "Numpad +";
			d[108] = "Numpad Enter";
			d[109] = "Numpad -";
			d[110] = "Numpad .";
			d[111] = "Numpad /";
			d[186] = ";";
			d[187] = "=";
			d[188] = ",";
			d[189] = "-";
			d[190] = ".";
			d[191] = "/";
			d[192] = "`";
			d[219] = "[";
			d[220] = "\\";
			d[221] = "]";
			d[222] = "'";
			return d;
		}
		public static function createShiftStroke(keyCode:uint):Keystroke
		{
			var stroke:Keystroke = new Keystroke(Lock);
			stroke.keyCode = keyCode;
			stroke.altKey = false;
			stroke.ctrlKey = false;
			stroke.shiftKey = true;
			return stroke;
		}
		public function matchesEvent(event:KeyboardEvent):Boolean
		{
			if (altKey !== undefined)
			{
				if (event.altKey != altKey)
					return false;
			}
			if (charCode !== undefined)
			{
				if (event.charCode != charCode)
					return false;
			}
			if (ctrlKey !== undefined)
			{
				if (event.ctrlKey != ctrlKey)
					return false;
			}
			if (keyCode !== undefined)
			{
				if (event.keyCode != keyCode)
					return false;
			}
			if (keyLocation !== undefined)
			{
				if (event.keyLocation != keyLocation)
					return false;
			}
			if (shiftKey !== undefined)
			{
				if (event.shiftKey != shiftKey)
					return false;
			}
			return true;
		}
		public function toString():String
		{
			var keys:Array = [];
			if (ctrlKey === true)
				keys.push("Ctrl");
			if (altKey === true)
				keys.push("Alt");
			if (shiftKey === true)
				keys.push("Shift");
			if (keyCode != undefined)
			{
				var keyStr:String = KEY_CODE_DICTIONARY[keyCode];
				if (keyLocation != undefined)
				{
					switch (keyLocation)
					{
						case KeyLocation.LEFT :
							keyStr += " [Left]";
							break;
						case KeyLocation.NUM_PAD :
							keyStr += " [NumPad]";
							break;
						case KeyLocation.RIGHT :
							keyStr += " [Right]";
							break;
						case KeyLocation.STANDARD :
							break;
					}
				}
				keys.push(keyStr);
			}
			else if (charCode != undefined)
			{
				keys.push(String.fromCharCode(charCode));
			}
			return keys.join(" + ");
		}
	}
}
class Lock
{
}