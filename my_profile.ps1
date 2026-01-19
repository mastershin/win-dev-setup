# Use Up/Down arrows to search history matching the current prefix
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

# Optional: Moves cursor to the end of the line when searching (Linux style)
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

function ll  { Get-ChildItem -Force @args | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }
function la  { Get-ChildItem -Force -Name @args }
function lt  { Get-ChildItem -Force @args | Sort-Object LastWriteTime -Descending | Format-Table -AutoSize }
function lw { Get-ChildItem -Force @args | Format-Wide -AutoSize }
