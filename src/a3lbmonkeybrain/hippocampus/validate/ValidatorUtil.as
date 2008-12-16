package a3lbmonkeybrain.hippocampus.validate
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public final class ValidatorUtil
	{
		public static function hasError(results:Array):Boolean
		{
			if (results == null || results.length == 0)
				return false;
			for each (var result:ValidationResult in results)
			{
				if (result.isError)
				{
					trace("[VALIDATION ERROR]", result.errorCode, result.errorMessage);
					return true;
				}
			}
			return false;
		}
		public static function test(validator:Validator, value:Object):Boolean
		{
			return !hasError(validator.validate(value, false).results);
		}
	}
}