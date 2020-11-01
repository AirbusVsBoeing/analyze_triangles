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
		for(int i = 0; i < graph.size(); i++) {
			HashMap<Integer,Double> row = graph.get(i);
			System.out.print("Node " + i + ":");
			for(int j : row.keySet()) {
				System.out.print("("+j+", "+row.get(j)+")");
			}
			System.out.println("");
		}
	
	
	}
	
	
	public Graph readMatrix(String fileName) { 
		
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
		    for(int i = 0; i < lines.size(); i++) {
		    	String[] row = lines.get(i).split(",");
		    	if(i == 0) {
		    		this.graph = new Graph(row.length-1);
		    //		for(int k = 0; k < graph.size(); k++) {
		    // 			graph.add(new HashMap<Integer,Double>());
		    //			System.out.println("added"); }
		    		continue;
		    	}
		    	for(int j = 0; j < row.length-1; j++) {
		    		if(Integer.parseInt(row[j+1]) != 0) {
		    			System.out.println(Double.parseDouble(row[j]));
		    			graph.get(j).put(j, Double.parseDouble(row[j]));
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
