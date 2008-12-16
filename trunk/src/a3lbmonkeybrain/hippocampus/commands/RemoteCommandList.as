package a3lbmonkeybrain.hippocampus.commands
{
	import a3lbmonkeybrain.brainstem.filter.filterType;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	[RemoteClass(alias = "a3lbmonkeybrain.hippocampus.commands.RemoteCommandList")]
	public final class RemoteCommandList implements RemoteCommand
	{
		private const _commands:ArrayCollection = new ArrayCollection();
		public function RemoteCommandList()
		{
			super();
			_commands.filterFunction = filterType(RemoteCommand);
		}
		public function get commands():ArrayCollection
		{
			return _commands;
		}
		public function set commands(value:ArrayCollection):void
		{
			_commands.source = value ? value.source : [];
			_commands.refresh();
		}
	}
}