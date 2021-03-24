import org.w3c.dom.ranges.Range
import java.io.File
import kotlin.math.max
import kotlin.math.min

private val day20InputLines = File("/Users/calebjw/Documents/Developer/AdventOfCode/2016/Inputs/Day20Input.txt")
    .readLines()

object Day20 {
    private val ranges = getRangesFromInput()

    fun part1() {
        println(getLowestValue(ranges, 0))
    }

    fun part2() {
        var maximum : Long = 4294967296
        val newRanges = compressRanges(ranges)
        //print(newRanges)
        newRanges.forEach {
            maximum -= (it.upper - it.lower + 1)
        }

        println(maximum)
    }
    private fun getLowestValue(currentRanges: List<IPRange>, currentLowest: Long) : Long {
        val workingList = currentRanges.toMutableList()

        currentRanges.forEachIndexed { i, it ->
            if (it.lower <= currentLowest && it.upper >= currentLowest){
                workingList.removeAt(i)
                return getLowestValue(workingList, it.upper + 1)
            }
        }

        return currentLowest
    }

    private fun compressRanges(starting : List<IPRange>) : List<IPRange> {
        val currentRanges = mutableListOf<IPRange>()

        starting.forEach { new ->
            //println(currentRanges)
            val indexOfRangeThatCrossesOver = currentRanges.indexOfFirst {
                it.lower <= new.lower && it.upper >= new.lower || it.lower >= new.lower && it.lower <= new.upper }

            if (indexOfRangeThatCrossesOver != -1) {
                val originalRange = currentRanges[indexOfRangeThatCrossesOver]
                currentRanges[indexOfRangeThatCrossesOver] = IPRange(min(originalRange.lower, new.lower), max(originalRange.upper, new.upper))
            } else {
                 currentRanges.add(new)
            }
        }

        return if (currentRanges.size == starting.size) {
            currentRanges
        } else {
            compressRanges(currentRanges)
        }
    }
}


data class IPRange(val lower : Long, val upper : Long)

fun getRangesFromInput() : List<IPRange> {
    val regexStatement = "([0-9]+)-([0-9]+)".toRegex()

    return day20InputLines.map {
        val (lower, upper) = regexStatement.find(it)!!.destructured
        IPRange(lower.toLong(), upper.toLong())
    }
}
