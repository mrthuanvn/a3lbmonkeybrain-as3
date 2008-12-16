package a3lbmonkeybrain.brainstem.filter
{
	public class TypeFilter
	{
		private var _filteredClass:Class;
		public function TypeFilter(filteredClass:Class)
		{
			super();
			_filteredClass = filteredClass;
		}
		protected final function get filteredClass():Class
		{
			return _filteredClass;
		}
		public function filter(item:Object):Boolean
		{
			return item is _filteredClass;
		}
	}
}