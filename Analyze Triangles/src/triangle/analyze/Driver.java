package triangle.analyze;


import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.HashMap;


public class Driver {

	private Graph graph; 
	
	
	
	public static void main(String[] args) {
		Driver d = new Driver();
		Graph graph = d.readMatrix("src/triangle/analyze/LONDON_GANG.csv");
	/*	for(int i = 0; i < graph.size(); i++) {
			HashMap<Integer,Double> row = graph.get(i);
			System.out.print("Node " + i + ":");
			for(int j : row.keySet()) {
				System.out.print("("+j+", "+row.get(j)+")");
			} 
			System.out.println(""); 
		} */
		
		System.out.println(graph.size());
		
		Triangle triangle = new Triangle(graph);
		List<List<Edge>> triangles = triangle.listTriangles();
		System.out.println("Number of Triangles:" + triangles.size());
		
		for(int i = 0; i < triangles.size(); i++) {
			List<Edge> tri = triangles.get(i);
			for(int j = 0; j < tri.size(); j++) {
				System.out.println(tri.get(j));
			}
			System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
		}
		
	
	
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
		    		//	System.out.println(Double.parseDouble(row[j+1]));
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
	
	
	

	
}
