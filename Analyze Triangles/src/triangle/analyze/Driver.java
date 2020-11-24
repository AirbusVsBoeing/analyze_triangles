package triangle.analyze;


import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;


public class Driver {

	private Graph graph; 
	private HashMap<String,Integer> edgeMappings;
	private int newNum;
	
	
	
	public static void main(String[] args) throws Exception {
		Driver d = new Driver();
		Graph graph = d.readEdgeList("src/triangle/analyze/datasets/bus-data/abn.txt");
		
		TriangleOps to = new TriangleOps(graph);
		List<Triple> triples = to.forward();
		List<Triangle> triangles = getTriangles(triples,to.edges);
		
		System.out.println("Num vertices: " + graph.size());
		System.out.println("Num edges:" + graph.edges.size());
		
		System.out.println("num triangles:" + triangles.size());
		
		printTriangleDistribution(triangles);
		//System.out.println("num triples:" + triples.size()); 
		
		
		
			
	}
	
	
	private static List<Triangle> getTriangles(List<Triple> triples, List<Edge> edges){
		
		List<Edge> tri = new ArrayList<Edge>();
		List<Triangle> triangles = new ArrayList<Triangle>();
		
		for(Triple triple : triples) {
			
			for(Edge e : edges) {
				if((e.nodeOne == triple.a && e.nodeTwo == triple.b) || (e.nodeOne == triple.b && e.nodeTwo == triple.a)) {
					tri.add(e);
				//	System.out.println(e + " / triple.a:" + triple.a + ", " + "triple.b:" + triple.b);
				}
				if((e.nodeOne == triple.b && e.nodeTwo == triple.c) || (e.nodeOne == triple.c && e.nodeTwo == triple.b)) {
					tri.add(e);
				}
				if((e.nodeOne == triple.a && e.nodeTwo == triple.c) || (e.nodeOne == triple.c && e.nodeTwo == triple.a)) {
					tri.add(e);
				}
					
			}
			if(tri.size() == 3) {
				triangles.add(new Triangle(tri.get(0),tri.get(1),tri.get(2)));
				
			}
			tri.clear();
		}
		return triangles;
	}
	

	
	public static void printTriangleDistribution(List<Triangle> triangles) {
		int EEE=0,EEL=0,EEH=0,HHL=0,LLH=0;
		
		for(Triangle triangle : triangles) {
			if (triangle.tclass.equals(TriangleClass.EEE))
				++EEE;
			else if (triangle.tclass.equals(TriangleClass.EEH))
				++EEH;
			else if (triangle.tclass.equals(TriangleClass.EEL))
				++EEL;
			else if (triangle.tclass.equals(TriangleClass.HHL))
				++HHL;
			else if (triangle.tclass.equals(TriangleClass.LLH))
				++LLH;
			
		}
		System.out.println(TriangleClass.EEE + ":" + EEE + "\n" + TriangleClass.EEH + ":" + EEH + "\n" + TriangleClass.EEL + ":" + EEL + "\n" + TriangleClass.HHL + ":" + HHL + "\n" + TriangleClass.LLH + ":" + LLH + "\n");
	}
	
	
	public Graph readMatrix(String fileName) { 
		
		
		List<Edge> edges = new ArrayList<Edge>();
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
		    for(int i = 0; i < lines.size(); i++) {
		    	String[] row = lines.get(i).split(",");
		   // 	System.out.println("row.length:" + row.length);
		    	if(i == 0) {
		    		this.graph = new Graph(row.length-1);
		    		this.graph.edges = new ArrayList<Edge>();
		    		continue;
		    	}
		    	//this.graph = new Graph(row.length);
		    	for(int j = 1; j < row.length-1; j++) {
		    		if(Double.parseDouble(row[j]) != 0.0) {
		    			edges.add(new Edge(i-1,j-1,Double.parseDouble(row[j])));
		    			this.graph.get(i-1).add(new Pair(j-1,Double.parseDouble(row[j])));
		    		}
		    	}
		    	
		    }
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		this.graph.edges = deleteDuplicateEdges(edges);
		return this.graph;   
		
	/*	this.graph = new Graph(6);
	
		
		
		ArrayList<Pair> zero = new ArrayList<Pair>();
		zero.add(new Pair(1,1.0));
		zero.add(new Pair(2,1.0));
		zero.add(new Pair(3,1.0));
		
		this.graph.add(zero);
		
		ArrayList<Pair> one = new ArrayList<Pair>();
		one.add(new Pair(0,1.0));
		one.add(new Pair(2,1.0));
		
		
		this.graph.add(one);
		
		ArrayList<Pair> two = new ArrayList<Pair>();
		two.add(new Pair(0,1.0));
		two.add(new Pair(1,1.0));
		two.add(new Pair(3,1.0));
		two.add(new Pair(5,1.0));
		
		this.graph.add(two);
		
		ArrayList<Pair> three = new ArrayList<Pair>();
		three.add(new Pair(0,1.0));
		three.add(new Pair(2,1.0));
		three.add(new Pair(4,1.0));
		three.add(new Pair(5,1.0));
		
		this.graph.add(three);
		

		ArrayList<Pair> four = new ArrayList<Pair>();
		four.add(new Pair(3,1.0));
		four.add(new Pair(5,1.0));
		
		this.graph.add(four);
		

		ArrayList<Pair> five = new ArrayList<Pair>();
		five.add(new Pair(3,1.0));
		five.add(new Pair(4,0.0));
		five.add(new Pair(2,1.0));
		
		this.graph.add(five);
		
		List<Edge> edges = new ArrayList<Edge>();
		
		edges.add(new Edge(0,1,1.0));
		edges.add(new Edge(0,2,1.0));
		edges.add(new Edge(0,3,1.0));
		edges.add(new Edge(1,2,1.0));
		edges.add(new Edge(2,3,1.0));
		edges.add(new Edge(2,5,1.0));
		edges.add(new Edge(3,4,1.0));
		edges.add(new Edge(3,5,1.0));
		edges.add(new Edge(4,5,1.0));
		
		this.graph.edges = edges; 
		
	
		return this.graph; */
		
		
	}
	
