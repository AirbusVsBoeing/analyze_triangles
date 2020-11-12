package triangle.analyze;

import java.util.ArrayList;
import java.util.HashMap;

@SuppressWarnings("serial")
public class Graph extends ArrayList<HashMap<Integer,Double>> { 

	
	public int numEdges; 
	public int numVertices; 
	

	public Graph(int numVertices){
		super(numVertices);
		//System.out.println("Graph Size:" + this.size());
		for(int i = 0; i < numVertices; i++)
			this.add(new HashMap<Integer,Double>());
	}
	
	private int computeEdges() {
		return 0;
	}
	
	
	
}
