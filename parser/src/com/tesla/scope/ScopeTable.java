package com.tesla.scope;

import com.tesla.symbol.BuiltInTypeSymbol;
import com.tesla.symbol.Symbol;
import sun.jvm.hotspot.memory.SymbolTable;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by liqi on 15/8/2.
 */
public class ScopeTable implements Scope {
    Map<String, Symbol> symbols = new HashMap<String, Symbol>();
    public ScopeTable() {initTypeSystem();}

    protected void initTypeSystem(){
        define(new BuiltInTypeSymbol("int"));
        define(new BuiltInTypeSymbol("float"));
    }

    //实现接口
    public String getScopeName() {return "global";}
    public Scope getEnclosingScope() {return null;}
    public void define(Symbol sym) {symbols.put(sym.name,sym);}
    public Symbol resolve(String name){return symbols.get(name);}
    public String toString() {return getScopeName() + ":" + symbols;}
}
