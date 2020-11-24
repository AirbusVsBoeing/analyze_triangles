package triangle.analyze;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Collections;

public class TriangleOps {
	
	public Graph graph;
	public List<Triangle> triangles;
	public List<Edge> edges;
	List<Node> sortedNodes; 
	List<ArrayList<Node>> arr;
	HashMap<Integer,Integer> nodeMappings;
	List<Triple> triples;
	

	
	public TriangleOps(Graph graph) {
		this.graph = graph;
		this.edges = graph.edges;
	
		this.triangles = new ArrayList<Triangle>();
		this.sortedNodes = new ArrayList<Node>();
		for(int i = 0; i < graph.size(); i++)
			this.sortedNodes.add(new Node(i,graph.get(i).size(),graph.get(i)));
		Collections.sort(sortedNodes);
		this.nodeMappings = new HashMap<Integer,Integer>();
		for(int i = 0; i < sortedNodes.size(); i++)
			nodeMappings.put(sortedNodes.get(i).id, i);
			
		this.arr = new ArrayList<ArrayList<Node>>(graph.size());
		for(int i = 0; i < graph.size(); i++)
			this.arr.add(new ArrayList<Node>());
		
		this.triples = new ArrayList<Triple>();
		
	}
	
	// naive O(n^3) time triangle listing algorithm
	
	public List<Triangle> listTriangles(){
		
		
		
		for(int i = 0; i < this.sortedNodes.size(); i++) {
		
			for(int j = 0; j < this.sortedNodes.size(); j++) {
		
				if(i==j) continue;
				
				for(int k = 0; k < this.sortedNodes.size();k++) {
					if(j==k || k == i) continue;
					checkTriangle(i,j,k);
				}
			}
		}
	
		return this.triangles;
	}
	
	
	public List<Triple> forward(){
		
	
		
		for(Node v : sortedNodes) {
			List<Pair> nV = v.neighbors;
			

			for(Pair u : nV) {
							
				if(this.nodeMappings.get(u.node) > this.nodeMappings.get(v.id)) {
					List<Node> intersection = computeIntersection(arr.get(u.node),arr.get(v.id));
					for(Node w : intersection) {
						this.triples.add(new Triple(u.node,v.id,w.id));
					}
					this.arr.get(u.node).add(v);
 				}
			}
		}
		
		
		return this.triples;
	}
	
	
	public List<Node> computeIntersection(ArrayList<Node> a, ArrayList<Node> b){
		
	
		
		List<Node> intersection = new ArrayList<Node>();
		int i = 0, j = 0;
		
		Collections.sort(a,Collections.reverseOrder());
		Collections.sort(b,Collections.reverseOrder());
		
		
		

		
		while(i != a.size() && j != b.size()) {
			if(a.get(i).id == b.get(j).id) {
				intersection.add(a.get(i));
				i++;
				j++;
			}
			else if(a.get(i).id > b.get(j).id)
				++j;
			else
				++i;
		}
		
		
		
		return intersection;
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
						}
				}
			}
		}

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
	public boolean checkTriangle(int i, int j, int k) {
		
		
		List<Pair> iList = this.graph.get(i);
		List<Pair> jList = this.graph.get(j);
		List<Pair> kList = this.graph.get(k);
		
		if(hasNode(iList,j) && hasNode(jList,k) && hasNode(kList,i)) {
			//this.triangles.add(new Triangle(new Edge(i,j,getWeight(j,iList)),new Edge(j,k,getWeight(k,jList)),new Edge(k,i,getWeight(i,kList))));
			return true;
		}
		return false;
	}
	
	
	private boolean hasNode(List<Pair> list, int a) {
		
		for(Pair p : list) {
			if(p.node == a) {
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
