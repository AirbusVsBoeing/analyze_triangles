package triangle.analyze;

import java.util.List;
import java.util.ArrayList;

public class Triangle {
	
	public Edge one, two, three;
	public String tclass;
	public double weightOne, weightTwo, weightThree;
	
	public int nodeOne, nodeTwo, nodeThree;
	
	
	public Triangle(Edge one, Edge two, Edge three) {
		this.one = one;
		this.two = two;
		this.three = three;
		this.weightOne = one.weight;
		this.weightTwo = two.weight;
		this.weightThree = three.weight;
		
		
		
		this.determineClass();
		
	}
	
	private void determineClass(){
		
		double avg = (weightOne+weightTwo+weightThree)/3;
		
		if(weightOne == weightTwo && weightTwo == weightThree && weightThree == weightOne)
			this.tclass = TriangleClass.EEE;
		
		else if(weightOne == weightTwo && weightTwo > weightThree)
			this.tclass = TriangleClass.EEL;
		
		else if(weightOne == weightThree && weightThree > weightTwo)
			this.tclass = TriangleClass.EEL;
		
		else if(weightTwo == weightThree && weightThree > weightOne)
			this.tclass = TriangleClass.EEL;
		
		else if(weightOne == weightTwo && weightThree > weightTwo)
			this.tclass = TriangleClass.EEH;
		
		else if(weightOne == weightThree && weightTwo > weightThree)
			this.tclass = TriangleClass.EEH;
		
		else if(weightTwo == weightThree && weightOne > weightThree)
			this.tclass = TriangleClass.EEH;
		
		else if((weightOne != weightTwo) && (weightOne < avg && weightTwo < avg) && weightThree >= avg)
			this.tclass = TriangleClass.LLH;
		
		else if((weightTwo != weightThree) && (weightTwo < avg && weightThree < avg) && weightOne >= avg)
			this.tclass = TriangleClass.LLH;
		
		else if((weightOne != weightThree) && (weightOne < avg && weightThree < avg) && weightTwo >= avg)
			this.tclass = TriangleClass.LLH;
		
		else if((weightOne != weightTwo) && (weightOne >= avg && weightTwo >= avg) && weightThree < avg)
			this.tclass = TriangleClass.HHL;
		
		else if((weightTwo != weightThree) && (weightTwo >= avg && weightThree >= avg) && weightOne < avg)
			this.tclass = TriangleClass.HHL;
		
		else if((weightOne != weightThree) && (weightOne >= avg && weightThree >= avg) && weightTwo < avg)
			this.tclass = TriangleClass.HHL;
		
		else {
			System.out.println("Unable to determine class");
		}		
	}
	
	@Override
	public String toString() {
		return "Class: " + this.tclass + "\n" +one.nodeOne + "-----" + one.weight + "-----" + one.nodeTwo + "\n" + two.nodeOne + "-----" + two.weight + "-----" + two.nodeTwo + "\n" + three.nodeOne + "-----" + three.weight + "-----" + three.nodeTwo + "\n" + "++++++++++++++++++++";
	}
	
	@Override 
	public boolean equals(Object obj) {
		Triangle t2 = (Triangle) obj;
		if(this.one == t2.one && this.two == t2.two && this.three == t2.three)
			return true;
		
		return false;
	}
	
}
