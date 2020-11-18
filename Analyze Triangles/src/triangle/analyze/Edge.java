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
	
	@Override
	public boolean equals(Object obj) {
		Edge e2 = (Edge) obj;
		if((this.nodeOne == e2.nodeOne && this.nodeTwo == e2.nodeTwo) || (this.nodeOne == e2.nodeTwo && this.nodeTwo == e2.nodeOne))
			return true;
		return false;
	}
	
	
}
