package triangle.analyze;

import java.util.ArrayList;
import java.util.List;

@SuppressWarnings("serial")
public class Graph extends ArrayList<ArrayList<Pair>> { 

	
	public int numEdges; 
	public int numVertices; 
	public List<Edge> edges;
	

	public Graph(int numVertices){
		super(numVertices);
		//System.out.println("Graph Size:" + this.size());
		for(int i = 0; i < numVertices; i++)
			this.add(new ArrayList<Pair>());
	}
	
	
	
	
	
}
