import java.io.File

object Day8 {
    private fun getFinishedMap() : MutableMap<Point, Boolean> {
        var gridOfLights = getAllOffGrid()

        getRules().forEach {
            gridOfLights = when (it.instruction) {
                Day8Instructions.Rect -> {
                    applyRectRule(it.coordinate, it.quantity, gridOfLights)
                }

                Day8Instructions.RotateRow -> {
                    applyRotateYRule(it.coordinate, gridOfLights, it.quantity)
                }

                Day8Instructions.RotateColumn -> {
                    applyRotateXRule(it.coordinate, gridOfLights, it.quantity)
                }
            }
        }

        return gridOfLights
    }

    fun part1() {
        println(getFinishedMap().values.count { it })
    }
    fun part2() {
        val endResult = getFinishedMap()

        showLetters(endResult)
    }

    private fun showLetters(grid: Map<Point, Boolean>){
        val results  = Array(6) { CharArray(50)}


        for (x in 0 until 50){
            for (y in 0 until 6){
                results[y][x] = if (grid[Point(x,y)]!!) {
                    '#'
                } else {
                    '.'
                }
            }
        }

        results.forEach {
            println(it)
        }
        println("\n\n")
    }

    private fun getAllOffGrid() : MutableMap<Point, Boolean> {
        val grid = mutableMapOf<Point, Boolean>()

        for (x in 0 until 50) {
            for (y in 0 until 6) {
                grid[Point(x,y)] = false
            }
        }

        return grid
    }

    private fun applyRectRule(width : Int, height : Int, grid : Map<Point, Boolean>) : MutableMap<Point, Boolean> {
        val working = grid.toMutableMap()
        for (x in 0 until width) {
            for (y in 0 until height) {
                working[Point(x, y)] = true
            }
        }
        return working
    }

    private fun applyRotateYRule(row : Int, grid: Map<Point, Boolean>, shift : Int) : MutableMap<Point, Boolean> {
        val working = grid.toMutableMap()
        for (x in 0 until 50) {
            val newCoOrd = if (x + shift < 50){
                x + shift
            } else {
                x + shift - 50
            }
            working[Point(newCoOrd ,row)] = grid[Point(x,row)]!!
        }

        return working
    }

    private fun applyRotateXRule(column : Int, grid: Map<Point, Boolean>, shift : Int) : MutableMap<Point, Boolean> {
        val working = grid.toMutableMap()
        for (y in 0 until 6) {
            val newCoOrd = if (y + shift < 6){
                y + shift
            } else {
                y + shift - 6
            }
            working[Point(column ,newCoOrd)] = grid[Point(column,y)]!!
        }

        return working
    }
}

data class Point(val x : Int, val y : Int)

enum class Day8Instructions {
    Rect, RotateRow, RotateColumn
}


data class Day8InstructionContainer(val instruction : Day8Instructions, val coordinate : Int, val quantity: Int)
//coordinate for rect = width // quantity for rect can be height

fun getRules() : List<Day8InstructionContainer> {
    val strFromFile = File("/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day8Input.txt")
        .readText()
        .split("\n")
    val results = mutableListOf<Day8InstructionContainer>()

    strFromFile.forEach {
        when {
            it.contains("rect") -> {
                val parts = it.split("x")
                results.add(Day8InstructionContainer(Day8Instructions.Rect,
                    parts[0].filter { char ->
                        char.isDigit()
                    }.toInt(),
                    parts[1].toInt()
                )
                )
            }
            it.contains("row") -> {
                val regexForPart = "rotate row y=([0-9]) by ([0-9]+)".toRegex()
                val (row, byValue) = regexForPart.find(it)!!.destructured

                results.add(Day8InstructionContainer(
                    Day8Instructions.RotateRow,
                    row.toInt(),
                    byValue.toInt()
                ))

            }
            it.contains("column") -> {
                val regexForPart = "rotate column x=([0-9]+) by ([0-9]+)".toRegex()
                val (column, byValue) = regexForPart.find(it)!!.destructured

                results.add(Day8InstructionContainer(
                    Day8Instructions.RotateColumn,
                    column.toInt(),
                    byValue.toInt()
                ))
            }
        }

    }

    return results
}
