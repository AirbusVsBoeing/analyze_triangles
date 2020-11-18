package triangle.analyze;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class TriangleOps {
	
	public Graph graph;
	public List<Integer> vertices;
	public List<Triangle> triangles;
	public List<Edge> edges;
	
	
	public TriangleOps(Graph graph) {
		this.graph = graph;
		this.edges = graph.edges;
		this.vertices = new ArrayList<Integer>(this.graph.size());
		for(int i = 0; i < this.graph.size();i++) {
			this.vertices.add(i);
		
		}
		this.triangles = new ArrayList<Triangle>();
		
	}
	
	// naive O(n^3) time triangle listing algorithm
	public List<Triangle> listTriangles(){
		
		//System.out.println("HERE!!");
		
		for(int i = 0; i < this.vertices.size(); i++) {
		//	System.out.println("i:" + i);
			for(int j = 0; j < this.vertices.size(); j++) {
		//		System.out.println("j:" +j);
				if(i==j) continue;
				
				for(int k = 0; k < this.vertices.size();k++) {
					if(j==k || k == i) continue;
					checkTriangle(i,j,k);
				}
			}
		}
	
		return this.triangles;
	}
	
	
	// naive triangle listing algorithm by checking edges
	public List<Triangle> listTrianglesE(){
	
		
		for(int i = 0; i < this.edges.size(); i++) {
			for(int j = i+1; j < this.edges.size(); j++) {
				Edge e1 = this.edges.get(i);
				Edge e2= this.edges.get(j);
				if((e1.nodeOne == e1.nodeTwo) || (e2.nodeOne == e2.nodeTwo)) continue;
				if(e1.nodeOne == e2.nodeOne) {
					Edge e3 = hasEdge(e1.nodeTwo,e2.nodeTwo);
					if(e3 != null) {
						if(e3.nodeOne == e3.nodeTwo) continue;
						this.triangles.add(new Triangle(e1,e2,e3));
					//	System.out.println(new Triangle(e1,e2,e3)); 
						}
				}
			}
		}

		return this.triangles;
	}
	
	
	public List<Triangle> smartListTriangles(){
		
		return this.triangles;
	}
	
	
	// returns an Edge object if there is an edge between node one and two, else returns null
	private Edge hasEdge (int one, int two) {
		ArrayList<Pair> neighbors = this.graph.get(one);
		for(int i = 0; i < neighbors.size(); i++) {
			if(neighbors.get(i).node == two) {
				return new Edge(one,two,neighbors.get(i).weight);
			}
		}
		return null;
	}
	
	
	// checks is (i,j), (j,k), and (k,i) all three are in E -- if yes: then a new triangle is added to the list of triangles, else 
	// do nothing
	private void checkTriangle(int i, int j, int k) {
		
	
	//	System.out.println(i + ", " + j + ", " + k);
		
		List<Pair> iList = this.graph.get(i);
		List<Pair> jList = this.graph.get(j);
		List<Pair> kList = this.graph.get(k);
		
		if(hasNode(iList,j) && hasNode(jList,k) && hasNode(kList,i)) {
		//	System.out.println("YESSSS");
			this.triangles.add(new Triangle(new Edge(i,j,getWeight(j,iList)),new Edge(j,k,getWeight(k,jList)),new Edge(k,i,getWeight(i,kList))));
		}
	}
	
	
	private boolean hasNode(List<Pair> list, int a) {
		
		for(Pair p : list) {
			if(p.node == a) {
			//	System.out.println("YESSSS");
				return true;
			}
		}
		return false;
	}
	
	private double getWeight(int node, List<Pair> list) {
		for(Pair p : list) {
			if(p.node == node)
				return p.weight;
		}
		return 0.0;
	}
}
