#include "AST.h"
// #include "Visitor.h"
#include <iostream>
#include <cstdio>

using namespace std;

class PrintVisitor : public Visitor {
    ASTProgram * astRoot;
public:
    PrintVisitor(ASTProgram * astRoot) {
        this->astRoot = astRoot;
    }
    void print() {
        this->visit(astRoot);
    }
    void visit(ASTProgram * node) {
        cout << "<program>" << endl;
        int count_decls = 0;
        if(node->getASTDeclarations() != NULL) {
            count_decls = node->getASTDeclarations()->size();
        }
        cout << "<declarations count=\"" << count_decls << "\">" << endl;
        if(count_decls)
        for(auto it : *(node->getASTDeclarations())) {
            it->accept(this);
        }
        cout << "</declarations>" << endl;
        int count_stmts = 0;
        if(node->getASTStatements() != NULL) {
            count_stmts = node->getASTStatements()->size();
        }
        cout << "<statements count=\"" << count_stmts << "\">" << endl;
        if(count_stmts)
        for(auto it : *(node->getASTStatements())) {
            if(it == NULL)
                cout << "Whoa!!! NULL" << endl;
            it->accept(this);
        }
        cout << "</statements>" << endl;
        cout << "</program>" << endl;
    }
    void visit(ASTNormalDeclaration * node) {
        cout << "<declaration name=\"" << node->getId() << "\" type=\"" << node->getDataType() << "\" />" << endl;
    }
    void visit(ASTArrayDeclaration * node) {
        cout << "<declaration name=\"" << node->getId() << "\" type=\"" << node->getDataType() << "\" size=\"" << node->getSize() << "\" />"<< endl;
    }
    void visit(ASTIntegerLiteralExpression * node) {
        cout << "<integer value=\"" << node->getVal() << "\" />" << endl;
    }
    void visit(ASTBooleanLiteralExpression * node) {
        cout << "<boolean value=\"" << node->getVal() << "\" />" << endl;
    }
    void visit(ASTAssignmentStatement * node) {
        cout << "<assignmnet>" << endl;
        cout << "<LHS name=\"" << node->getASTlocation()->getId() << "\">" << endl;
        ASTArrayLocation * arraylocation  = dynamic_cast<ASTArrayLocation *>(node->getASTlocation());

        if(arraylocation)
            arraylocation->accept(this);
        
        cout << "</LHS>" << endl;
        cout << "<RHS>" << endl;
        node->getASTExpression()->accept(this);
        cout << "</RHS>" << endl;
        cout << "</assignmnet>" << endl;
    }

    void visit(ASTBinaryExpression * node) {
        cout << "<binary_expression type=\"" << node->getBinOp() << "\">" << endl;
        node->getLeftExpression()->accept(this);
        node->getRightExpression()->accept(this);
        cout << "</binary_expression>" << endl;
    }

    void visit(ASTVarLocation * node) {
        cout << "<identifier name=\"" << node->getId() << "\" />"<< endl;
    }

    void visit(ASTArrayLocation * node) {
        cout << "<identifier name=\"" << node->getId() << "\">"<< endl;
        node->getASTExpression()->accept(this);
        cout << "</identifier>" << endl;
    }

};
