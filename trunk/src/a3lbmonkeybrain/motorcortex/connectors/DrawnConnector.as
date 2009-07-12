package a3lbmonkeybrain.motorcortex.connectors
{
	import a3lbmonkeybrain.motorcortex.draw.DrawingCommand;
	import a3lbmonkeybrain.motorcortex.refresh.Refreshable;
	import flash.display.Shape;
	import flash.events.Event;
	/**
	 * Shape that redraws itself according to a list of drawing commands.
	 * 
	 * @author T. Michael Keesey
	 * @see a3lbmonkeybrain.motorcortex.draw.DrawingCommand
	 */
	public class DrawnConnector extends Shape implements Refreshable
	{
		/**
		 * @private 
		 */
		private var _commands:Array;
		/**
		 * @private 
		 */
		private var commandsFlag:Boolean = false;
		/**
		 * Creates a new instance. Initializes the command list. 
		 * 
		 * @param	commands
		 * 		[optional] - Initial value for <code>commands</code>. If not set, initializes the command list
		 * 		to an empty array. Accessible as <code>DrawnConnector.commands</code>.
		 * @see	#commands
		 */
		public function DrawnConnector(commands:Array /* of DrawingCommand */ = null)
		{
			super();
			if (commands == null)
				_commands = [];
			else
				_commands = commands.concat();
		}
		[ArrayElementType("a3lbmonkeybrain.motorcortex.draw.DrawingCommand")]
		/**
		 * A list of zero or more drawing commands.
		 * <p>
		 * Can only be set wholesale. Modifying the property directly will have no effect.
		 * </p>
		 * <p>
		 * Setting this will cause a display refresh, if applicable.
		 * </p>
		 * 
		 * @see a3lbmonkeybrain.motorcortex.draw.DrawingCommand
		 */
		public function get commands():Array /* of DrawingCommand */
		{
			return _commands.concat();
		}
		/**
		 * @private
		 */
		public function set commands(value:Array /* of DrawingCommand */):void
		{
			_commands = [];
			var n:int = value.length;
			for (var i:int = 0; i < n; ++i)
			{
				if (value[i] is DrawingCommand)
				{
					DrawingCommand(value[i]).displayObject = this;
					_commands.push(value[i]);
				}
			}
			if (_commands.length > 0)
				addEventListener(Event.RENDER, refresh);
			else removeEventListener(Event.RENDER, refresh);
			graphics.clear();
			commandsFlag = true;
			if (stage)
				stage.invalidate();
		}
		/**
		 * Tells whether a refresh is required.
		 * 
		 * @see #refresh()
		 * @see a3lbmonkeybrain.motorcortex.draw.DrawingCommand#refreshRequired
		 */
		public function get refreshRequired():Boolean {
			for each (var command:DrawingCommand in _commands)
			{
				if (command.refreshRequired)
					return true;
			}
			return false;
		}
		/**
		 * @inheritDoc
		 */
		public function refresh(event:Event = null):void {
			if (commandsFlag || refreshRequired)
			{
				commandsFlag = false;
				var n:int = _commands.length;
				for (var i:int = 0; i < n; ++i)
				{
					var command:DrawingCommand = _commands[i] as DrawingCommand;
					command.draw(graphics);
					command.fulfillRefresh();
				}
			}
		} 
	}
}