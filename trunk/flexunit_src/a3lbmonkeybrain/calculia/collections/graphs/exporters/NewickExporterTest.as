package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.calculia.collections.graphs.HashNetwork;
	import a3lbmonkeybrain.calculia.collections.graphs.exporters.NewickExporter;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.TestCase;

	public class NewickExporterTest extends TestCase
	{
		private var exporter : NewickExporter;
		public function NewickExporterTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testExport():void
		{
			exporter = new NewickExporter();
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
			exporter = new NewickExporter();
			const g:HashNetwork = new HashNetwork();
			const innomA:UnnamedTaxon = new UnnamedTaxon();
			const innomB:UnnamedTaxon = new UnnamedTaxon();
			g.createWeightedEdge("Biota", "Neomura", 40.5);
			g.createWeightedEdge("Biota", "Eubacteria", 30.6);
			g.createWeightedEdge("Eubacteria", "Rickettsiales", 11.1);
			g.createWeightedEdge("Eubacteria", "Cyanobacteria", 5.6);
			g.createWeightedEdge("Cyanobacteria", "Gloeobacter", 1.2);
			g.createWeightedEdge("Cyanobacteria", "Plastida", 8.9);
			g.createWeightedEdge("Rickettsiales", "Rickettsia", 1.3);
			g.createWeightedEdge("Rickettsiales", "Mitochondriata", 7.8);
			g.createWeightedEdge("Neomura", "Archaea", 9.9);
			g.createWeightedEdge("Eukaryota", "Mitochondriata", 3.4);
			g.createWeightedEdge("Neomura", "Eukaryota", 12.8);
			g.createWeightedEdge("Mitochondriata", "Bikonta", 6.7);
			g.createWeightedEdge("Bikonta", "Plastida", 5.9);
			g.createWeightedEdge("Bikonta", "Rhizaria", 4.5);
			g.createWeightedEdge("Bikonta", "Excavata", 3.5);
			g.createWeightedEdge("Plastida", "Rhodophyta", 8.8);
			g.createWeightedEdge("Plastida", "Glaucophyta", 7.8);
			g.createWeightedEdge("Plastida", "Plantae", 10.9);
			g.createWeightedEdge("Mitochondriata", "Unikonta", 5.6);
			g.createWeightedEdge("Unikonta", "Amoebozoa", 10.1);
			g.createWeightedEdge("Unikonta", "Opisthokonta", 19.1);
			g.createWeightedEdge("Opisthokonta", "Fungi", 40.2);
			g.createWeightedEdge("Opisthokonta", innomB, 3.4);
			g.createWeightedEdge(innomB, "Choanoflagellata", 1.2);
			g.createWeightedEdge(innomB, "Metazoa", 7.1);
			const bytes:ByteArray = exporter.export(g);
			assertNotNull(bytes);
			bytes.position = 0;
			trace(bytes.readMultiByte(bytes.length, "utf-8"));
		}
	}
}
class UnnamedTaxon
{
	private static var index:uint = 1;
	private var i:uint;
	public function UnnamedTaxon()
	{
		super();
		i = index++;
	}
	public function toString():String
	{
		return "";
	}
}