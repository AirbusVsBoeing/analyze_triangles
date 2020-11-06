package triangle.analyze;


import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.HashMap;


public class Driver {

	private Graph graph; 
	private HashMap<String,Integer> edgeMappings;
	private int newNum;
	
	
	
	public static void main(String[] args) {
		Driver d = new Driver();
		Graph graph = d.readEdgeList("src/triangle/analyze/datasets/bus_data/hbn.txt");
	
		
	/*	TriangleOps triOps = new TriangleOps(graph);
		List<Triangle> triangles = triOps.listTriangles();
		
		System.out.println("Number of Triangles:" + triangles.size());
		
		for (Triangle triangle : triangles) {
			System.out.println(triangle);
		} 
		
		printTriangleDistribution(triangles); */
		
		
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
					System.out.println(row[0] + ": " + newNum);
				}
			}
			
			for(String s : this.edgeMappings.keySet());
				//System.out.println(s + ": " + this.edgeMappings.get(s));
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return this.graph;
	}
	
	
	
	
	

	
}
