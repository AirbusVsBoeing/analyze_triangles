package triangle.analyze;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Triangle {
	
	private Graph graph;
	private List<Integer> vertices;
	private List<List<Edge>> triangles;
	
	public Triangle(Graph graph) {
		this.graph = graph;
		this.vertices = new ArrayList<Integer>(this.graph.size());
		System.out.println("num Vertices:" + this.vertices.size());
		for(int i = 0; i < this.graph.size();i++) {
			this.vertices.add(i);
		
		}
		this.triangles = new ArrayList<List<Edge>>();
		
	}
	
	public List<List<Edge>> listTriangles(){
		
		
		for(int i = 0; i < this.vertices.size(); i++) {
			for(int j = 0; j < this.vertices.size(); j++) {
				//if(i==j) continue;
				
				for(int k = 0; k < this.vertices.size();k++) {
					if(j==k) continue;
				
					checkTriangle(i,j,k);
				}
			}
		}
	
		return this.triangles;
	}
	
	
	private void checkTriangle(int i, int j, int k) {
		
		HashMap<Integer,Double> iList = this.graph.get(i);
		HashMap<Integer,Double> jList = this.graph.get(j);
		HashMap<Integer,Double> kList = this.graph.get(k);
		
		if(iList.containsKey(j) && jList.containsKey(k) && kList.containsKey(i)) {
			
			List<Edge> triangle = new ArrayList<Edge>();
			triangle.add(new Edge(i,j,iList.get(j)));
			triangle.add(new Edge(j,k,jList.get(k)));
			triangle.add(new Edge(k,i,kList.get(i)));
			
			
			this.triangles.add(triangle);
		}
	}
	
	
}
