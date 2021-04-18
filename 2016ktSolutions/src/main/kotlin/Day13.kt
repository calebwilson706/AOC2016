private const val officerInput : Long = 1364

object Day13 {
    fun part1() {
        var answer = 1000
        val visited = HashMap<Point, Boolean>()

        fun findPoint(point: Point, currentMoves : Int = 0, visited : Map<Point, Boolean>) {
            //println(point)
            val hasBeenVisited = visited.toMutableMap()

            if (currentMoves >= answer) {
                return
            }

            if (point == Point(31, 39)) {
                answer = currentMoves
                return
            }

            if (!isThisPointAWall(point.up()) && hasBeenVisited[point.up()] == null) {
                hasBeenVisited[point.up()] = true
                findPoint(point.up(), currentMoves + 1,hasBeenVisited)
            }

            if (!isThisPointAWall(point.down()) && hasBeenVisited[point.down()] == null) {
                hasBeenVisited[point.down()] = true
                findPoint(point.down(), currentMoves + 1,hasBeenVisited)
            }

            if (!isThisPointAWall(point.right()) && hasBeenVisited[point.right()] == null) {
                hasBeenVisited[point.right()] = true
                findPoint(point.right(), currentMoves + 1,hasBeenVisited)
            }
            
            if (!isThisPointAWall(point.left()) && hasBeenVisited[point.left()] == null) {
                hasBeenVisited[point.left()] = true
                findPoint(point.left(), currentMoves + 1,hasBeenVisited)
            }
        }

        findPoint(Point(1,1),visited = visited)
        print(answer)
    }

    fun part2() {
        val hasBeenVisited = HashMap<Point, Int>()

        fun findPoint(point: Point, currentMoves : Int = 0) {
            //println(point)
            hasBeenVisited[point] = currentMoves

            if (currentMoves >= 50) {
                return
            }

            if (!isThisPointAWall(point.up()) && hasBeenVisited[point.up()] ?: 50 > currentMoves) {
                findPoint(point.up(), currentMoves + 1)
            }
            if (!isThisPointAWall(point.down()) && hasBeenVisited[point.down()] ?: 50 > currentMoves) {
                findPoint(point.down(), currentMoves + 1)
            }
            if (!isThisPointAWall(point.right()) && hasBeenVisited[point.right()] ?: 50 > currentMoves) {
                findPoint(point.right(), currentMoves + 1)
            }
            if (!isThisPointAWall(point.left()) && hasBeenVisited[point.left()] ?: 50 > currentMoves) {
                findPoint(point.left(), currentMoves + 1)
            }
        }

        findPoint(Point(1,1))
        print(hasBeenVisited.count())
    }
}


fun isThisPointAWall(point : Point) : Boolean {
    if (point.x < 0 || point.y < 0){
        return true
    }
    val checkerSum : Long = ( point.x * (point.x + 3 + 2*point.y) + point.y + point.y * point.y ).toLong() + officerInput
    val binary = checkerSum.toString(2)
    return binary.count { it == '1' } % 2 != 0
}

//104 too low