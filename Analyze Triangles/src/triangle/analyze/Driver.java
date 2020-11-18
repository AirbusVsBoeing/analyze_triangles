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
		Graph graph = d.readEdgeList("src/triangle/analyze/datasets/power-494-bus.txt");
		
		TriangleOps to = new TriangleOps(graph);
		List<Triangle> triangles = to.listTrianglesE();
		
		System.out.println("Num Vertices:" + graph.size());
		System.out.println("Num Edges:" + graph.edges.size());
		System.out.println("Num Triangles:" + triangles.size());
		
		/*List<Edge> edges = graph.edges;
		for(int i = 0; i < edges.size();i++) {
			Edge current = edges.get(i);
			for(int j = i+1; j < edges.size(); j++) {
				Edge other = edges.get(j);
				if(current.equals(other)) {
					System.out.println(current);
					System.out.println(other);
					System.out.println("++++++++++");
				}
			}
		} */
		
		for(Triangle triangle : triangles)
	    	System.out.println(triangle);
	
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
		    	String[] row = lines.get(i).split("	");
		   // 	System.out.println("row.length:" + row.length);
		    //	if(i == 0) {
		    //		this.graph = new Graph(row.length-1);
		    	//	this.graph.edges = new ArrayList<Edge>();
		    //		continue;
		    //	}
		    	this.graph = new Graph(row.length);
		    	for(int j = 0; j < row.length-1; j++) {
		    		if(Double.parseDouble(row[j]) != 0.0) {
		    			edges.add(new Edge(i,j,Double.parseDouble(row[j])));
		    			this.graph.get(i).add(new Pair(j,Double.parseDouble(row[j])));
		    			//System.out.println("i:"+i+"j:"+j+"weight:"+Double.parseDouble(row[j]));
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
		
		this.graph.add(five);
		
		List<Edge> edges = new ArrayList<Edge>();
		
		edges.add(new Edge(0,1,1.0));
		edges.add(new Edge(0,2,1.0));
		edges.add(new Edge(0,3,1.0));
		edges.add(new Edge(1,2,1.0));
		edges.add(new Edge(2,3,1.0));
		edges.add(new Edge(3,4,1.0));
		edges.add(new Edge(3,5,1.0));
		edges.add(new Edge(4,5,1.0));
		
		this.graph.edges = edges; 
		
	
		return this.graph; 
		*/
		
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
				String[] row = lines.get(i).split(" ");
				if(!this.edgeMappings.containsKey(row[0])) {
					this.edgeMappings.put(row[0], newNum++);
				//	System.out.println(row[0] + ": " + (newNum-1));
				}
			}
			
			this.graph = new Graph(this.edgeMappings.size());
			
			for(int i = 0; i < lines.size(); i++) {
				String[] row = lines.get(i).split(" ");
				int idOne = this.edgeMappings.get(row[0]);
				int idTwo = this.edgeMappings.get(row[1]);
				//if(idOne == idTwo) continue;
				double weight = Double.parseDouble(row[2]);
				edges.add(new Edge(idOne,idTwo,weight));
				this.graph.get(idOne).add(new Pair(idTwo,weight));
				if(idOne != idTwo)
					this.graph.get(idTwo).add(new Pair(idOne,weight));
			
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		this.graph.edges = deleteDuplicateEdges(edges);
		return this.graph;
	}	
	
	public Graph readMtxFile(String fileName) {
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
			String[] info = lines.get(0).split(" ");
			this.graph = new Graph(Integer.parseInt(info[0]));
			this.graph.numVertices = Integer.parseInt(info[0]);
			this.graph.numEdges = Integer.parseInt(info[2]);
			for(int i = 1; i < lines.size(); i++) {
				String[] row = lines.get(i).split(" ");
				int idOne = Integer.parseInt(row[0])-1;
				int idTwo = Integer.parseInt(row[1])-1;
				double weight = Double.parseDouble(row[2]);
				//this.graph.get(idOne).put(idTwo, weight);
				this.graph.get(idOne).add(new Pair(idTwo,weight));
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return this.graph;
	}
	
}
