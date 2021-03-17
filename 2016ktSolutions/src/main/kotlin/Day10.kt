import java.io.File
import kotlin.math.max
import kotlin.math.min

private val stringInputNotParsedDay10 = File("/Users/calebjw/Documents/Developer/AdventOfCode/2016/Inputs/Day10Input.txt")
    .readText()

object Day10 {
    private fun getAnswerPart1() : Int {
        var starting = populateMapWithInitialValues()

        while (true) {
            starting.bots.filter { it.value.second != null }.forEach {
                if (it.value == Pair(17, 61)) {
                    return it.key
                }
                starting = useRulesWithAFullDonor(it, starting)
            }
        }
    }

    fun part2() {
        var starting = populateMapWithInitialValues()
        var answer = 1
        var filteredBots = starting.bots.filter { it.value.second != null }

        while (filteredBots.isNotEmpty()) {
            filteredBots.forEach { mapEntry ->
                starting = useRulesWithAFullDonor(mapEntry, starting, true) {
                    answer *= it
                }
            }
            filteredBots = starting.bots.filter { it.value.second != null }
        }

        println(answer)
    }

    fun part1() {
        println(getAnswerPart1())
    }
}


data class CurrentStatusOfBots(val bots : Map<Int, Pair<Int, Int?>>, val validInstructions : List<String>)


fun populateMapWithInitialValues() : CurrentStatusOfBots {
    val results = mutableMapOf<Int, Pair<Int, Int?>>()
    val lines = stringInputNotParsedDay10.split("\n")
    val regexStatement = "value ([0-9]+) goes to bot ([0-9]+)".toRegex()
    val newLines = mutableListOf<String>()

    lines.forEach {
        if (it.first() == 'v') {
            val (number, bot) = regexStatement.find(it)!!.destructured

            val botNumber = bot.toInt()

            if (results[botNumber] != null) {
                results[botNumber] = addValueToPair(results[botNumber]!!, number.toInt())
            } else {
                results[botNumber] = Pair(number.toInt(), null)
            }

        } else {
            newLines.add(it)
        }
    }

    return CurrentStatusOfBots(results, newLines)
}

//next take in current state and find instructions which go from map keys which contain two values.
fun addValueToPair(p : Pair<Int, Int?>, newVal : Int) : Pair<Int, Int?> {
    val pair = Pair(p.first, newVal)
    return Pair(min(pair.first, pair.second), max(pair.first, pair.second))
}


fun useRulesWithAFullDonor(entryToUse: Map.Entry<Int, Pair<Int, Int?>>, currentStatus: CurrentStatusOfBots, isPart2: Boolean = false, partTwoHelper: ((Int) -> Unit)? = null) : CurrentStatusOfBots {
    val results = currentStatus.bots.toMutableMap()
    val newLines = mutableListOf<String>()
    val regexStatement = "bot ${entryToUse.key} gives low to ([a-z]+) ([0-9]+) and high to ([a-z]+) ([0-9]+)".toRegex()

    currentStatus.validInstructions.forEach {
        regexStatement.find(it)?.let { match ->
            val (locationLowInstruction, locationLowNumber, locationHighInstruction, locationHighNumber) = match.destructured
            //println(it)
            if (locationLowInstruction != "output") {
                val botNumberLow = locationLowNumber.toInt()

                if (results[botNumberLow] != null) {
                    results[botNumberLow] = addValueToPair(results[botNumberLow]!!, entryToUse.value.first)
                } else {
                    results[botNumberLow] = Pair(entryToUse.value.first, null)
                }

            } else if (isPart2) {
                if (locationLowNumber.toInt() < 3) {
                    partTwoHelper!!(entryToUse.value.first)
                }
            }

            if (locationHighInstruction != "output") {
                val botNumberHigh = locationHighNumber.toInt()

                if (results[botNumberHigh] != null) {
                    results[botNumberHigh] = addValueToPair(results[botNumberHigh]!!, entryToUse.value.second!!)
                } else {
                    results[botNumberHigh] = Pair(entryToUse.value.second!!, null)
                }

            } else if (isPart2) {
                if (locationLowNumber.toInt() < 3) {
                    partTwoHelper!!(entryToUse.value.second!!)
                }
            }
            results.remove(entryToUse.key)
        } ?: newLines.add(it)

    }

    return  CurrentStatusOfBots(results, newLines)
}





