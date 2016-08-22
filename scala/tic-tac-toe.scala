val winningPositions = List((0,1,2), (3,4,5), (6,7,8), (0,3,6), (1,4,7), (2,5,8), (0,4,8), (2,4,6))
val players = List('X', 'O')

class Board(cells: List[Char]) {

  val grid = cells
  val numX = grid.count(_.charValue == 'X')
  val numO = grid.count(_.charValue == 'O')
  val numNull = grid.count(_.charValue == ' ')

  def checkWinner: (Boolean, Char) = {
    var returnVal = (false, ' ')
    winningPositions.foreach { pos =>
      var (a, b, c) = pos
      var test = (grid(a), grid(b), grid(c))
      players.foreach { player =>
        if (test == (player, player, player)) {
          returnVal = (true, player)
        }
      }
    }
    return(returnVal)
  }

  def checkDraw: Boolean = {
    if (numNull == 0) {
      return(true)
      } else {
        return(false)
      }
  }

  val result = checkWinner

  if (result._1 == true) {
    println("The winner is " + result._2)
  } else if (checkDraw == true) {
    println("It's a draw!")
  }

}

val winForX = new Board(List(
  'X', 'O', 'X',
  'O', 'O', 'X',
  'O', 'X', 'X'))

val winForO = new Board(List(
  'O', 'X', ' ',
  'O', 'X', 'X',
  'O', ' ', ' '))

val draw = new Board(List(
  'O', 'O', 'X',
  'X', 'X', 'O',
  'O', 'X', 'O'))