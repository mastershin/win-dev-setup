# Install Scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

```powershell
winget install isc.bin
scoop install sudo coreutils grep sed aws make vim 7zip ffmpeg poppler
```

```powershell
# modern CLI tools
scoop install ripgrep bat fd fzf zoxide ast-grep yazi chafa
```

```powershell
# Developer tools, git, git hub CLI, node, go, rust and uv (uv for python as well), oh-my-posh terminal
scoop install git gh uv nodejs oh-my-posh neovim go rustup

# make sure to use ssh here
git config --global core.sshCommand "C:/Windows/System32/OpenSSH/ssh.exe"

# if installing oh-my-posh terminal, font: MesloLGM Nerd Font
oh-my-posh font install


# append this to $PROFILE
oh-my-posh init pwsh | Invoke-Expression

```

# Respond to up/down arrow in Terminal

`notepad $PROFILE`

```powershell
# Use Up/Down arrows to search history matching the current prefix
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

# Optional: Moves cursor to the end of the line when searching (Linux style)
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

function ll  { Get-ChildItem -Force @args | Format-Table Mode, LastWriteTime, Length, Name -AutoSize }
function la  { Get-ChildItem -Force -Name @args }
function lt  { Get-ChildItem -Force @args | Sort-Object LastWriteTime -Descending | Format-Table -AutoSize }
function lw { Get-ChildItem -Force @args | Format-Wide -AutoSize }

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) { Import-Module "$ChocolateyProfile" }

oh-my-posh init pwsh | Invoke-Expression
```

## self-signed on Admin Powershell

```powershell
$cert = New-SelfSignedCertificate -Type CodeSigningCert -Subject "CN=YourLocalSigner" -CertStoreLocation Cert:\CurrentUser\My
```

## start ssh-agent
```powershell
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
```

### user's powershell

```powershell
# add current key to agent
ssh-add $HOME\.ssh\id_ed25519
```

```powershell
Move-Item -Path "Cert:\CurrentUser\My\$($cert.Thumbprint)" -Destination "Cert:\CurrentUser\Root"

# Copy the cert object to the Trusted Publishers store
$store = Get-Item "Cert:\CurrentUser\TrustedPublisher"
$store.Open("ReadWrite")
$store.Add($cert)
$store.Close()

Set-ExecutionPolicy AllSigned -Scope CurrentUser

Set-AuthenticodeSignature -FilePath $PROFILE -Certificate $cert
```

## vnc client that supports VeNCrypt
- `https://sourceforge.net/projects/tigervnc/`
- or use RoyalTS

## AI agents
```powershell
# git
winget install --id Git.Git -e --source winget

# kilo code
winget kilocode

# claude via winget (manual auto update)
winget install Anthropic.ClaudeCode

# Google Gemini CLI
npm install -g @google/gemini-cli

# OpenAI Codex
npm install -g @openai/codex

# claude via powershell (auto update)
irm https://claude.ai/install.ps1 | iex
```

# wezterm (%USERPROFILE%/.wezterm.lua)
```lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10.0

config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.9

config.keys = {
    -- Map Alt + 1 through 9 to switch to tabs 0 through 8
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },
  {
    -- Ctrl + Shift + Enter: toggle zoom
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    -- Ctrl + Alt + Enter: toggle zoom
    key = 'Enter',
    mods = 'CTRL|ALT',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    -- Ctrl + Shift + D: split vertical
    key = 'D',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' })
  },
  {
    -- Ctrl + ]: move to next pane
    key = ']',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection('Next'),
  },
  {
    -- Ctrl + [: move to previous pane
    key = '[',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection('Prev'),
  },
}

return config
```

