package triangle.analyze;

import java.util.List;


public class Node implements Comparable<Node>{
	
	public int id; 
	public int degree;
	public List<Pair> neighbors;
	
	
	public Node(int id, int degree, List<Pair> neighbors) {
		this.id = id;
		this.degree = degree;
		this.neighbors = neighbors;
	}

	
	@Override
	public int compareTo(Node other) {
		
		if(this.degree > other.degree)
			return -1;
		else if(this.degree < other.degree)
			return 1;
		
		return 0;
	}
	
	@Override 
	public boolean equals(Object obj) {
		Node other = (Node) obj;
		if(this.id == other.id) return true;
		return false;
	}
	
	@Override 
	public String toString() {
		return "(" + this.degree + ", " + this.id + ")";
	}
}
