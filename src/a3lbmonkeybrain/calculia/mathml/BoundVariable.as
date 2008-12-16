package a3lbmonkeybrain.calculia.mathml
{
	public final class BoundVariable
	{
		private var _id:String;
		public function BoundVariable(id:String)
		{
			super();
			_id = id;
		}
		public function get id():String
		{
			return _id;
		}
	}
}