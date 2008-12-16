package a3lbmonkeybrain.calculia.mathml
{
	import a3lbmonkeybrain.brainstem.collections.EmptySet;
	import a3lbmonkeybrain.brainstem.collections.HashSet;
	import a3lbmonkeybrain.brainstem.resolve.*;
	import a3lbmonkeybrain.brainstem.w3c.mathml.*;
	import a3lbmonkeybrain.calculia.collections.domains.*;
	import a3lbmonkeybrain.calculia.collections.operations.Operation;
	import a3lbmonkeybrain.brainstem.math.MathImplError;
	import a3lbmonkeybrain.calculia.numbers.ComplexNumber;
	
	public final class MathMLResolver implements XMLResolver
	{
		private var _entityResolver:XMLResolver;
		private var identifierResolver:IdentifierResolver;
		private var operationResolver:OperationResolver;
		public function MathMLResolver(identifierResolver:IdentifierResolver = null,
			operationResolver:OperationResolver = null, entityResolver:XMLResolver = null)
		{
			super();
			this.identifierResolver = identifierResolver
				? identifierResolver
				: new MathMLIdentifierResolver();
			this.operationResolver = operationResolver
				? operationResolver
				: new MathMLOperationResolver();
			this.entityResolver = entityResolver ? entityResolver : this;
		}
		public function set entityResolver(value:XMLResolver):void
		{
			_entityResolver = value ? value : this;
		}
		protected function getApplication(mathML:XML):Object
		{
			if (!(mathML.children().length() >= 1))
				throw new MathMLError("An operation application does not have any subelements.");
			if (mathML.children()[0].name() == MathML.EXISTS)
				return getExistentialQuantification(mathML.children().(childIndex() > 0));
			if (mathML.children()[0].name() == MathML.FORALL)
				return getUniversalQuantification(mathML.children().(childIndex() > 0));
			var operation:Operation;
			if (mathML.children()[0].name() == MathML.APPLY)
			{
				const result:* = getApplication(mathML.children()[0]);
				if (!(result is Operation))
					throw new MathMLError("The first subelement of an application must resolve to an operation;"
						+ " found: " + result);
				operation = result as Operation;
			}
			else
			{
				operation = operationResolver.getOperation(mathML.children()[0]);
			}
			if (operation is Unresolvable)
				return operation;
			return operation.apply(getOperands(mathML));
		}
		protected function getBoundVariable(mathML:XML):BoundVariable
		{
			if (mathML.children().length() != 1 || mathML.children()[0].name() != MathML.CI)
				throw new MathMLError("A bound variable element must have an identifier as its sole"
					+ " subelement.");
			return new BoundVariable(mathML.children()[0].text().toXMLString());
		}
		protected function getChildren(mathML:XML):Array
		{
			const children:Array = [];
			const n:int = mathML.children().length();
			for (var i:int = 0; i < n; ++i)
				children.push(_entityResolver.resolveXML(mathML.children()[i]));
			return children;
		}
		protected function getDeclaredEntity(mathML:XML):Object
		{
			const n:int = mathML.children().length();
			if (n != 2)
				throw new MathMLError("A declaration must have exactly two subelements; found " + n + "."); 
			if (mathML.children()[0].name() != MathML.CI)
				throw new MathMLError("The first subelement of a declaration must be a content identifier;"
					+ " found: " + mathML.children()[0].name());
			const value:Object = _entityResolver.resolveXML(mathML.children()[1]);
			if (value == null || value is Unresolvable)
				throw new MathMLError("Invalid declaration for: " + mathML.children()[0].@id);
			identifierResolver.setEntity(mathML.children()[0], value);
			return value;
		}
		protected function getExistentialQuantification(mathML:XMLList):Boolean
		{
			// :TODO:
			return false;
		}
		protected function getNumber(mathML:XML):Object
		{
			default xml namespace = MathML.NAMESPACE.uri;
			const type:String = mathML.@type ? mathML.@type : "real";
			var n:Number;
			switch (type) {
				case "complex-cartesian" :
				{
					return ComplexNumber.fromCartesian(Number(mathML.text()[0]), Number(mathML.text()[1]));
				}
				case "complex-polar" :
				{
					return ComplexNumber.fromPolar(Number(mathML.text()[0]), Number(mathML.text()[1]));
				}
				case "constant" :
				{
					throw new MathImplError("Number constants are not implemented.");
				}
				case "integer" :
				{
					const base:uint = mathML.@base ? parseInt(mathML.base) : 10;
					n = parseInt(mathML.text(), base);
					break;
				}
				case "rational" :
				{
					if (mathML.text().length() == 1)
						n = parseInt(mathML.text()[0]);
					else
						n = parseInt(mathML.text()[0]) / parseInt(mathML.text()[1]);
					break;
				}
				case "real" :
				default :
				{
					n = Number(mathML.text());
					break;
				}
			}
			if (isNaN(n))
				throw new MathMLError("Number element does not resolve to a valid number: " + mathML);
			return n;
		}
		protected function getOperands(applyNode:XML):Array
		{
			const args:Array = [];
			const n:int = applyNode.children().length();
			for (var i:int = 1; i < n; ++i)
				args.push(_entityResolver.resolveXML(applyNode.children()[i]));
			return args;
		}
		private function getPiecewise(mathML:XML):Object
		{
			const n:int = mathML.children().length();
			for (var i:int = 0; i < n; ++i)
			{
				var child:XML = mathML.children()[i] as XML;
				if (i < n - 1)
				{
					if (child.name() != MathML.PIECE)
						throw new MathMLError("Expected " + MathML.PIECE + "; found: " + child.name());
					if (child.children().length() != 2)
						throw new MathMLError("A piece must have two subelements; found "
							+ child.children().length());
					var test:* = _entityResolver.resolveXML(child.children()[1]); 
					if (test is Boolean)
					{
						if (test)
							return _entityResolver.resolveXML(child.children()[0]);
					}
					else
					{
						XML.prettyPrinting = false;
						throw new MathMLError("The second element of a piece must be a Boolean expression;"
							+ " found: " + child.children()[1].toXMLString());
					}
				}
				else
				{
					if (child.name() != MathML.OTHERWISE)
						throw new MathMLError("Expected " + MathML.OTHERWISE + "}; found: " + child.name());
					if (child.children().length() != 1)
						throw new MathMLError("An otherwise piece must have one subelement; found "
								+ child.children().length() + ".");
					return _entityResolver.resolveXML(child.children()[0]);
				}
			}
			XML.prettyPrinting = false;
			throw new MathMLError("Invalid piecewise expression: " + mathML.toXMLString());
		}
		protected function getSymbol(mathML:XML):Object
		{
			return new UnresolvableXML(mathML);
		}
		protected function getUniversalQuantification(mathML:XMLList):Boolean
		{
			// :TODO:
			return false;
		}
		public function resolveXML(mathML:XML):Object
		{
			if (!mathML.name())
			{
				XML.prettyPrinting = false;
				throw new MathMLError("Invalid element: " + mathML.toXMLString());
			}
			switch (mathML.name().toString())
			{
				case MathML.APPLY.toString() :
				{
					return getApplication(mathML);
				}
				case MathML.BVAR.toString() :
				{
					// :TODO: redo?
					return getBoundVariable(mathML);
				}
				case MathML.CI.toString() :
				{
					// :TODO: add bvar functionality
					return identifierResolver.resolveXML(mathML);
				}
				case MathML.CN.toString() :
				{
					return getNumber(mathML);
				}
				case MathML.COMPLEXES.toString() :
				{
					return Complexes.INSTANCE;
				}
				case MathML.CSYMBOL.toString() :
				{
					return getSymbol(mathML);
				}
				case MathML.DECLARE.toString() :
				{
					return getDeclaredEntity(mathML);
				}
				// :TODO: degree
				case MathML.EMPTYSET.toString() :
				{
					return EmptySet.INSTANCE;
				}
				case MathML.EXPONENTIALE.toString() :
				{
					return Math.E;
				}
				case MathML.FALSE.toString() :
				{
					return false;
				}
				case MathML.INFINITY.toString() :
				{
					return Number.POSITIVE_INFINITY;
				}
				case MathML.INTEGERS.toString() :
				{
					return Integers.INSTANCE;
				}
				// :TODO: interval
				case MathML.LIST.toString() :
				{
					return getChildren(mathML);
				}
				// :TODO: logbase
				// :TODO: lowlimit
				// :TODO: matrix
				// :TODO: momentabout
				case MathML.NATURALNUMBERS.toString() :
				{
					return NaturalNumbers.INSTANCE;
				}
				case MathML.NOTANUMBER.toString() :
				{
					return NaN;
				}
				case MathML.PI.toString() :
				{
					return Math.PI;
				}
				case MathML.PIECEWISE.toString() :
				{
					return getPiecewise(mathML);
				}
				case MathML.PRIMES.toString() :
				{
					return Primes.INSTANCE;
				}
				// :TODO: product
				case MathML.RATIONALS.toString() :
				{
					return Rationals.INSTANCE;
				}
				case MathML.REALS.toString() :
				{
					return Reals.INSTANCE;
				}
				case MathML.SET.toString() :
				{
					// :TODO: Check for BVar
					return HashSet.fromObject(getChildren(mathML));
				}
				case MathML.TRUE.toString() :
				{
					return true;
				}
				// :TODO: uplimit
				case MathML.VECTOR.toString() :
				{
					return getChildren(mathML);
				}
				default :
				{
					const operation:Operation = operationResolver.getOperation(mathML);
					if (!(operation is Unresolvable))
						return operation;
					return new UnresolvableXML(mathML);
				}
			}
		}
	}
}