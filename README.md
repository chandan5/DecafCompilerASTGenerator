# DecafCompilerASTGenerator

XML Generation Specifications of Grammer can be seen in Compilers 2016 Assignment 3.pdf

Assignment3.l contails tokenizer and Assignment3.y contails grammer for C-lite/Decaf Programming Language.

AST.h contains definations of all nodes of AST.

PrintVisitor.cpp contains functions printing XML.

To compile => Enter `make -B` in terminal

To run => Enter `./a.out <inputFileName>`

After running you will see "Success" or "Syntax Error" as output.

If you see "Success" `XML_visitor.txt` will contain the XML corresponding to the AST Tree
