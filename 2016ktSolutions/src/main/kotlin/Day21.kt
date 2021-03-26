import java.io.File

val day21InputLines = File("/Users/calebjw/Documents/Developer/AdventOfCode/2016/Inputs/Day21Input.txt")
    .readLines()

fun Char.charToInt() = this.toString().toInt()
object Day21 {


    fun part1() {
        var workingString = "abcdefgh"

        getInstructions().forEach {
            println("    $workingString")
            println(it)
            workingString = when (it.instruction ) {
                Day21Instructions.SWAP_BY_POSITION -> swapPosition(it.firstChar.charToInt(),it.secondChar!!.charToInt(),workingString)
                Day21Instructions.SWAP_LETTERS -> swapLetter(it.firstChar,it.secondChar!!,workingString)
                Day21Instructions.ROTATE_LEFT -> rotateLeft(workingString, it.firstChar.charToInt())
                Day21Instructions.ROTATE_RIGHT -> rotateRight(workingString, it.firstChar.charToInt())
                Day21Instructions.ROTATE_BASED_ON_POSITION -> rotateBasedOnPositionPart1(it.firstChar, workingString)
                Day21Instructions.REVERSE_POSITIONS_BETWEEN -> reversePositions(it.firstChar.charToInt(), it.secondChar!!.charToInt(), workingString)
                Day21Instructions.MOVE -> move(it.firstChar.charToInt(), it.secondChar!!.charToInt(), workingString)
            }
        }

        println(workingString)
    }
    fun part2() {
        var workingString = "fbgdceah"

        getInstructions().reversed().forEach {
            println("    $workingString")
            println(it)

            workingString = when (it.instruction ) {

                Day21Instructions.SWAP_BY_POSITION -> swapPosition(it.firstChar.charToInt(),it.secondChar!!.charToInt(),workingString)
                Day21Instructions.SWAP_LETTERS -> swapLetter(it.firstChar,it.secondChar!!,workingString)
                Day21Instructions.ROTATE_LEFT -> rotateRight(workingString, it.firstChar.charToInt())
                Day21Instructions.ROTATE_RIGHT -> rotateLeft(workingString, it.firstChar.charToInt())
                Day21Instructions.ROTATE_BASED_ON_POSITION -> rotateBasedOnPositionPart2(it.firstChar, workingString)
                Day21Instructions.REVERSE_POSITIONS_BETWEEN -> reversePositions(it.firstChar.charToInt(), it.secondChar!!.charToInt(), workingString)
                Day21Instructions.MOVE -> move(it.secondChar!!.charToInt(), it.firstChar.charToInt() , workingString)
            }

        }

        println(workingString)
    }



    fun swapPosition(x : Int, y : Int, originalString: String) : String {
        val workingCharArray = originalString.toCharArray()

        val temp = workingCharArray[x]
        workingCharArray[x] = workingCharArray[y]
        workingCharArray[y] = temp

        val result =  workingCharArray.joinToString("")

        return result
    }

    fun swapLetter(x : Char, y : Char, originalString: String) : String {
        val xIndex = originalString.indexOf(x)
        val yIndex = originalString.indexOf(y)

        val workingCharArray = originalString.toCharArray()
        workingCharArray[xIndex] = y
        workingCharArray[yIndex] = x

        return workingCharArray.joinToString("")
    }

    fun rotateRight(originalString: String, steps : Int) : String {
        val working = originalString.dropLast(steps)
        return originalString.drop(originalString.length - steps) + working
    }

    private fun rotateLeft(originalString: String, steps : Int) : String {
        val working = originalString.drop(steps)
        return working + originalString.dropLast(originalString.length - steps)
    }

    fun rotateBasedOnPositionPart1(x : Char, originalString: String) : String {
        val xIndex = originalString.indexOf(x)

        val amountOfRotations = 1 + xIndex + if (xIndex >= 4) {
            1
        } else {
            0
        }
        if (xIndex == 7) return rotateRight(originalString, 1)
        var workingString = originalString

        workingString = rotateRight(workingString,amountOfRotations)

        return workingString
    }

