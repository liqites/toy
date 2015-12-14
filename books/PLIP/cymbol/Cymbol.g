grammar Cymbol;

@members {SymbolTable symtab;}
compilationUnit[SymbolTable symtab]
@init {this.symtab = symtab;}
    : varDeclaration+
    ;
type return [Type tsym]
@after {
  System.out.println("line "+$start.getLine()+": ref "+$tsym.getName());
}
    : 'float' {$tsym = (Type)symtab.resolve("float");}
    : 'int' {$tsym = (Type)symtab.resolve("int");}
    ;

varDeclaration
    : type ID ('=' expression)? ';'
      {
        System.out.println("line "+$ID.getLine()+": def "+$ID.text);
        VariableSymbol vs = new VariableSymbol($ID.text, $type.tsym);
        symtab.define(vs);
      }
    ;

primary
    : ID
      {
        System.out.println("line "+$ID.getLine()+": ref to "+ symtab.resolve($ID.text));
      }
    | INT
    | '(' expression ')'
    ;
