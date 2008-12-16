package a3lbmonkeybrain.brainstem.assert
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import flexunit.framework.TestCase;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class AssertTest extends TestCase
	{
		public function testAssert():void
		{
			assert(true);
			var error:Error;
			var message:String = "test";
			try
			{
				assert(false, message);
			}
			catch (e:AssertionError)
			{
				error = e;
			}
			assert(error is AssertionError);
			assertEqual(error.message, message);
		}
		public function testAssertEqual():void
		{
			a3lbmonkeybrain.brainstem.assert.assertEqual(1, 1);
			var a:Object = {x: 1, y: 2};
			a3lbmonkeybrain.brainstem.assert.assertEqual(a, a);
			var error:Error;
			try
			{
				a3lbmonkeybrain.brainstem.assert.assertEqual(1, 2);
			}
			catch (e:AssertionError)
			{
				error = e;
			}
			assertTrue(error is AssertionError);
		}
		public function testAssertNotEmpty():void
		{
			assertNotEmpty("not empty");
			var error:Error;
			try
			{
				assertNotEmpty("");
			}
			catch (e:AssertionError)
			{
				error = e;
			}
			assertTrue(error is AssertionError);
			error = null;
			try
			{
				assertNotEmpty(null);
			}
			catch (e:TypeError)
			{
				error = e;
			}
			assertTrue(error is TypeError);
		}
		public function testAssertNotNull():void
		{
			a3lbmonkeybrain.brainstem.assert.assertNotNull("");
			a3lbmonkeybrain.brainstem.assert.assertNotNull([]);
			a3lbmonkeybrain.brainstem.assert.assertNotNull({});
			var error:Error;
			try
			{
				a3lbmonkeybrain.brainstem.assert.assertNotNull(null);
			}
			catch (e:TypeError)
			{
				error = e;
			}
			assertTrue(error is TypeError);
		}
		public function testAssertType():void
		{
			assertType(new Sprite(), DisplayObjectContainer);
			assertType(new Sprite(), Sprite);
			assertType(new Sprite(), Object);
			assertType(new Sprite(), IEventDispatcher);
			var error:Error;
			try
			{
				assertType(new Sprite(), Event);
			}
			catch (e:TypeError)
			{
				error = e;
			}
			assertTrue(error is TypeError);
		}
		public function testAssertValidXML():void
		{
			assertValidXML("<hello/>");
			assertValidXML("<hello></hello>");
			assertValidXML("<hello>world</hello>");
			assertValidXML("hello");
			var error:Error;
			try
			{
				assertValidXML(null);
			}
			catch (e:TypeError)
			{
				error = e;
			}
			assertTrue(error is TypeError);
			error = null;
			try
			{
				assertValidXML("");
			}
			catch (e:AssertionError)
			{
				error = e;
			}
			assertTrue(error is AssertionError);
			error = null;
			try
			{
				assertValidXML("<open");
			}
			catch (e:TypeError)
			{
				error = e;
			}
			assertTrue(error is TypeError);
			error = null;
			try
			{
				assertValidXML("</>");
			}
			catch (e:TypeError)
			{
				error = e;
			}
			assertTrue(error is TypeError);
		}
	}
}