package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	
	import flexunit.framework.TestCase;
	
	import mx.core.Application;

	/**
	 * @private
	 */
	public final class NetStreamClientTest extends TestCase
	{
		public static const ASSET_REQUEST:URLRequest = new URLRequest("assets/barsandtone.flv");
		private var video:Video;
		private var onStop:Function;
		override public function setUp():void
		{
			video = new Video();
			video.opaqueBackground = true;
			video.width = 360;
			video.height = 288;
			video.x = (Application.application.stage.width - 360) / 2;
			video.y = (Application.application.stage.height - 288) / 2;
			Application(Application.application).rawChildren.addChild(video);
		}
		override public function tearDown():void
		{
			if (video != null && video.parent != null)
				video.parent.removeChild(video);
			video = null;
		}
		public function testCreateForNetStream():void
		{
			var connection:NetConnection = new NetConnection();
			connection.connect(null);
			var stream:NetStream = new NetStream(connection);
			stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, trace);
			stream.addEventListener(IOErrorEvent.IO_ERROR, trace);
			stream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			video.attachNetStream(stream);
			var client:NetStreamClient = new NetStreamClient(stream);
			assertEquals(stream.client, client);
			assertEquals(client.netStream, stream);
			client.addEventListener(CuePointEvent.CUE_POINT, trace);
			client.addEventListener(ImageDataEvent.IMAGE_DATA, trace);
			client.addEventListener(MetaDataEvent.META_DATA, addAsync(onMetaData, 2000));
			client.addEventListener(PlayStatusEvent.PLAY_STATUS, trace);
			client.addEventListener(TextDataEvent.TEXT_DATA, trace);
			stream.play(ASSET_REQUEST.url);
			onStop = addAsync(function f(e:Event):void {}, 6500);
		}
		private function onMetaData(event:MetaDataEvent):void
		{
			trace(event);
			var client:NetStreamClient = event.target as NetStreamClient;
			assertTrue(client.metaData.equals(event.metaData));
			assertEquals(client.metaData.audioCodecID, 2);
			assertEquals(client.metaData.audioDataRate, 96);
			assertEquals(client.metaData.audioDelay, 0.038);
			assertTrue(client.metaData.canSeekToEnd);
			assertEquals(client.metaData.duration, 6);
			assertEquals(client.metaData.framerate, 10);
			assertEquals(client.metaData.height, 288);
			assertEquals(client.metaData.videoCodecID, 4);
			assertEquals(client.metaData.videoDataRate, 400);
			assertEquals(client.metaData.width, 360);
		}
		private function onNetStatus(event:NetStatusEvent):void
		{
			trace(event);
			for (var p:String in event.info)
			{
				trace("\t" + p + ": " + event.info[p]);
			}
			if (event.info.level == "status" && event.info.code == "NetStream.Play.Stop")
				onStop(event);
		}
		private function onPlayStatus(event:PlayStatusEvent):void
		{
			var client:NetStreamClient = event.target as NetStreamClient;
			if (event.playStatus.code == PlayStatusCode.COMPLETE)
				assertEquals(event.playStatus.duration, client.metaData.duration);
			else
				client.addEventListener(PlayStatusEvent.PLAY_STATUS, addAsync(onPlayStatus, 7000));
		}
	}
}