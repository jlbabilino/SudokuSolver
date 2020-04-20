// This class draws the Sudoku grid and draws the numbers
public class Board {
  public int[] fontColor;
  public int fontSize;

  private int solveButtonX = 850;
  private int solveButtonY = 550;
  private int solveButtonWidth = 300;
  private int solveButtonHeight = 100;

  Board() {
    fontColor = new int[]{0, 0, 0};
    fontSize = 80;
  }
  Board(int[] fontColor, int fontSize) {
    this.fontColor = fontColor;
    this.fontSize = fontSize;
  }
  public void drawBoard() { // Draws the 9x9 grid on the screen
    int spacing = height/11;
    //vertical lines
    for (int i = 1; i <= 10; i++) {
      if (i == 1 || i == 4 || i == 7 || i == 10) {
        strokeWeight(10);
      } else {
        strokeWeight(2);
      }
      line(i*spacing, 1*spacing, i*spacing, 10*spacing);
    }
    //horizontal lines
    for (int i = 1; i <= 10; i++) {
      if (i == 1 || i == 4 || i == 7 || i == 10) {
        strokeWeight(10);
      } else {
        strokeWeight(2);
      }
      line(1*spacing, i*spacing, 10*spacing, i*spacing);
    }
  }
  public void drawSolveButton(int shift, int buttonColor, boolean size) {
    if (buttonColor == 0) {
      fill(240, 150, 150);
    }
    if (buttonColor == 1) {
      fill(100, 200, 100);
    }
    strokeWeight(8);
    if (size) {
      rect(solveButtonX + shift - 3, solveButtonY + shift - 3, solveButtonWidth + 6, solveButtonHeight + 6);
    } else {
      rect(solveButtonX + shift, solveButtonY + shift, solveButtonWidth, solveButtonHeight);
    }
    fill(0);
    if (size) {
      textSize(62);
      text("Solve", solveButtonX + 78 + shift, solveButtonY + 71 + shift);
    } else {
      textSize(60);
      text("Solve", solveButtonX + 80 + shift, solveButtonY + 70 + shift);
    }
  }
  public void drawPuzzle(int[][] puzzle) { // draws a puzzle (2D integer array) on the screen
    int spacing = height/11;
    fill(fontColor[0], fontColor[1], fontColor[2]);
    textSize(fontSize);
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        if (puzzle[y][x] != 0) {
          text(puzzle[y][x], (spacing/2*3 - 9*fontSize/32)+(spacing*x), (spacing/2*3 + fontSize/12*5)+(spacing*y));
        }
      }
    }
  }
  public int checkButtons() {
    if (mouseX >= solveButtonX && mouseX <= solveButtonX + solveButtonWidth && mouseY >= solveButtonY && mouseY <= solveButtonY + solveButtonHeight) { 
      if (mousePressed) {
        drawSolveButton(0, 1, false);
        return 2;
      }
      drawSolveButton(0, 0, true);
      return 1;
    }
    drawSolveButton(0, 0, false);
    return 0;
  }
}
