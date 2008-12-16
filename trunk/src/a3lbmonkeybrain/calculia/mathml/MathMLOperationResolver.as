package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.brainstem.w3c.mathml.MathML;
	import a3lbmonkeybrain.calculia.collections.operations.*;
	
	public final class MathMLOperationResolver extends AbstractOperationResolver
	{
		public function MathMLOperationResolver()
		{
			super();
		}
		override protected function initOperationMap():void
		{
			operationMap[MathML.ABS.toString()] = new AbsOperation();
			operationMap[MathML.AND.toString()] = new AndOperation();
			operationMap[MathML.ARCCOS.toString()] = new ArcCosOperation();
			// :TODO: arccosh
			operationMap[MathML.ARCCOT.toString()] = new ArcCotOperation();
			// :TODO: arccoth
			operationMap[MathML.ARCCSC.toString()] = new ArcCscOperation();
			// :TODO: arccsch
			operationMap[MathML.ARCSEC.toString()] = new ArcSecOperation();
			// :TODO: arcsech
			operationMap[MathML.ARCSIN.toString()] = new ArcSinOperation();
			// :TODO: arcsinh
			operationMap[MathML.ARCTAN.toString()] = new ArcTanOperation();
			// :TODO: arctanh
			// :TODO: arg
			operationMap[MathML.CARD.toString()] = new CardOperation();
			operationMap[MathML.CARTESIANPRODUCT.toString()] = new CartesianProductOperation();
			operationMap[MathML.CEILING.toString()] = new CeilingOperation();
			// :TODO: codomain
			operationMap[MathML.COMPOSE.toString()] = new ComposeOperation();
			// :TODO: conjugate
			operationMap[MathML.COS.toString()] = new CosOperation();
			// :TODO: cosh
			// :TODO: cot
			// :TODO: coth
			// :TODO: csc
			// :TODO: csch
			// :TODO: curl
			// :TODO: determinant
			// :TODO: diff
			// :TODO: divergence
			operationMap[MathML.DIVIDE.toString()] = new DivideOperation();
			// :TODO: domain
			operationMap[MathML.EQ.toString()] = new EqOperation();
			// :TODO: equivalent
			// :TODO: exp
			operationMap[MathML.FACTORIAL.toString()] = new FactorialOperation();
			operationMap[MathML.FACTOROF.toString()] = new FactorOfOperation();
			operationMap[MathML.FLOOR.toString()] = new FloorOperation();
			// :TODO: fn
			operationMap[MathML.GEQ.toString()] = new GEqOperation();
			operationMap[MathML.GT.toString()] = new GTOperation();
			operationMap[MathML.IMPLIES.toString()] = new ImpliesOperation();
			operationMap[MathML.IN.toString()] = new InOperation();
			// :TODO: int
			operationMap[MathML.INTERSECT.toString()] = new IntersectOperation();
			// :TODO: inverse
			// :TODO: laplacian
			// :TODO: lcm
			operationMap[MathML.LEQ.toString()] = new LEqOperation();
			// :TODO: limit
			// :TODO: ln
			// :TODO: log
			operationMap[MathML.LT.toString()] = new LTOperation();
			// :TODO: max
			// :TODO: mean
			// :TODO: median
			// :TODO: min
			operationMap[MathML.MINUS.toString()] = new MinusOperation();
			// :TODO: mode
			// :TODO: moment
			operationMap[MathML.NEQ.toString()] = new NEqOperation();
			operationMap[MathML.NOT.toString()] = new NotOperation();
			operationMap[MathML.NOTIN.toString()] = new NotInOperation();
			operationMap[MathML.NOTPRSUBSET.toString()] = new NotPrSubsetOperation();
			operationMap[MathML.NOTSUBSET.toString()] = new NotSubsetOperation();
			operationMap[MathML.OR.toString()] = new OrOperation();
			// :TODO: outerproduct
			// :TODO: partialdiff
			operationMap[MathML.PLUS.toString()] = new PlusOperation();
			// :TODO: power
			operationMap[MathML.PRSUBSET.toString()] = new PrSubsetOperation();
			// :TODO: quotient
			// :TODO: real
			// :TODO: rem
			// :TODO: root
			// :TODO: scalarproduct
			// :TODO: sdev
			// :TODO: sec
			// :TODO: sech
			// :TODO: selector
			operationMap[MathML.SETDIFF.toString()] = new SetDiffOperation();
			operationMap[MathML.SIN.toString()] = new SinOperation();
			// :TODO: sinh?
			operationMap[MathML.SUBSET.toString()] = new SubsetOperation();
			// :TODO: sum?
			operationMap[MathML.TAN.toString()] = new TanOperation();
			// :TODO: tanh?
			// :TODO: tendsto?
			operationMap[MathML.TIMES.toString()] = new TimesOperation();
			// :TODO: transpose?
			operationMap[MathML.UNION.toString()] = new UnionOperation();
			// :TODO: variance?
			// :TODO: vectorproduct?
			operationMap[MathML.XOR.toString()] = new XOrOperation();
		}
	}
}