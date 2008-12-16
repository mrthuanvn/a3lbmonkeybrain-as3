package a3lbmonkeybrain.brainstem.filter
{
	import a3lbmonkeybrain.brainstem.assert.assert;
	import a3lbmonkeybrain.brainstem.assert.assertEqual;
	import a3lbmonkeybrain.brainstem.assert.assertType;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayCollection;

	public final class FilterTest extends TestCase
	{
		public function testFilterType():void
		{
			const objects:ArrayCollection = new ArrayCollection([new TextField(),
				new Event(Event.ADDED), new Sprite(), new Shape(), "test string",
				new MovieClip()]);
			objects.filterFunction = filterType(DisplayObject);
			objects.refresh();
			assertEqual(4, objects.length);
			for each (var o:* in objects)
			{
				assertType(o, DisplayObject);
			}
		}
		public function testIsNonEmptyString():void
		{
			const objects:ArrayCollection = new ArrayCollection([new Shape(),
				"test string", "", null, 300]);
			objects.filterFunction = isNonEmptyString;
			objects.refresh();
			assertEqual(1, objects.length);
			for each (var o:* in objects)
			{
				assert(isNonEmptyString(o), "Failed assertion for: " + o);
			}
		}
	}
}