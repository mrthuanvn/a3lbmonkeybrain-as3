package a3lbmonkeybrain.calculia.collections.graphs.exporters
{
	import a3lbmonkeybrain.calculia.collections.graphs.HashNetwork;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.TestCase;

	public class TextCladogramExporterTest extends TestCase
	{
		public function TextCladogramExporterTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testExport():void
		{
			var exporter:TextCladogramExporter = new TextCladogramExporter();
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
			exporter.vertexCompareFunction = function (a:Object, b:Object):int
			{
				const aSucc:uint = g.successors(a).size;
				const bSucc:uint = g.successors(b).size;
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
			const bytes:ByteArray = exporter.export(g);
			assertNotNull(bytes);
			bytes.position = 0;
			trace(bytes.readMultiByte(bytes.length, "utf-8"));
		}
		public function testExport2():void
		{
			var exporter:TextCladogramExporter = new TextCladogramExporter();
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
			exporter.vertexCompareFunction = function (a:Object, b:Object):int
			{
				const aSucc:uint = g.successors(a).size;
				const bSucc:uint = g.successors(b).size;
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
			const bytes:ByteArray = exporter.export(g);
			assertNotNull(bytes);
			bytes.position = 0;
			trace(bytes.readMultiByte(bytes.length, "utf-8"));
		}
	}
}
class UnnamedTaxon
{
	public function toString():String
	{
		return "";
}
}