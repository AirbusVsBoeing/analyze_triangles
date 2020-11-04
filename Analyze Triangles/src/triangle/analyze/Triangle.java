package triangle.analyze;

import java.util.List;
import java.util.ArrayList;

public class Triangle {
	
	private Edge one, two, three;
	public String tclass;
	private double weightOne, weightTwo, weightThree;
	
	
	public Triangle(Edge one, Edge two, Edge three) {
		this.one = one;
		this.two = two;
		this.three = three;
		this.weightOne = one.weight;
		this.weightTwo = two.weight;
		this.weightThree = three.weight;
		
		this.determineClass();
		
	}
	
	private void determineClass() {
		
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
		
		else if(weightOne < avg && weightTwo < avg && weightThree >= avg)
			this.tclass = TriangleClass.LLH;
		
		else if(weightTwo < avg && weightThree < avg && weightOne >= avg)
			this.tclass = TriangleClass.LLH;
		
		else if(weightOne < avg && weightThree < avg && weightTwo >= avg)
			this.tclass = TriangleClass.LLH;
		
		else if(weightOne > avg && weightTwo > avg && weightThree <= avg)
			this.tclass = TriangleClass.HHL;
		
		else if(weightTwo > avg && weightThree > avg && weightOne <= avg)
			this.tclass = TriangleClass.HHL;
		
		else this.tclass = TriangleClass.HHL;
				
	}
	
	@Override
	public String toString() {
		return "Class: " + this.tclass + "\n" +one.nodeOne + "-----" + one.weight + "-----" + one.nodeTwo + "\n" + two.nodeOne + "-----" + two.weight + "-----" + two.nodeTwo + "\n" + three.nodeOne + "-----" + three.weight + "-----" + three.nodeTwo + "\n" + "++++++++++++++++++++";
	}
	
}
