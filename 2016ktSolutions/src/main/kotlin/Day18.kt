object Day18 {
    private const val firstRow = ".^^^.^.^^^^^..^^^..^..^..^^..^.^.^.^^.^^....^.^...^.^^.^^.^^..^^..^.^..^^^.^^...^...^^....^^.^^^^^^^"

    fun part1() = solution(false)
    fun part2() = solution(true)

    private fun solution(isPart2 : Boolean) {
        val floorPlan = mutableListOf<String>(firstRow)
        val max = if (isPart2) { 400000 } else { 40 }

        for (currentRowIndex in 1 until max) {
            val currentString = StringBuilder()
            val prevRow = floorPlan[currentRowIndex - 1]

            (firstRow.indices).forEach {
                currentString.append(getCorrectCharForTile(prevRow, it))
            }

            floorPlan.add(currentString.toString())
        }

        print(floorPlan.fold(0, { acc, next ->
            acc + next.count { it == '.' }
        }))
    }

    private fun getCorrectCharForTile(previousRow : String, xCoordinate : Int) : Char {
        val leftIsTrap = if (xCoordinate != 0){
            previousRow[xCoordinate - 1] == '^'
        } else {
            false
        }
        val rightIsTrap = if (xCoordinate != previousRow.lastIndex ) {
            previousRow[xCoordinate + 1] == '^'
        } else {
            false
        }


        val centerIsTrap = previousRow[xCoordinate] == '^'

        return if (rightIsTrap != leftIsTrap) {
            '^'
        } else {
            '.'
        }

    }
}