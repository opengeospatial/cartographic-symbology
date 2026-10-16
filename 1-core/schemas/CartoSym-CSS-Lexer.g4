lexer grammar CartoSymCSSLexer;

channels { WHITESPACE, COMMENTS }

LCBR: '{';
RCBR: '}';
DOT: '.';
SEMI: ';';
LSBR: '[';
RSBR: ']';
LPAR: '(';
RPAR: ')';
COMMA: ',';
EQ: '=';
LT: '<';
LTEQ: '<=';
GT: '>';
GTEQ: '>=';
IN: I N;
NOT: N O T;
IS: I S;
LIKE: L I K E;
BETWEEN: B E T W E E N;
QUESTION: '?';
COLON: ':';
AND: A N D;
OR: O R;
MUL: '*';
DIV: '/';
IDIV: D I V;
MOD: '%';
POW: '^';
MINUS: '-';
PLUS: '+';

// CQL2 keywords are case-insensitive (CQL2-Text BNF); one fragment per letter.
fragment A: [aA];
fragment B: [bB];
fragment D: [dD];
fragment E: [eE];
fragment I: [iI];
fragment K: [kK];
fragment L: [lL];
fragment N: [nN];
fragment O: [oO];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment V: [vV];
fragment W: [wW];

// Numeric Literals

UNIT:
   'px' |
   'm' |
   'ft' |
   'pc' |
   'pt' |
   'em' |
   'inch' |
   'cm' |
   'mm';

HEX_LITERAL :
    '#' ([0-9] | [a-f] | [A-F])+;

NUMERIC_LITERAL :
        ( [0-9]+ ('.' ([0-9]+)? )? |
        '.' [0-9]+ )
    (E ('+'|'-')? [0-9]+)?;

// Character Literals

fragment WHITESPACE:  '\u0009'  // Character tabulation
           | '\u000A'  // Line feed
           | '\u000B'  // Line tabulation
           | '\u000C'  // Form feed
           | '\u000D'  // Carriage return
           | '\u0020'  // Space
           | '\u0085'  // Next line
           | '\u00A0'  // No-break space
           | '\u1680'  // Ogham space mark
           | '\u2000'  // En quad
           | '\u2001'  // Em quad
           | '\u2002'  // En space
           | '\u2003'  // Em space
           | '\u2004'  // Three-per-em space
           | '\u2005'  // Four-per-em space
           | '\u2006'  // Six-per-em space
           | '\u2007'  // Figure space
           | '\u2008'  // Punctuation space
           | '\u2009'  // Thin space
           | '\u200A'  // Hair space
           | '\u2028'  // Line separator
           | '\u2029'  // Paragraph separator
           | '\u202F'  // Narrow no-break space
           | '\u205F'  // Medium mathematical space
           | '\u3000'; // Ideographic space

fragment CHARACTER : CHARACTER_NODLBQUOTE | '"' | ESCAPED_QUOTE;
fragment CHARACTER_NODLBQUOTE : ALPHA_NODBLQUOTE | [0-9] | WHITESPACE;

fragment CHARACTER_LITERAL_PART :'\'' CHARACTER* '\'';

CHARACTER_LITERAL : CHARACTER_LITERAL_PART (WS+ CHARACTER_LITERAL_PART)*;

fragment ESCAPED_QUOTE :'\'\'' | '\\\'';

fragment ALPHA_NODBLQUOTE : '\u0007'..'\u0008'     // bell, bs
      | '\u0021'               // !
      | '\u0023'..'\u0026'     // #, $, %, &
      | '\u0028'..'\u002F'     // (, ), *, +, comma, -, ., /
      | '\u003A'..'\u0084'     // --+
      | '\u0086'..'\u009F'     //   |
      | '\u00A1'..'\u167F'     //   |
      | '\u1681'..'\u1FFF'     //   |
      | '\u200B'..'\u2027'     //   +-> :,;,<,=,>,?,@,A-Z,[,\,],^,_,`,a-z,...
      | '\u202A'..'\u202E'     //   |
      | '\u2030'..'\u205E'     //   |
      | '\u2060'..'\u2FFF'     //   |
      | '\u3001'..'\uD7FF'     // --+
      | '\uE000'..'\uFFFD'     // See (CQL2) note 8.
      ;

// Identifiers

IDENTIFIER: UNQUOTED_IDENTIFIER | '"' CHARACTER_NODLBQUOTE* '"';

AT_SIGN: '@';

fragment UNQUOTED_IDENTIFIER: IDENTIFIER_START IDENTIFIER_PART*;

fragment IDENTIFIER_PART: IDENTIFIER_START
               | [0-9]                  // 0-9
               | '\u0300'..'\u036F'     // combining and diacritical marks
               | '\u203F'..'\u2040';    // ‿ and ⁀

fragment IDENTIFIER_START:
                  '\u005F'            // underscore
                | '\u0041'..'\u005A'   // A-Z
                | '\u0061'..'\u007A'   // a-z
                | '\u00C0'..'\u00D6'   // À-Ö Latin-1 Supplement Letters
                | '\u00D8'..'\u00F6'   // Ø-ö Latin-1 Supplement Letters
                | '\u00F8'..'\u02FF'   // ø-ÿ Latin-1 Supplement Letters
                | '\u0370'..'\u037D'   // Ͱ-ͽ Greek and Coptic (without ';')
                | '\u037F'..'\u1FFE'   // See (CQL2) note 1.
                | '\u200C'..'\u200D'   // zero width non-joiner and joiner
                | '\u2070'..'\u218F'   // See (CQL2) note 2.
                | '\u2C00'..'\u2FEF'   // See (CQL2) note 3.
                | '\u3001'..'\uD7FF'   // See (CQL2) note 4.
                | '\uF900'..'\uFDCF'   // See (CQL2) note 5.
                | '\uFDF0'..'\uFFFD'   // See (CQL2) note 6.
                ;

COMMENT
    : '/*' .*? '*/' -> channel(COMMENTS)
    ;

LINE_COMMENT
    : '//' ~[\r\n]* -> channel(COMMENTS)
    ;

WS : [ \t\r\n]+ -> channel(WHITESPACE); // skip spaces, tabs, newlines
