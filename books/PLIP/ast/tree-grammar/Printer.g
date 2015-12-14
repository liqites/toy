tree grammar Printer;
options {
  tokenVocab=VecMath;
  ASTLabelType=CommonTree;
}
@members { void print(String s) { System.out.print(s); } }

prog: stat+ ;
stat: ^('=' ID {print($ID.text +" = ");} expr) {print("\n");}
    | ^{'print' {print("print ");} expr} {print("\n");}
    ;
expr: ^('+' expr {print("+");} expr)
    | ^('*' expr {print("-");} expr)
    | ^('.' expr {print(".");} expr)
    | ^(VEC {print("[");} expr ({expr(",");} expr)* {print("]");})
    | INT {print($INT.text);}
    | ID {print($ID.text);}
    ;
