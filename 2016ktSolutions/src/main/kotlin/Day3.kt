import java.io.File

val day3stringInput = File("/Users/calebjw/Documents/AdventOfCode/2016/Inputs/Day3Input.txt").readText()


object Day3 {

    fun part1() {
        println(getTrianglesPart1().count {
            it.hypotenuse < it.a + it.b
        })
    }
    fun part2() {
        println(getTrianglesPart2().count {
            it.hypotenuse < it.a + it.b
        })
    }

}

private data class Triangle(val hypotenuse : Int, val a : Int, val b : Int)


private fun getTrianglesPart1(): MutableList<Triangle> {
    val unParsedTriangles = day3stringInput.split("\n")
    val answers = mutableListOf<Triangle>()
    val regexStatement = "\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s*".toRegex()
    unParsedTriangles.forEach {
        val (s1, s2, s3) = regexStatement.find(it)!!.destructured
        val listForItems = listOf<Int>(s1.toInt(),s2.toInt(),s3.toInt()).sorted()
        answers.add(Triangle(listForItems[2],listForItems[1],listForItems[0]))
    }

    return answers
}

private fun getTrianglesPart2() : List<Triangle> {
    val unParsedTriangles = day3stringInput.split("\n")

    val column1 = mutableListOf<Int>()
    val column2 = mutableListOf<Int>()
    val column3 = mutableListOf<Int>()

    val regexStatement = "\\s+([0-9]+)\\s+([0-9]+)\\s+([0-9]+)\\s*".toRegex()

    unParsedTriangles.forEach {
        val (int1, int2, int3) = regexStatement.find(it)!!.destructured
        column1.add(int1.toInt())
        column2.add(int2.toInt())
        column3.add(int3.toInt())
    }

    val triangles = chunkIntoSortedList(column1) + chunkIntoSortedList(column2) + chunkIntoSortedList(column3)

    return triangles.map { Triangle(it[2],it[1],it[0]) }
}


fun chunkIntoSortedList(list : List<Int>) : List<List<Int>> {
    val answers = mutableListOf<List<Int>>()
    var current = mutableListOf<Int>()

    list.forEach {
        current.add(it)
        if (current.size == 3) {
            answers.add(current.sorted())
            current = mutableListOf()
        }
    }

    return answers
}
