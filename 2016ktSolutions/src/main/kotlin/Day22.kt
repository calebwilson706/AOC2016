import jdk.jfr.Percentage
import java.io.File
import kotlin.math.abs

val day22InputLines = File("/Users/calebjw/Documents/Developer/AdventOfCode/2016/Inputs/Day22Input.txt")
    .readLines()
const val extractNumberRegex = "([0-9]+)"

object Day22 {
    fun part1() {
        println(getAllValidPairs(getInitialNodes()).size)
    }

    fun part2() {
        showTheMap()
        val maxX = 36
        val startEmptyPoint = Point(19, 6)
        val stepsToMakeBesideG = startEmptyPoint.x + startEmptyPoint.y + maxX - 1
        val stepsInOneIteration = 5

        println(stepsToMakeBesideG + stepsInOneIteration*(maxX - 1) + 1)
    }


    private fun showTheMap() {
        val nodes = getInitialNodes()
        val validPairs = getAllValidPairs(nodes)

        for (y in 0..24) {
            for (x in 0..36) {
                when {
                    Point(x, y) == Point(36, 0) -> {
                        print("G")
                    }
                    Point(x, y) == Point(0, 0) -> {
                        print("x")
                    }

                    validPairs.map { it.first.point }.contains(Point(x, y)) -> {
                        print(".")
                    }
                    nodes.first { it.point == Point(x, y) }.usagePercentage == 0 -> {
                        print("_")
                    }
                    else -> {
                        print("#")
                    }
                }
            }
            println()
        }


    }



    private fun getAllValidNodesForPoint(a : StorageNode, listOfNodes : List<StorageNode>) : Set<Pair<StorageNode, StorageNode>> {
        val results = mutableSetOf<Pair<StorageNode, StorageNode>>()

        listOfNodes.forEach {
            if ((it != a) && it.empty > a.used) {
                results.add(Pair(a, it))
            }
        }

        return results
    }

    private fun getAllValidPairs(allNodes : List<StorageNode>) : Set<Pair<StorageNode, StorageNode>> {
        val viablePairs = mutableSetOf<Pair<StorageNode, StorageNode>>()

        allNodes.forEach {
            if (it.usagePercentage != 0) {
                viablePairs.addAll(getAllValidNodesForPoint(it, allNodes))
            }
        }

        viablePairs.removeIf { viablePairs.contains(Pair(it.second, it.first)) }
        return viablePairs
    }

    private fun Point.isANeighbourTo(point : Point) = abs(this.x - point.x) <= 1 && abs(this.y - point.y) <= 1

}


data class StorageNode(val point : Point, val size : Int, val used : Int, val empty : Int, val usagePercentage: Int)

fun getInitialNodes() : List<StorageNode> {
    val results = mutableListOf<StorageNode>()
    val regexPartForSizeString = "\\s+${extractNumberRegex}."
    val regexStatement = "/dev/grid/node-x$extractNumberRegex-y$extractNumberRegex$regexPartForSizeString$regexPartForSizeString$regexPartForSizeString$regexPartForSizeString".toRegex()

    day22InputLines.forEach {
        val (x, y, size, used, empty, percentage) = regexStatement.find(it)!!.destructured
        results.add(
            StorageNode(
                Point(x.toInt(), y.toInt()),
                size.toInt(),
                used.toInt(),
                empty.toInt(),
                percentage.toInt()
            )
        )
    }

    return results
}
