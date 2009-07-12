package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.calculia.collections.graphs.HashNetwork;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.TestCase;

	public class DotExporterTest extends TestCase
	{
		private var exporter : DotExporter;
		public function DotExporterTest(methodName:String=null)
		{
			super(methodName);
		}
		private static function getVertexID(o:Object):String
		{
			if (o is UnnamedTaxon)
				return UnnamedTaxon(o).index.toString(0x10);
			return String(o);
		}
		public function testExport():void
		{
			exporter = new DotExporter();
			exporter.vertexIDFunction = getVertexID;
			const g:HashNetwork = new HashNetwork();
			g.createEdge("Craniata", "Myxinidae");
			g.createEdge("Craniata", "Petromyzontidae");
			g.createEdge("Craniata", "Gnathostomata");
			g.createEdge("Gnathostomata", "Chondrichthyes");
			g.createEdge("Gnathostomata", "Osteichthyes");
			g.createEdge("Osteichthyes", "Actinopterygii");
			g.createEdge("Osteichthyes", "Sarcopterygii");
			const innomA:UnnamedTaxon = new UnnamedTaxon();
			g.createEdge("Sarcopterygii", "Latimeria");
			g.createEdge("Sarcopterygii", innomA);
			g.createEdge(innomA, "Dipnoi");
			g.createEdge(innomA, "Tetrapoda");
			g.createEdge("Tetrapoda", "Lissamphibia");
			g.createEdge("Tetrapoda", "Amniota");
			g.createEdge("Amniota", "Mammalia");
			g.createEdge("Amniota", "Sauropsida");
			g.createEdge("Sauropsida", "Testudines");
			g.createEdge("Sauropsida", "Lepidosauria");
			g.createEdge("Lepidosauria", "Sphenodon");
			g.createEdge("Lepidosauria", "Squamata");
			g.createEdge("Sauropsida", "Archosauria");
			g.createEdge("Archosauria", "Crocodylia");
			g.createEdge("Archosauria", "Aves");
			const bytes:ByteArray = exporter.export(g);
			assertNotNull(bytes);
			bytes.position = 0;
			trace(bytes.readMultiByte(bytes.length, "utf-8"));
		}
		public function testExport2():void
		{
			exporter = new DotExporter();
			exporter.vertexIDFunction = getVertexID;
			const g:HashNetwork = new HashNetwork();
			const innomA:UnnamedTaxon = new UnnamedTaxon();
			const innomB:UnnamedTaxon = new UnnamedTaxon();
			g.createEdge("Biota", "Neomura");
			g.createEdge("Biota", "Eubacteria");
			g.createEdge("Eubacteria", "Rickettsiales");
			g.createEdge("Eubacteria", "Cyanobacteria");
			g.createEdge("Cyanobacteria", "Gloeobacter");
			g.createEdge("Cyanobacteria", "Plastida");
			g.createEdge("Rickettsiales", "Rickettsia");
			g.createEdge("Rickettsiales", "Mitochondriata");
			g.createEdge("Neomura", "Archaea");
			g.createEdge("Eukaryota", "Mitochondriata");
			g.createEdge("Neomura", "Eukaryota");
			g.createEdge("Mitochondriata", "Bikonta");
			g.createEdge("Bikonta", "Plastida");
			g.createEdge("Bikonta", "Rhizaria");
			g.createEdge("Bikonta", "Excavata");
			g.createEdge("Plastida", "Rhodophyta");
			g.createEdge("Plastida", "Glaucophyta");
			g.createEdge("Plastida", "Plantae");
			g.createEdge("Mitochondriata", "Unikonta");
			g.createEdge("Unikonta", "Amoebozoa");
			g.createEdge("Unikonta", "Opisthokonta");
			g.createEdge("Opisthokonta", "Fungi");
			g.createEdge("Opisthokonta", innomB);
			g.createEdge(innomB, "Choanoflagellata");
			g.createEdge(innomB, "Metazoa");
			const bytes:ByteArray = exporter.export(g);
			assertNotNull(bytes);
			bytes.position = 0;
			trace(bytes.readMultiByte(bytes.length, "utf-8"));
		}
	}
}
class UnnamedTaxon
{
	private static var nextIndex:uint = 1;
	public var index:uint;
	public function UnnamedTaxon()
	{
		super();
		index = nextIndex++;
	}
	public function toString():String
	{
		return "";
	}
}