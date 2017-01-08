using module "C:\Users\Daniel\Documents\koodit\hirsipuu\class-hirsipuu.psm1"

# TODO
# 1. Kysy kirjain
# 2. Näytä arvatut kirjaimet
# 3. Näytä sana 
# 4. pidä kirjaa vääristä arvauksista ja vähennä arvauksia
# 5. 

function Check-Letter {

    [CmdletBinding()]
    Param  (
        [Parameter(Mandatory=$true)]
        [Hirsipuu]$hirsipuu
    )

    [string]$letter

    $guessedLetter = Read-Host -Prompt "Guess a character"

    if ($hirsipuu.guessedLetters.contains($guessedLetter) -eq $false) {
       
        $hirsipuu.guessedLetters.Add($guessedLetter) | Out-Null
    }
    

    if ($hirsipuu.correctWord.Contains($guessedLetter)) {
        
        [void]$correctLetters.add($guessedLetter)
    } else {
        --$hirsipuu.guessesLeft
    }

}

function Write-Word {
    [CmdletBinding()]
    Param  (
        [Parameter(Mandatory=$true)]
        [Hirsipuu]$hirsipuu
    )

    $letterFound = $false
    $sb = New-Object -TypeName "System.Text.StringBuilder"

    for ($i = 0; $i -lt ($hirsipuu.correctWord.length); ++$i) { # loop trough the correct word
    
        if ($hirsipuu.guessedLetters -contains ($hirsipuu.correctWord[$i])) { # jos kirjain löytyy arvatuista
            [void]$sb.Append($hirsipuu.correctWord[$i])            
        } else {
            [void]$sb.Append("_")
           
        }       
    
    }
     $hirsipuu.guessedWord = $sb.toString()
    
}

Function Check-Win {

    [CmdletBinding()]
    Param  (
        [Parameter(Mandatory=$true)]
        [Hirsipuu]$hpuu
    )

    if ($hpuu.guessedWord.Contains("_")) {
        return $false
    } else {
        return $true
    }
}

# Create new Hirsipuu game

function Start-Game {

    [Hirsipuu]$hpuu = [Hirsipuu]::new()
    
    #Initialize masked word
    Write-Word -hirsipuu $hpuu
    
    $correctLetters = (New-Object System.Collections.ArrayList)

    while ($hpuu.guessesLeft -gt 0) {
        cls
        Write-HangMan -guessesLeft $hpuu.guessesLeft
        
        Write-Output "Word to guess: "$hpuu.guessedWord""
        Write-Output "Guesses left:  "$hpuu.guessesLeft""
        Write-Output "Used letters: "($hpuu.guessedLetters -join '')""

        Check-Letter -hirsipuu $hpuu

        Write-Word -hirsipuu $hpuu
    
        if($hpuu.guessedWord.Contains("_") -eq $false) {
            Write-Output "You guessed the right word!"
            break
        }    
    
    }
    cls
    Write-HangMan -guessesLeft $hpuu.guessesLeft
    Start-End
}

function Start-End {
 
            Write-Output "Do you want to play another game?"
            $input = Read-Host -Prompt "(Yes/No)"

            if ($input -like "Yes") {
                Start-Game
            }

            if ($input -like "No") {

                Write-Output "Like you have anything better to do"
                break
            }
}

function Write-HangMan {

    [CmdletBinding()]
    Param  (
        [Parameter(Mandatory=$true)]
        [int]$guessesLeft
    )
    
    Write-Output "########################################"
    Write-Output "##########Hirsipuu The Game#############"
    Write-Output "########################################"

    if ($guessesLeft -eq 5) {

    Write-Output "--------------------"
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"
    Write-Output "---------------------"   
    
    }
    
        if ($guessesLeft -eq 4) {

    Write-Output "--------------------"
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"
    Write-Output "---------------------"   
    
    }
    
        if ($guessesLeft -eq 3) {

    Write-Output "--------------------"
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            O"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"
    Write-Output "---------------------"   
    
    } 
    
    if ($guessesLeft -eq 2) {

    Write-Output "--------------------"
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            O"              
    Write-Output     "|            |"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"
    Write-Output "---------------------"   
    
    }
    
    if ($guessesLeft -eq 1) {

    Write-Output "--------------------"
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            |"              
    Write-Output     "|            O"              
    Write-Output     "|           /|\"              
    Write-Output     "|              " 
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"
    Write-Output "---------------------"   
    
    }
    
    if ($guessesLeft -eq 0) {

    Write-Output "--------------------"
    Write-Output     "|            |    ###########"              
    Write-Output     "|            |      I'M     #"             
    Write-Output     "|            |      DEAD!   #"              
    Write-Output     "|            O    ###########"              
    Write-Output     "|           /|\"              
    Write-Output     "|           / \" 
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"              
    Write-Output     "|"
    Write-Output "---------------------"   
    
    }                   
}  