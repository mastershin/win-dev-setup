# Install Scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

```powershell
scoop install sudo coreutils grep sed aws make vim 7zip
```

```powershell
# modern Rust-based CLI tools
scoop install ripgrep bat fd fzf zoxide
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

```powershell
notepad $PROFILE

# Use Up/Down arrows to search history matching the current prefix
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

# Optional: Moves cursor to the end of the line when searching (Linux style)
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
```

## self-signed on Admin Powershell

```powershell
$cert = New-SelfSignedCertificate -Type CodeSigningCert -Subject "CN=YourLocalSigner" -CertStoreLocation Cert:\CurrentUser\My
```

### user's powershell

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