	private List<Edge> deleteDuplicateEdges(List<Edge> list){
		
		for(int i = 0; i < list.size(); i++) {
			for(int j = 0; j < list.size(); j++) {
				if(i == j) continue;
				if(list.get(i).equals(list.get(j)))
					list.remove(j);
			}
		}
		return list;
	}
	
	
	public Graph readEdgeList(String fileName){
		
 		this.newNum = 0;
		this.edgeMappings = new HashMap<String,Integer>();
		List<Edge> edges = new ArrayList<Edge>();
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
			for(int i = 0; i < lines.size(); i++) {
				String[] row = lines.get(i).split("  ");
				if(!this.edgeMappings.containsKey(row[0])) {
					this.edgeMappings.put(row[0], newNum++);
				
				}
			}
			
			this.graph = new Graph(this.edgeMappings.size());
			
			for(int i = 0; i < lines.size(); i++) {
				String[] row = lines.get(i).split("	");
				int idOne = this.edgeMappings.get(row[0]);
				if(row[0].equals("")) {
					break;
				}
				//int idOne = Integer.parseInt(row[0]);
				int idTwo = this.edgeMappings.get(row[1]);
				//int idTwo = Integer.parseInt(row[1]);
				double weight = Double.parseDouble(row[2]);
				edges.add(new Edge(idOne,idTwo,weight));
				
				this.graph.get(idOne).add(new Pair(idTwo,weight));
			//	if(idOne != idTwo)
			//		this.graph.get(idTwo).add(new Pair(idOne,weight));
			
			}
			
		}
		catch(Exception e) {
			System.out.println("Yes it's an exception! -- exiting!");
			e.printStackTrace();
			System.exit(-1);
		}
		
		this.graph.edges = deleteDuplicateEdges(edges);
		return this.graph;
	}	
	
	
}
