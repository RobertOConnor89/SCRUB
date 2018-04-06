import edu.princeton.cs.algs4.WeightedQuickUnionUF;
import edu.princeton.cs.algs4.StdIn;
import edu.princeton.cs.algs4.StdOut;
import edu.princeton.cs.algs4.StdRandom;


public class Percolation {
	// percolation API for week 1 programming assignment
	public Percolation(int N) { //Creates a new nxn array with all entries set to zero
		int[][] A = new int[N][N];
	}
	public void open(int row, int col) { //opens the site located in position (row, col)
		
	}
	public boolean isOpen(int row, int col) { //returns true if (row, col) is open
		return true;
	}
	public boolean isFull(int row, int col) { // returns true if (row, col) is Full
		return true;
	}
	public int numberofOpenSites() {
		return 0;
	}
	public boolean percolates() {
		return true;
	}
	public static void main() {
		// TODO Auto-generated method stub
		int n = 2;
		Percolation perc = new Percolation(n);
		System.out.println(perc);
	}
	

}
