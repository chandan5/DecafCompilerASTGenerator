%{
    #include <cstdio>
    #include <iostream>
    #include <fstream>
    #include "AST.h"

    extern "C" int yylex();
	extern "C" int yyparse();
	extern "C" FILE * yyin;
	extern int yylineno;

    void yyerror(const char *s);
    extern ASTProgram * astRoot;
%}

%token SEMICOLON
%token OPEN_PARANTHESIS
%token CLOSE_PARANTHESIS
%token OPEN_SQUAREBRACKET
%token CLOSE_SQUAREBRACKET
%token OPEN_CURLYBRACE
%token CLOSE_CURLYBRACE

%token MAIN
%token FALSE
%token INT
%token BOOLEAN
%token TRUE
%token EQUAL
%token PLUS MINUS
%token MULTIPLY DIVIDE MODULO


%token <sval> IDENTIFIER
%token <ival> INT_VALUE

%type <program> program
%type <declarations> declarations
%type <declaration> declaration
%type <statements> statements
%type <statement> statement
%type <literal> literal
%type <location> location
%type <expression> expression
%type <type> type

%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO

%%
    program: INT MAIN OPEN_PARANTHESIS CLOSE_PARANTHESIS OPEN_CURLYBRACE
                declarations statements CLOSE_CURLYBRACE {$$ = new ASTProgram($6,$7); astRoot = $$;}
        |    INT MAIN OPEN_PARANTHESIS CLOSE_PARANTHESIS OPEN_CURLYBRACE
                    declarations CLOSE_CURLYBRACE {$$ = new ASTProgram($6,NULL); astRoot = $$;}
        |    INT MAIN OPEN_PARANTHESIS CLOSE_PARANTHESIS OPEN_CURLYBRACE
                    statements CLOSE_CURLYBRACE {$$ = new ASTProgram(NULL,$6); astRoot = $$;}
        |    INT MAIN OPEN_PARANTHESIS CLOSE_PARANTHESIS OPEN_CURLYBRACE
                    CLOSE_CURLYBRACE {$$ = new ASTProgram(NULL,NULL); astRoot = $$;}

    declarations :  declaration {$$ = new vector<ASTDeclaration *>(); $$->push_back($1);}
                |   declarations declaration {$1->push_back($2); $$ = $1;}
    statements :    statement {$$ = new vector<ASTStatement *>(); $$->push_back($1);}
                |   statements statement {$1->push_back($2); $$ = $1;}
    declaration :   type IDENTIFIER SEMICOLON {$$ = new ASTNormalDeclaration($1,std::string($2));}
                |   type IDENTIFIER OPEN_SQUAREBRACKET INT_VALUE CLOSE_SQUAREBRACKET SEMICOLON {$$ = new ASTArrayDeclaration($1,string($2),$4);}
    statement : SEMICOLON {$$ = NULL;}
            |   location EQUAL expression SEMICOLON {$$ = new ASTAssignmentStatement($1,$3);}

    expression : location {$$ = $1;}
            |    literal {$$ = $1;}
            |    expression PLUS expression {$$ = new ASTBinaryExpression($1,$3,BinOp::plus_op);}
            |    expression MINUS expression {$$ = new ASTBinaryExpression($1,$3,BinOp::minus_op);}
            |    expression MULTIPLY expression {$$ = new ASTBinaryExpression($1,$3,BinOp::multiply_op);}
            |    expression DIVIDE expression {$$ = new ASTBinaryExpression($1,$3,BinOp::divide_op);}
            |    expression MODULO expression {$$ = new ASTBinaryExpression($1,$3,BinOp::modulo_op);}
            |    OPEN_PARANTHESIS expression CLOSE_PARANTHESIS {$$ = $2;}

    location : IDENTIFIER {$$ = new ASTVarLocation(std::string($1));}
            |  IDENTIFIER OPEN_SQUAREBRACKET expression CLOSE_SQUAREBRACKET {$$ = new ASTArrayLocation(std::string($1), $3);}
    literal :INT_VALUE {$$ = new ASTIntegerLiteralExpression($1);}
            | TRUE {$$ = new ASTBooleanLiteralExpression(true);}
            | FALSE {$$ = new ASTBooleanLiteralExpression(false);}

    type :  INT {$$ = DataType::int_type;}
        |   BOOLEAN {$$ = DataType::bool_type;}


%%

void yyerror (const char *s) {
    std::cout << "Syntax error" << std::endl;
	// std::cerr << "Parse Error on Line : " << yylineno << std::std::endl << "Message : " << s << std::std::endl;
	exit(-1);
}
// use test for debugging
//test:  IDENTIFIER {std::cout << "found Identifier" << std::endl;}
