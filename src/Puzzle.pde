/* This class is the brains behind this program. Here is a broken down explanation:

  1. Puzzles are defined as 2D, 9x9 integer arrays that contain numbers from 0 to 9.
0 corresponds to a blank cell, and 1 through 9 correspond to a filled in cell.

2. The "Puzzle" class contains its own universal "puzzle" which starts out blank and is modified
throught the process of solving. It can be set during construction or with the method
"setPuzzle()".

3. The solving process can be broken down as follows:

  a. The "Puzzle" class contains a 9x9x9 boolean array called "candidateArray".
  The first and second dimensions correspond to the column and row on the sudoku grid,
  and the third dimension contains the candidates arrays. For each cell, the candidate
  array describes what the possible digits can be for that cell based on the digits around
  it. The position on the candidate array corresponds to a specific digit, for example if position
  [4] on the array is true, then 4 is a possible value of the cell. If [3] is false, then 3
  cannot be a value for that cell. The global "candidateArray" starts out with every candidate
  possible and options are eliminated throughout the process. A candidate array can be
  updated by scanning the cells around it and eliminating candidates that are already
  in the row, column or box. Puzzle contains four different methods for updating candidates:
  
    i. "updateCandidates(int x, int y)" This method updates the candidate array for one
    specific cell. It is used by the next two methods
    
    ii. "updateCandidates()" This method updates the candidate arrays for every cell
    int the entire grid. It is used after the entire board is set
    
    iii. "updateVisibleCandidates(int x, int y)" This method updates the candidate arrays
    for a specific cell and all the cells in its same row, column, and box. This is
    used after a specific cell is set because it only updates the cells that it needs to.
  
  b. There are several "strategies" that can be used to rule out candidates and solve
  the puzzle. I have only currently implemented two:
    
    i. "nakedSingles()" This strategy looks for cells that only have one candidate, and
    if there is only one then the cell will be set to the value of the candidate.
    
    ii. "hiddenSingles()" This strategy looks for cells that are the only cells to have
    a certain candidate in a row, column or box. If it is confirmed that the cell is
    the only cell to have a specific candidate, then the cell will be replaced with
    the value of the candidate.
    
    I plan on adding "nakedPairs" which looks for pairs of cells that are the only two cells
    that have a specific candidate. If they do, they can only be one of those two values,
    so any other candidates are removed.
  
  c. The "solve()" method runs each strategy once, and the new puzzle can be extracted
  and displaed to the screen. This method can be run multiple times to complete the entire
  puzzle.
  
*/
public class Puzzle {
  private int[/*y*/][/*x*/] puzzle; // this is the main puzzle used throught solving
  private boolean[/*y*/][/*x*/][/*number*/] candidateArray; // this is the 9x9 boolean array that contains candidate arrays
  public Puzzle() { // construct the puzzle without an input
    puzzle = new int[][]{ // reset puzzle 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}
    };
    candidateArray = new boolean[][][]{ // reset candidate array so that everything is possible
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}
    };
  }
  public Puzzle(int[][] puzzle) { // construct the puzzle with an input
    this.puzzle = puzzle; // set the puzzle
    candidateArray = new boolean[][][]{ // reset candidate array so that everything is possible
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
      {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}
    };
    updateCandidates(); // all the candidates must be updated or nothing will be solved
  }
  public int[][] getPuzzle() { // returns the global puzzle
    return puzzle;
  }
  public boolean[][][] getCandidateArray() {
    return candidateArray;
  }
  public void set(int x, int y, int number) {
    int constrainedX = constrain(x, 0, 8);
    int constrainedY = constrain(y, 0, 8);
    int constrainedNumber = constrain(number, 0, 9);
    this.puzzle[constrainedY][constrainedX] = constrainedNumber;
    updateVisibleCandidates(constrainedX, constrainedY);
  }
  public void set(int[][] puzzle) {
    this.puzzle = puzzle;
    updateCandidates();
  }
  private void updateCandidates(int x, int y) {
    int constrainedX = constrain(x, 0, 8); // I add this just in case someone types a number too large
    int constrainedY = constrain(y, 0, 8);
    if (puzzle[constrainedY][constrainedX] == 0) { // if the cell is blank, check for numbers on row, column, and square
      //look for numbers on row
      for (int rowSearch = 0; rowSearch < 9; rowSearch++) {
        if (puzzle[constrainedY][rowSearch] != 0) { //if the cell is filled, note down the number and remove it as a candidate
          candidateArray[constrainedY][constrainedX][puzzle[constrainedY][rowSearch] - 1] = false;
        }
      }
      //look for numbers above and below
      for (int columnSearch = 0; columnSearch < 9; columnSearch++) {
        if (puzzle[columnSearch][constrainedX] != 0) { //if the cell is filled, note down the number and cross it off as a possiblity
          candidateArray[constrainedY][constrainedX][puzzle[columnSearch][constrainedX] - 1] = false;
        }
      }
      //look for numbers in 3x3 box
      int[] box = {constrainedX/3, constrainedY/3}; //coordinates of box - 0 through 2 for both y and x
      for (int boxSearchY = box[1]*3; boxSearchY < box[1]*3 + 3; boxSearchY++) {
        for (int boxSearchX = box[0]*3; boxSearchX < box[0]*3 + 3; boxSearchX++) {
          if (puzzle[boxSearchY][boxSearchX] != 0) {
            candidateArray[constrainedY][constrainedX][puzzle[boxSearchY][boxSearchX] - 1] = false;
          }
        }
      }
    } else {
      candidateArray[constrainedY][constrainedX] = new boolean[]{false, false, false, false, false, false, false, false, false}; // if the cell has already been solved, fill with no candidates
    }
  }
  private void updateCandidates() {
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        updateCandidates(x, y);
      }
    }
  }
  private void updateVisibleCandidates(int x, int y) {
    int constrainedX = constrain(x, 0, 8);
    int constrainedY = constrain(y, 0, 8);
    for (int column = 0; column < 9; column++) {
      updateCandidates(column, constrainedY);
    }
    for (int row = 0; row < 9; row++) {
      updateCandidates(constrainedX, row);
    }
    int[] box = {constrainedX/3, constrainedY/3};

    for (int boxY = box[1]*3; boxY < box[1]*3 + 3; boxY++) {
      for (int boxX = box[0]*3; boxX < box[0]*3 + 3; boxX++) {
        updateCandidates(boxX, boxY);
      }
    }
  }
  private boolean nakedSingles() {
    boolean success = false;
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        int totalCandidates = 0;
        int firstNumber = 0;
        for (int candidateSearch = 0; candidateSearch < 9; candidateSearch++) {
          if (candidateArray[y][x][candidateSearch] == true) {
            totalCandidates++;
            firstNumber = candidateSearch + 1;
          }
        }
        if (totalCandidates == 1) {
          set(x, y, firstNumber);
          success = true;
        }
      }
    }
    return success;
  }
  private boolean hiddenSingles() {
    boolean success = false;
    for (int row = 0; row < 9; row++) {
      int[][] rowCandidates = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}}; // {times candidate has appeared, last x} index is value of candidate
      for (int rowSearch = 0; rowSearch < 9; rowSearch++) {
        for (int candidateSearch = 0; candidateSearch < 9; candidateSearch++) {
          if (candidateArray[row][rowSearch][candidateSearch] == true) {
            rowCandidates[candidateSearch][0]++;
            rowCandidates[candidateSearch][1] = rowSearch;
          }
        }
      }
      for (int rowCandidateSearch = 0; rowCandidateSearch < 9; rowCandidateSearch++) {
        if (rowCandidates[rowCandidateSearch][0] == 1) {
          set(rowCandidates[rowCandidateSearch][1], row, rowCandidateSearch + 1);
          success = true;
        }
      }
    }
    for (int column = 0; column < 9; column++) {
      int[][] columnCandidates = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}}; // {times candidate has appeared, last y} index is value of candidate
      for (int columnSearch = 0; columnSearch < 9; columnSearch++) {
        for (int candidateSearch = 0; candidateSearch < 9; candidateSearch++) {
          if (candidateArray[columnSearch][column][candidateSearch] == true) {
            columnCandidates[candidateSearch][0]++;
            columnCandidates[candidateSearch][1] = columnSearch;
          }
        }
      }
      for (int columnCandidateSearch = 0; columnCandidateSearch < 9; columnCandidateSearch++) {
        if (columnCandidates[columnCandidateSearch][0] == 1) {
          set(column, columnCandidates[columnCandidateSearch][1], columnCandidateSearch + 1);
          success = true;
        }
      }
    }
    for (int boxY = 0; boxY < 3; boxY++) {
      for (int boxX = 0; boxX < 3; boxX++) {
        int[][] boxCandidates = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}; // {times candidate has appeared, last x, last y} index is value of candidate
        for (int boxSubY = boxY*3; boxSubY < boxY*3 + 3; boxSubY++) {
          for (int boxSubX = boxX*3; boxSubX < boxX*3 + 3; boxSubX++) {
            for (int candidateSearch = 0; candidateSearch < 9; candidateSearch++) {
              if (candidateArray[boxSubY][boxSubX][candidateSearch] == true) {
                boxCandidates[candidateSearch][0]++;
                boxCandidates[candidateSearch][1] = boxSubX;
                boxCandidates[candidateSearch][2] = boxSubY;
              }
            }
          }
        }
        for (int boxCandidateSearch = 0; boxCandidateSearch < 9; boxCandidateSearch++) {
          if (boxCandidates[boxCandidateSearch][0] == 1) {
            set(boxCandidates[boxCandidateSearch][1], boxCandidates[boxCandidateSearch][2], boxCandidateSearch + 1);
            success = true;
          }
        }
      }
    }
    return success;
  }
  public void solve() {
    nakedSingles();
    hiddenSingles();
  }
}
