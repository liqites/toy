package com.tesla.symbol;

/**
 * Created by liqi on 15/7/31.
 */
public class Symbol {
    public String name;
    public Type type;

    public Symbol(String name) {this.name = name;}
    public Symbol(String name, Type type) {this(name);this.type = type;}
    public String getName() {return name;}
    public String toString() {
        if(type != null) return '<' + getName()+":"+type+'>';
        return getName();
    }
}
