# Function to remove duplicate patch numbers
function Remove-DuplicatePatches {
    param (
        [string]$inputText
    )
    
    # Split the input text into an array of lines
    $lines = $inputText -split "`n"

    # Create a hashtable to keep track of the last occurrence of each patch number
    $lastOccurrences = @{}

    # Iterate over each line in reverse order
    for ($i = $lines.Length - 1; $i -ge 0; $i--) {
        $line = $lines[$i].Trim()
        if ($line -ne '') {
            # Extract the patch number
            $patchNumber = $line.Trim()

            # Check if this patch number has been seen before
            if (-not $lastOccurrences.ContainsKey($patchNumber)) {
                # If not, store its index
                $lastOccurrences[$patchNumber] = $i
            } else {
                # If yes, remove this line from the array
                $lines.RemoveAt($i)
            }
        }
    }

    # Reconstruct the output text from the remaining lines
    $outputText = $lines -join "`n"
    return $outputText
}

# Read input text
Write-Host "Paste your patch numbers and press Ctrl+Z (Windows) or Ctrl+D (Linux/Mac) to end input:"
$inputText = [Console]::In.ReadToEnd()

# Process the input text to remove duplicates
$outputText = Remove-DuplicatePatches -inputText $inputText

# Print the output text
Write-Host "`nOutput:"
Write-Host $outputText
