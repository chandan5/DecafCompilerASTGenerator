DECAF:
	bison -d --verbose Assignment3.y -o Assignment3.tab.cc
	flex -o lex.yy.cc Assignment3.l
	g++  Assignment3.tab.cc lex.yy.cc main.cpp -ll -g
