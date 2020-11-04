package triangle.analyze;

public class Edge {

	public int nodeOne;
	public int nodeTwo; 
	public double weight;
	
	public Edge(int i, int j, double weight) {
		this.nodeOne = i;
		this.nodeTwo = j;
		this.weight = weight;
	}
	
	@Override 
	public String toString() {
		return Integer.toString(nodeOne) + "-----" + Double.toString(weight) + "-----" + Integer.toString(nodeTwo);
	}
	
	
}
