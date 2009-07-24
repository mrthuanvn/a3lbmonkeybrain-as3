package a3lbmonkeybrain.calculia.collections.graphs.importers
{
	import a3lbmonkeybrain.calculia.collections.graphs.Digraph;
	import a3lbmonkeybrain.calculia.collections.graphs.exporters.TextCladogramExporter;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.TestCase;

	public class NewickImporterTest extends TestCase
	{
		private var exporter:TextCladogramExporter;
		private var graph:Digraph;
		private var importer:NewickImporter;
		public function NewickImporterTest(methodName:String=null)
		{
			super(methodName);
		}
		override public function setUp():void
		{
			super.setUp();
			importer = new NewickImporter();
			exporter = new TextCladogramExporter();
			exporter.vertexCompareFunction = compareVertices;
			exporter.vertexLabelFunction = function(v:Object):String
			{
				if (v is String)
					return v as String;
				return "";
			}
		}
		override public function tearDown():void
		{
			super.tearDown();
			importer = null;
			exporter = null;
			graph = null;
		}
		private function compareVertices(a:Object, b:Object):int
		{
			const aSucc:uint = graph.successors(a).size;
			const bSucc:uint = graph.successors(b).size;
			if (aSucc == bSucc)
			{
				if (a is String && b is String)
					return a == b ? 0 : (a < b ? -1 : 1);
				if (!(a is String || b is String))
					return 0;
				if (a is String)
					return 1;
				return -1;
			}
			return aSucc - bSucc;
		}
		public function testImportGraph():void
		{
			testString("(A:0.1,B:0.2,(C:0.3,D:0.4)E:0.5)ℜ");  
			testString("(Bovine:0.69395,(Gibbon:0.36079,(Orang:0.33636,(Gorilla:0.17147,(Chimp:0.19268, Human:0.11927):0.08386):0.06124):0.15057):0.54939,Mouse:1.21460):0.10");  
			testString("((((Plantae:10.9,Glaucophyta:7.8,Rhodophyta:8.8)Plastida:8.9,Gloeobacter:1.2)Cyanobacteria:5.6,(Rickettsia:1.3,(((Fungi:40.2,(Choanoflagellata:1.2,Metazoa:7.1):3.4)Opisthokonta:19.1,Amoebozoa:10.1)Unikonta:5.6,(Plastida:5.9,Rhizaria:4.5,Excavata:3.5)Bikonta:6.7)Mitochondriata:7.8)Rickettsiales:11.1)Eubacteria:30.6,(Archaea:9.9,(Mitochondriata:3.4)Eukaryota:12.8)Neomura:40.5)Biota");
			testString("(((Actinopterygii,(((Lissamphibia,((Testudines,(Squamata,Sphenodon)Lepidosauria,(Crocodylia,Aves)Archosauria)Sauropsida,Mammalia)Amniota)Tetrapoda,Dipnoi),Latimeria)Sarcopterygii)Osteichthyes,Chondrichthyes)Gnathostomata,Petromyzontidae,Myxinidae)Craniata");  
		}
		private function testString(s:String):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(s);
			graph = importer.importGraph(bytes) as Digraph;
			bytes = exporter.export(graph);
			trace("------------------");
			bytes.position = 0;
			trace(bytes.readUTFBytes(bytes.length));
			trace("------------------");
		}
	}
}