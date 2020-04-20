int[] fontColor = {0, 0, 0};
int fontSize = 80;


Puzzle puzzle = new Puzzle();

void setup() {
  size(1200, 880);
  //boolean[][][] possibilityArray = getPossibilityArray(puzzle1);
  //printArray(possibilityArray[2][2]);
  puzzle.setPuzzle(puzzle69);
  printArray(puzzle.getPossibilities(2, 2));
}

void draw() {
  background(255);
  drawGrid();
  drawPuzzle(puzzle.getPuzzle(), fontColor, fontSize);
  //
  delay(500);
  puzzle.solve();
  println(puzzle.getPuzzleSum());
}

void drawGrid() {
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

int[][] drawPuzzle(int[][] puzzle, int[] fontColor, int fontSize) {
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
  return puzzle;
}

/*void updatePuzzle() {
}

boolean[][][] getPossibilityArray(int[][] puzzle) {
  boolean[][][] possibilityArray = { //always assume everything is possible ;)
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}, 
    {{true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}, {true, true, true, true, true, true, true, true, true}}};

  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 9; x++) {
      if (puzzle[y][x] == 0) { //if the space is blank, check for numbers on row, column, and square; otherwise give no possibilities
        //look for numbers left and right
        for (int rowSearch = 0; rowSearch < 9; rowSearch++) {
          if (puzzle[y][rowSearch] != 0) { //if the space is filled, note down the number and cross it off as a possiblity
            possibilityArray[y][x][puzzle[y][rowSearch] - 1] = false;
          }
        }
        //look for numbers above and below
        for (int columnSearch = 0; columnSearch < 9; columnSearch++) {
          if (puzzle[columnSearch][x] != 0) { //if the space is filled, note down the number and cross it off as a possiblity
            possibilityArray[y][x][puzzle[columnSearch][x] - 1] = false;
          }
        }
        //look for numbers in 3x3 box
        int[] box = {y/3, x/3}; //coordinates of box - 0 through 2 for both y and x
        for (int boxSearchY = box[0]*3; boxSearchY < box[0]*3 + 3; boxSearchY++) {
          for (int boxSearchX = box[1]*3; boxSearchX < box[1]*3 + 3; boxSearchX++) {
            if (puzzle[boxSearchY][boxSearchX] != 0) {
              possibilityArray[y][x][puzzle[boxSearchY][boxSearchX] - 1] = false;
            }
          }
        }
      } else {
        possibilityArray[y][x] = new boolean[]{false, false, false, false, false, false, false, false, false}; //if the space has already been solved, fill with no possibilities
      }
    }
  }
  return possibilityArray;
}*/
