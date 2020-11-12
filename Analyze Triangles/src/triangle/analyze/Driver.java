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
	
	
	
	public static void main(String[] args) {
		Driver d = new Driver();
		Graph graph = d.readMatrix("src/triangle/analyze/datasets/London_Gangs/LONDON_GANG.csv");
	/*	for(int i = 0; i < graph.size(); i++) {
			System.out.print("Node: " + i + "-> ");
			for(int neighbor : graph.get(i).keySet()) {
				System.out.print("("+neighbor+", " + graph.get(i).get(neighbor) + "), ");
			}
			System.out.println("");
		} */
	
		
	TriangleOps triOps = new TriangleOps(graph);
		
		List<Triangle> triangles = triOps.listTriangles();
		
		printTriangleDistribution(triangles);
		
		
		
		
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
		
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
		    for(int i = 0; i < lines.size(); i++) {
		    	String[] row = lines.get(i).split(",");
		    	if(i == 0) {
		    		this.graph = new Graph(row.length-1);
		    		continue;
		    	}
		    	for(int j = 1; j < row.length-1; j++) {
		    		if(Double.parseDouble(row[j]) != 0.0) {
		    			graph.get(i-1).put(j-1, Double.parseDouble(row[j]));
		    		}
		    	}
		    	
		    }
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return this.graph;
	}
	
	
	public Graph readEdgeList(String fileName){
		
		this.newNum = 0;
		this.edgeMappings = new HashMap<String,Integer>();
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
			for(int i = 1; i < lines.size(); i++) {
				String[] row = lines.get(i).split("	");
				if(!this.edgeMappings.containsKey(row[0])) {
					this.edgeMappings.put(row[0], newNum++);
					//System.out.println(row[0] + ": " + newNum);
				}
			}
			
			this.graph = new Graph(this.edgeMappings.size());
			
			for(String s : this.edgeMappings.keySet());
				//System.out.println(s + ": " + this.edgeMappings.get(s));
			//	String[] info =lines.get(0).split(" ");
			//	this.graph.numVertices = Integer.parseInt(info[0]);
			//	this.graph.numEdges = Integer.parseInt(info[2]);
				
			for(int i = 1; i < lines.size(); i++) {
				String[] row = lines.get(i).split("	");
				for(int j = 0; j < row.length; ++j);
					//System.out.println(row[j] + "," +j);
				int idOne = this.edgeMappings.get(row[0]);
				int idTwo = this.edgeMappings.get(row[1]);
				double weight = Double.parseDouble(row[2]);
				this.graph.get(idOne).put(idTwo, weight); 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
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
				this.graph.get(idOne).put(idTwo, weight);
				
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return this.graph;
	}
	
}
