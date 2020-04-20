import static processing.core.PApplet.*;

public class Puzzle {
  public int[][] puzzle;
  Puzzle() {
    puzzle = new int[][]{
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}};
  }
  public void setPuzzle(int[][] newPuzzle) {
    puzzle = newPuzzle;
  }
  public int[][] getPuzzle() {
    return puzzle;
  }
  public void clear() {
    puzzle = new int[][]{
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}, 
      {0, 0, 0, 0, 0, 0, 0, 0, 0}};
  }
  private void setNumber(int x, int y, int val) {
    int constrainedX = constrain(x, 0, 8);
    int constrainedY = constrain(y, 0, 8);
    int constrainedVal = constrain(val, 0, 8);
    puzzle[constrainedY][constrainedX] = constrainedVal;
  }
  public int getNumber(int x, int y) {
    int constrainedX = constrain(x, 0, 8);
    int constrainedY = constrain(y, 0, 8);
    return puzzle[constrainedY][constrainedX];
  }
  public boolean[] getPossibilities(int x, int y) {
    boolean[] possibilities = {true, true, true, true, true, true, true, true, true};
    int constrainedX = constrain(x, 0, 8);
    int constrainedY = constrain(y, 0, 8);

    if (puzzle[constrainedY][constrainedX] == 0) { // if the space is blank, check for numbers on row, column, and square; otherwise give no possibilities
      //look for numbers on row
      for (int rowSearch = 0; rowSearch < 9; rowSearch++) {
        if (puzzle[constrainedY][rowSearch] != 0) { //if the space is filled, note down the number and cross it off as a possiblity
          possibilities[puzzle[constrainedY][rowSearch] - 1] = false;
        }
      }
      //look for numbers above and below
      for (int columnSearch = 0; columnSearch < 9; columnSearch++) {
        if (puzzle[columnSearch][constrainedX] != 0) { //if the space is filled, note down the number and cross it off as a possiblity
          possibilities[puzzle[columnSearch][constrainedX] - 1] = false;
        }
      }
      //look for numbers in 3x3 box
      int[] box = {constrainedY/3, constrainedX/3}; //coordinates of box - 0 through 2 for both y and x
      for (int boxSearchY = box[0]*3; boxSearchY < box[0]*3 + 3; boxSearchY++) {
        for (int boxSearchX = box[1]*3; boxSearchX < box[1]*3 + 3; boxSearchX++) {
          if (puzzle[boxSearchY][boxSearchX] != 0) {
            possibilities[puzzle[boxSearchY][boxSearchX] - 1] = false;
          }
        }
      }
    } else {
      possibilities = new boolean[]{false, false, false, false, false, false, false, false, false}; //if the space has already been solved, fill with no possibilities
    }
    return possibilities;
  }
  private void runStrategy(int strategy) {
    switch (strategy) {
    case 0:
      nakedSingle();
      break;
    case 1:
      break;
    default:
      break;
    }
  }
  private boolean nakedSingle() {
    boolean success = false;
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        int totalPossibilities = 0;
        boolean[] possibilities = getPossibilities(x, y);
        int firstNumber = 0;
        for (int possibilitySearch = 0; possibilitySearch < 9; possibilitySearch++) {
          if (possibilities[possibilitySearch] == true) {
            totalPossibilities++;
            firstNumber = possibilitySearch + 1;
          }
        }
        if (totalPossibilities == 1) {
          puzzle[y][x] = firstNumber;
          success = true;
        }
      }
    }
    return success;
  }
  private boolean hiddenSingle() {
    boolean success = false;
    // rows
    for (int row = 0; row < 9; row++) {
      int[][] rowPossibilities = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}}; //{count of numbers of same possibility, square of which the last was found on} the index of the main part cooresponds to a different number possibility
      for (int rowSearch = 0; rowSearch < 9; rowSearch++) {
        boolean[] possibilities = getPossibilities(rowSearch, row);
        for (int possibilitySearch = 0; possibilitySearch < 9; possibilitySearch++) {
          if (possibilities[possibilitySearch] == true) {
            rowPossibilities[possibilitySearch][0]++;
            rowPossibilities[possibilitySearch][1] = rowSearch;
          }
        }
      }
      for (int rowPossibilitySearch = 0; rowPossibilitySearch < 9; rowPossibilitySearch++) {
        if (rowPossibilities[rowPossibilitySearch][0] == 1) {
          puzzle[row][rowPossibilities[rowPossibilitySearch][1]] = rowPossibilitySearch + 1;
          success = true;
        }
      }
    }
    // columns
    for (int column = 0; column < 9; column++) {
      int[][] columnPossibilities = {{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}};
      for (int columnSearch = 0; columnSearch < 9; columnSearch++) {
        boolean[] possibilities = getPossibilities(column, columnSearch);
        for (int possibilitySearch = 0; possibilitySearch < 9; possibilitySearch++) {
          if (possibilities[possibilitySearch] == true) {
            columnPossibilities[possibilitySearch][0]++;
            columnPossibilities[possibilitySearch][1] = columnSearch;
          }
        }
      }
      for (int columnPossibilitySearch = 0; columnPossibilitySearch < 9; columnPossibilitySearch++) {
        if (columnPossibilities[columnPossibilitySearch][0] == 1) {
          puzzle[columnPossibilities[columnPossibilitySearch][1]][column] = columnPossibilitySearch + 1;
          success = true;
        }
      }
    }
    // 3x3 box
    for (int boxY = 0; boxY < 3; boxY++) {
      for (int boxX = 0; boxX < 3; boxX++) {
        int[/*number*/][/*{total possibilities, last x, last y}*/] boxPossibilities = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
        for (int boxSubY = 0; boxSubY < 3; boxSubY++) {
          for (int boxSubX = 0; boxSubX < 3; boxSubX++) {
            boolean[] possibilities = getPossibilities(boxX*3 + boxSubY, boxY*3 + boxSubY);
            for (int possibilitySearch = 0; possibilitySearch < 9; possibilitySearch++) {
              if (possibilities[possibilitySearch] == true) {
                boxPossibilities[possibilitySearch][0]++;
                boxPossibilities[possibilitySearch][1] = boxSubX;
                boxPossibilities[possibilitySearch][2] = boxSubY;
              }
            }
          }
        }
        for (int boxPossibilitySearch = 0; boxPossibilitySearch < 9; boxPossibilitySearch++) {
          if (boxPossibilities[boxPossibilitySearch][0] == 1) {
            puzzle[boxY*3 + boxPossibilities[boxPossibilitySearch][2]][boxX*3 + boxPossibilities[boxPossibilitySearch][1]] = boxPossibilitySearch + 1;
            success = true;
          }
        }
      }
    }
    return success;
  }

  public void solve() {
    while (nakedSingle() == true) {
      println("true");
    }
    while (hiddenSingle() == true) {
      println("true");
    }
  }
  public int getPuzzleSum() {
    int total = 0;
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        total += puzzle[y][x];
      }
    }
    return total;
  }
}