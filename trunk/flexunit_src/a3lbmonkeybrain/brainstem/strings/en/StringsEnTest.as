package a3lbmonkeybrain.brainstem.strings.en
{
	import a3lbmonkeybrain.brainstem.assert.assertEqual;
	
	import flexunit.framework.TestCase;
	
	public final class StringsEnTest extends TestCase
	{
		public function testFindIndefiniteArticle():void
		{
			assertEqual("a", findIndefiniteArticle("cat"));
			assertEqual("an", findIndefiniteArticle("Ear"));
			assertEqual("a", findIndefiniteArticle("University"));
			assertEqual("a", findIndefiniteArticle("N32903921"));
			assertEqual("an", findIndefiniteArticle("ora"));
			assertEqual("an", findIndefiniteArticle("hour"));
		}
		public function testPluralize():void
		{
			assertEqual("cats", pluralize("cat"));
			assertEqual("puppies", pluralize("puppy"));
			assertEqual("Universities", pluralize("University"));
			assertEqual("Fridays", pluralize("Friday"));
			assertEqual("foxes", pluralize("fox"));
			assertEqual("pluses", pluralize("plus"));
			assertEqual("uses", pluralize("use"));
			assertEqual("fishes", pluralize("fish"));
			assertEqual("watches", pluralize("watch"));
			assertEqual("stops", pluralize("stop"));
			assertEqual("pottoes", pluralize("potto"));
		}
	}
}