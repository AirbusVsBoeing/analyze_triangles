package triangle.analyze;

public class Triple {
	
	public int a,b,c;
	
	public Triple(int a, int b, int c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}
	
	@Override
	public String toString() {
		return "(" + a + ", " + b + ", " + c + ")";
	}

}
