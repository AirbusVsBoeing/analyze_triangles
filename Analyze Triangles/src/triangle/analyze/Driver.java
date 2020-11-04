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
	
		
		TriangleOps triOps = new TriangleOps(graph);
		List<Triangle> triangles = triOps.listTriangles();
		
		for (Triangle triangle : triangles) {
			System.out.println(triangle);
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