    fun rotateBasedOnPositionPart2(x : Char, originalString: String) : String {
        var working = originalString

        while (true) {
            working = rotateLeft(working, 1)
            if (rotateBasedOnPositionPart1(x, working) == originalString) {
                return working
            }
        }
    }

    fun reversePositions(ofX: Int, throughY: Int, originalString: String): String {

        val header = originalString.subSequence(0, ofX).toString()
        val mainPart = originalString.subSequence(ofX, throughY + 1).reversed().toString()
        val footer = originalString.subSequence(throughY + 1, originalString.length).toString()

        return header + mainPart + footer

    }

    fun move(start: Int, to: Int, originalString: String): String {

        val movingCharacter = originalString[start]

        val midPoint = if (start < to) {
            to + 1
        } else {
            to
        }

        val beforeChar = originalString.subSequence(0, midPoint).toString()
        val afterChar = originalString.subSequence(midPoint, originalString.length).toString()

        return beforeChar.filter { it != movingCharacter } + movingCharacter + afterChar.filter { it != movingCharacter }
    }






}

data class Day21InstructionClass(val instruction : Day21Instructions, val firstChar: Char, val secondChar: Char? )

enum class Day21Instructions {
    SWAP_BY_POSITION,
    SWAP_LETTERS,
    ROTATE_LEFT,
    ROTATE_RIGHT,
    ROTATE_BASED_ON_POSITION,
    REVERSE_POSITIONS_BETWEEN,
    MOVE
}


fun getInstructions(): MutableList<Day21InstructionClass> {
    val swapLettersRegex = "swap letter ([a-h]) with letter ([a-h])".toRegex()
    val rotateBasedOnPositionOfLetter = "rotate based on position of letter ([a-h])".toRegex()

    var results = mutableListOf<Day21InstructionClass>()

    day21InputLines.forEach {
        when {
            it.contains("swap position") -> {
                results = addInstructionWIthTwoNumbers(Day21Instructions.SWAP_BY_POSITION, it, results)
            }
            it.contains("swap letter") -> {
                results = useRegexToAddInstructionWithTwoChars(Day21Instructions.SWAP_LETTERS, it, results, swapLettersRegex)
            }
            it.contains("rotate left") -> {
                results = addInstructionWIthTwoNumbers(Day21Instructions.ROTATE_LEFT, it, results)
            }
            it.contains("rotate right") -> {
                results = addInstructionWIthTwoNumbers(Day21Instructions.ROTATE_RIGHT, it, results)
            }
            it.contains("rotate based") -> {
                val (char) = rotateBasedOnPositionOfLetter.find(it)!!.destructured
                results.add(Day21InstructionClass(
                    Day21Instructions.ROTATE_BASED_ON_POSITION,
                    char.first(),
                    null
                ))
            }
            it.contains("reverse positions") -> {
                results = addInstructionWIthTwoNumbers(Day21Instructions.REVERSE_POSITIONS_BETWEEN, it, results)
            }
            it.contains("move") -> {
                results = addInstructionWIthTwoNumbers(Day21Instructions.MOVE, it, results)
            }
        }
    }

    return results
}

private fun addInstructionWIthTwoNumbers(
    instruction: Day21Instructions,
    string: String,
    currentList: List<Day21InstructionClass>
) : MutableList<Day21InstructionClass> {

    val startListMutable = currentList.toMutableList()
    val numbersIncluded = string.filter { character -> character.isDigit() }

    startListMutable.add(Day21InstructionClass(
        instruction,
        numbersIncluded.first(),
        numbersIncluded.lastOrNull()
    ))

    return startListMutable
}

private fun useRegexToAddInstructionWithTwoChars(
    instruction: Day21Instructions,
    string: String,
    currentList: List<Day21InstructionClass>,
    regexStatement: Regex
) : MutableList<Day21InstructionClass> {
    val (firstChar, secondChar) = regexStatement.find(string)!!.destructured
    val startListMutable = currentList.toMutableList()

    startListMutable.add( Day21InstructionClass(
        instruction,
        firstChar.first(),
        secondChar.first()
    ))

    return startListMutable
}


