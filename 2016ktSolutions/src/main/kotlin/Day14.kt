object Day14 {
    private const val saltInput = "cuanljph"

    private fun solution(hashingMethod : (String, Int) -> String, part : Int){
        var postfix = 0
        val validAnswers = mutableListOf<Int>()
        var runningTests = mutableListOf<RunningTest>()
        val hashThisAmountOfTimes = if (part == 2) 2017 else 1

        while (validAnswers.size < 70){

            val hashedString = hashingMethod(saltInput + postfix.toString(),hashThisAmountOfTimes)

            hashedString.getTripleCharacter()?.let { repeatedChar ->

                hashedString.getQuintupleCharacter()?.let { repeatedFiveTimesChar ->
                    runningTests.forEach { test ->
                        if (test.characterToFind == repeatedFiveTimesChar){
                            validAnswers.add(test.firstIndex)
                            test.indexesToSearchLeft -= 1000
                        }
                    }
                }

                runningTests.add(RunningTest(repeatedChar, postfix, 1001))
            }
            runningTests.forEach {
                it.indexesToSearchLeft -= 1
            }
            runningTests = runningTests.filter { it.indexesToSearchLeft >= 1 } as MutableList<RunningTest>
            postfix += 1
            println(validAnswers.size)
        }

        print(validAnswers.sorted()[63])

    }
    fun part1() {
        solution(::md5Recursive,1)
    }
    fun part2() {
        solution(::md5Recursive,2)
    }



}

data class RunningTest(val characterToFind : Char, val firstIndex : Int, var indexesToSearchLeft : Int)


fun String.getTripleCharacter() : Char? {
    var index = 0

    while (index + 2 < this.length) {
        if (this[index] == this[index + 1] && this[index] == this[index + 2]) {
            return this[index]
        }
        index += 1
    }

    return null
}

fun String.getQuintupleCharacter() : Char? {
    var index = 0

    while (index + 4 < this.length) {
        if (this[index] == this[index + 1]
            && this[index] == this[index + 2]
            && this[index] == this[index + 3]
            && this[index] == this[index + 4]) {
            return this[index]
        }
        index += 1
    }

    return null
}