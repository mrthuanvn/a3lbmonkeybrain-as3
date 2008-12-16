package a3lbmonkeybrain.hippocampus.commands
{
	import flash.events.Event;

	public final class RemoteCommandEvent extends Event
	{
		public static const COMMAND:String = "command";
		private var _command:RemoteCommand;
		public function RemoteCommandEvent(command:RemoteCommand)
		{
			super(COMMAND, true, true);
			_command = command;	
		}
		public function get command():RemoteCommand
		{
			return _command;
		}
		override public function clone():Event
		{
			return new RemoteCommandEvent(_command);
		}
		override public function toString():String
		{
			return formatToString("RemoteCommandEvent", "command", "eventPhase");
		}
	}
}