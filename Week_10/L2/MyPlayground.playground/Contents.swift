

let str = "swIftlanguage"
//Vowels = 5 (i, a, u, a, e)


//Consonants = 9
func countVowels(str: String)-> (Int, String, Int, String) {
    var countOfVowel = 0
    var countOfConsonant = 0
    let vowels = "aeiouAEIOU"
    var vowelStr = ""
    var consonantStr = ""
    //let checkStr = str.lowercased()
    for character in str {
        if vowels.contains(character) {
            vowelStr.append(character)
            countOfVowel += 1
        } else {
            countOfConsonant += 1
            consonantStr.append(character)
        }
    }
    return (countOfVowel, vowelStr, countOfConsonant, consonantStr)
}

let count = countVowels(str: "swIftlanguage")
print("count of vowel: \(count.0)")
print("string of vowel: \(count.1)")
print("count of consonant: \(count.2)")
print("string of consonant: \(count.3)")
