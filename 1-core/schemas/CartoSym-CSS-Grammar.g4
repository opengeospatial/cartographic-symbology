parser grammar CartoSymCSSGrammar;
options { tokenVocab=CartoSymCSSLexer; }

///////////////////////////////
// High level style sheet rules
///////////////////////////////

styleSheet: metadata* variableDef* stylingRuleList?;

// A unit name (px, m, mm...) is a unit only after a number (see expConstant);
// anywhere else it is an identifier, as any other name.
identifier: IDENTIFIER | UNIT;

variable: AT_SIGN identifier;

variableDef: variable EQ expression SEMI;

metadata:
    '.' IDENTIFIER CHARACTER_LITERAL;

// NOTE: Only .name is valid for stylingRuleName
stylingRuleName:
    '.' IDENTIFIER CHARACTER_LITERAL;

stylingRuleList:
     stylingRule
   | stylingRuleList stylingRule;

stylingRule:
   ( selector )*
   LCBR
      stylingRuleName?
      (propertyAssignmentList SEMI)?
      stylingRuleList?
   RCBR;

selector:
     identifier
   | LSBR expression RSBR ;

///////////////////////////////
// Expressions

idOrConstant:
     identifier
   | expConstant;

tuple:
     idOrConstant idOrConstant
   | tuple idOrConstant;

expression:
     idOrConstant

   | expression DOT identifier   // Member access

   | expString
   | expCall
   | expArray

   | expInstance

   | LPAR expression RPAR

   | expression LSBR expConstant RSBR  // Indexing

   // Operations
   | unaryArithmeticOperator expression
   | expression arithmeticOperatorExp expression
   | expression arithmeticOperatorMul expression
   | expression arithmeticOperatorAdd expression
   | expression relationalOperator expression
   | expression betweenOperator betweenBound AND betweenBound
   | unaryLogicalOperator expression
   | expression AND expression
   | expression OR expression
   | <assoc=right> expression QUESTION expression COLON expression

   | tuple

   | variable
   ;

// Operands of "between": arithmetic expressions only (no and / or / comparison),
// so that the "and" separating the bounds is never part of a bound.
betweenBound:
     idOrConstant
   | expString
   | expCall
   | expArray
   | expInstance
   | variable
   | LPAR expression RPAR
   | betweenBound DOT identifier
   | betweenBound LSBR expConstant RSBR
   | unaryArithmeticOperator betweenBound
   | betweenBound arithmeticOperatorExp betweenBound
   | betweenBound arithmeticOperatorMul betweenBound
   | betweenBound arithmeticOperatorAdd betweenBound
   ;

expConstant: NUMERIC_LITERAL UNIT? | HEX_LITERAL;

expString: CHARACTER_LITERAL;

///////////////////////////////
// Expressions: Instances

expInstance:
   identifier?
   LCBR
      propertyAssignmentInferredList?
      SEMI?
   RCBR |
   identifier
   LPAR
      propertyAssignmentInferredList?
      SEMI?
   RPAR
   ;

lhValue:
     identifier
   | lhValue DOT identifier
   | lhValue LSBR expConstant RSBR ;

propertyAssignment:
   lhValue COLON expression;

propertyAssignmentList:
     propertyAssignment
   | propertyAssignmentList SEMI propertyAssignment;

propertyAssignmentInferred:
     propertyAssignment
   | expression
   ;

propertyAssignmentInferredList:
     propertyAssignmentInferred
   | propertyAssignmentInferredList SEMI propertyAssignmentInferred
   | propertyAssignmentInferredList COMMA propertyAssignmentInferred
   ;

///////////////////////////////
// Expressions: Arrays

expArray:
     LSBR arrayElements? RSBR
   | LPAR arrayElements? RPAR;

arrayElements:
     expression
   | arrayElements COMMA expression ;

///////////////////////////////
// Expressions: Function calls

expCall: identifier LPAR arguments? RPAR ;

arguments:
   expression
   | arguments COMMA expression;

unaryLogicalOperator: NOT ;

unaryArithmeticOperator: PLUS | MINUS;

arithmeticOperatorExp:
   POW;

arithmeticOperatorMul:
     MUL
   | DIV
   | IDIV
   | MOD;

arithmeticOperatorAdd:
     MINUS
   | PLUS
;

relationalOperator:
     EQ
   | NEQ
   | LT
   | LTEQ
   | GT
   | GTEQ
   | IN
   | NOT IN
   | IS
   | IS NOT
   | LIKE
   | NOT LIKE;

betweenOperator:
     BETWEEN
   | NOT BETWEEN;
