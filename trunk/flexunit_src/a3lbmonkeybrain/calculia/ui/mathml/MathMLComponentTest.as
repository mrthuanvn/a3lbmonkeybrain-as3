package a3lbmonkeybrain.calculia.ui.mathml
{
	import a3lbmonkeybrain.brainstem.core.nullEventHandler;
	import a3lbmonkeybrain.brainstem.test.UITestUtil;
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathML;
	
	import flexunit.framework.TestCase;
	
	import mx.resources.ResourceBundle;

	/**
	 * @private 
	 * @author T. Michael Keesey
	 */
	public final class MathMLComponentTest extends TestCase
	{
		[ResourceBundle("math")]
		private static var mathBundle:ResourceBundle;
		public function testData():void
		{
			XML.ignoreWhitespace = true;
			const mathML:XML = <math xmlns={MathML.NAMESPACE}>
				<declare><ci>A</ci><set><apply><abs/><cn>1</cn></apply><cn>2</cn><cn>3</cn></set></declare>
				<apply><and/><apply><or/><ci>p</ci><ci>q</ci></apply><apply><implies/><ci>p</ci><ci>q</ci></apply><apply><xor/><ci>p</ci><ci>q</ci></apply></apply>
				<apply><eq/><apply><ceiling/><cn>4.5</cn></apply><apply><floor/><cn>5.5</cn></apply></apply>
				<apply><forall/><bvar><ci>x</ci></bvar><apply><exists/><bvar><ci>y</ci></bvar><apply><neq/><ci>x</ci><ci>y</ci></apply></apply></apply>
				<apply><eq/><apply><factorial/><cn>5</cn></apply><apply><times/><cn>2</cn><cn>3</cn><cn>4</cn><cn>5</cn></apply></apply>
				<apply><neq/><apply><divide/><cn>5</cn><cn>5</cn></apply><apply><plus/><apply><minus/><cn>2</cn><cn>3</cn></apply><cn>4</cn><cn>5</cn></apply></apply>
				<apply><leq/><cn>1</cn><cn>2</cn><cn>8000</cn></apply>
				<apply><geq/><cn>1</cn><cn>0</cn><cn>-1</cn></apply>
				<apply><neq/><cn>1</cn><cn>0</cn><cn>-1</cn><csymbol>SYMBOL</csymbol></apply>
				<apply><and/><apply><in/><ci>x</ci><ci>S</ci></apply><apply><notin/><ci>y</ci><ci>S</ci></apply></apply>
				<apply><apply><compose/><ci>f</ci><ci>g</ci></apply><ci>x</ci></apply>
				<list><pi/><exponentiale/><reals/><primes/></list>
				<set><infinity/><true/><false/><emptyset/><apply><tanh/><pi/></apply><apply><union/><ci>S</ci><ci>T</ci></apply><apply><setdiff/><ci>S</ci><ci>T</ci></apply><apply><intersect/><ci>S</ci><ci>T</ci></apply></set>
				<vector><cn>45.5545155</cn><cn>-67.19039120</cn><cn>100.66334505</cn></vector>
				<apply><or/><apply><subset/><ci>S</ci><ci>T</ci></apply><apply><prsubset/><ci>S</ci><ci>T</ci></apply><apply><notsubset/><ci>S</ci><ci>T</ci></apply><apply><notprsubset/><ci>S</ci><ci>T</ci></apply></apply>
				<declare>
					<ci>x</ci>
					<piecewise>
						<piece>
							<ci>y</ci>
							<condition>
								<apply>
									<lt/>
									<ci>y</ci>
									<cn>2</cn>
								</apply>
							</condition>
						</piece>
						<piece>
							<apply>
								<minus/>
								<ci>y</ci>
							</apply>
							<apply>
								<eq/>
								<ci>y</ci>
								<cn>2</cn>
							</apply>
						</piece>
						<otherwise>
							<cn>0</cn>
						</otherwise>
					</piecewise>
				</declare>
			</math>;
			const component:MathMLComponent = new MathMLComponent(mathML,
				new ResourceBundleOperatorStyleResolver(mathBundle));
			component.width = 700;
			component.height = 550;
			component.setStyle("fontSize", 14);
			UITestUtil.createTestWindow(component, "MathMLComponent",
				addAsync(nullEventHandler, int.MAX_VALUE));
		}
	}
}