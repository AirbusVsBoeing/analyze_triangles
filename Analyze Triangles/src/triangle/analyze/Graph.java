package triangle.analyze;

import java.util.ArrayList;
import java.util.HashMap;

public class Graph extends HashMap<Integer,HashMap<Integer,Double>> { 

	
	public int numEdges; 
	public int numVertices; 
	
	public Graph(){
		this.numVertices = this.size();
		this.numEdges = this.computeEdges();
		
	}
	
	private int computeEdges() {
		return 0;
	}
	
	
	
}
