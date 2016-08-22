val winningPositions = List((0,1,2), (3,4,5), (6,7,8), (0,3,6), (1,4,7), (2,5,8), (0,4,8), (2,4,6))
val players = List('X', 'O')

class Board(cells: List[Char]) {
  val grid = cells
  def checkWinner(player: Char) {
    println
    winningPositions.foreach { pos =>
      var (a, b, c) = pos
      var test = (grid(a), grid(b), grid(c))
      print(". ")
      if (test == (player, player, player)) {
        print(player)
        print(" is the winner! ")
      }
    }
  }
}

val winForX = new Board(List(
  'X', 'O', 'X',
  'O', 'O', 'X',
  'O', 'X', 'X'))

val winForO = new Board(List(
  'O', 'X', '_',
  'O', 'X', 'X',
  'O', '_', '_'))

winForX.checkWinner('X')
winForX.checkWinner('O')
winForO.checkWinner('O')