package a3lbmonkeybrain.calculia.core
{
	import flash.utils.Dictionary;
	
	public final class CalcTable
	{
		private static const argTokens:Dictionary = new Dictionary(false);
		private const results:Dictionary = new Dictionary(false);
		public function CalcTable()
		{
			super();
		}
		public static function argumentsToToken(arguments:Array):Object
		{
			return findArgumentsToken(argTokens, arguments);
		}
		private static function findArgumentsToken(tokens:Dictionary, arguments:Array):Object
		{
			if (arguments.length == 0)
				return tokens;
			const head:* = arguments[0];
			var token:* = tokens[head];
			if (!(token is Dictionary))
				token = tokens[head] = new Dictionary(false);
			return findArgumentsToken(token as Dictionary, arguments.slice(1, arguments.length));
		}
		public function getResult(operation:Object, arguments:Array):*
		{
			const opTable:* = results[operation];
			if (opTable is Dictionary)
				return opTable[argumentsToToken(arguments)];
			return undefined;
		}
		public function setResult(operation:Object, arguments:Array, result:*):void
		{
			var opTable:* = results[operation];
			if (!(opTable is Dictionary))
				opTable = results[operation] = new Dictionary(false);
			opTable[argumentsToToken(arguments)] = result;
		}
		public function reset():void
		{
			for (var key:* in results)
				delete results[key];
		}
	}
}