package triangle.analyze;

public class Pair {

	public int node;
	public double weight;
	
	public Pair(int node, double weight){
		this.node = node;
		this.weight = weight;
	}
	
	@Override 
	public boolean equals(Object obj) {
		Pair p = (Pair) obj;
		if(this.node == p.node) return true;
		return false;
	}
	
	@Override
	public String toString() {
		return "("+this.node+", "+this.weight+")";
	}
	
}
