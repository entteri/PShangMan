Class Hirsipuu {
    $guessedLetters = (New-Object System.Collections.ArrayList)
    [int]$guessesLeft = 5
    [string[]]$words = @("smothie")
    [string]$correctWord = (Get-Random -inputObject $this.words)
    [string]$guessedWord = ""
}