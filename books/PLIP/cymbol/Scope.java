public interface Scope {
	public String getScopeName();
	public Scope getEncolsingScope();
	public void define(Symbol sym);
	public Symbol resolve(String name);
}
