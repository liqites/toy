package com.tesla.scope;

import com.tesla.symbol.Symbol;

/**
 * Created by liqi on 15/8/2.
 */
public interface Scope {
    public String getScopeName();
    public Scope getEnclosingScope();
    public void define(Symbol sym);
    public Symbol resolve(String name);
}
