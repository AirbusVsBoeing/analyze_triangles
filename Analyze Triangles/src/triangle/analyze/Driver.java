package triangle.analyze;


import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;


public class Driver {

	private Graph graph; 
	
	
	
	public static void main(String[] args) {
		Driver d = new Driver();
		d.readMatrix("src/triangle/analyze/LONDON_GANG.csv");
	
	}
	
	// TODO: map node id's from X to 0,1,2,... 
	public Graph readMatrix(String fileName) { 
		
		graph = new Graph();
		
		try {
			List<String> lines = Files.readAllLines(Paths.get(fileName));
		    for(int i = 0; i < lines.size(); i++) {
		    	String[] row = lines.get(i).split(",");
		    	if(i == 0) {
		    		
		    	}
		    	
		    }
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	

	
}
