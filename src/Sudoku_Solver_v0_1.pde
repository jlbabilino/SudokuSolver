/* Sudoku Solver by Justin Babilino 
 This is a project that I worked on in the summer of 2019. This program can solve
 very easy to easy level sudokus currently (hopefully harder ones soon). 
 */

int[] fontColor = {0, 0, 0};
int fontSize = 80;

Puzzle puzzle = new Puzzle();
Board board = new Board(fontColor, fontSize);

void setup() {
  size(1200, 880);
  puzzle.set(vol201[26]);
  printArray(puzzle.getCandidateArray()[1][8]);
}
void draw() {
  background(255);
  board.drawBoard();
  board.drawPuzzle(puzzle.getPuzzle());
  if (board.checkButtons() == 2) {
    puzzle.solve();
  }
}
