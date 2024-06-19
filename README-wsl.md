## Installation on WSL

1. Install guest OS: `wsl --install -d Ubuntu-24.04`
2. Install Alacritty - https://alacritty.org/
    * Create a shortcut for `C:\path\to\Alacritty.exe --config-file \\wsl.localhost\Ubuntu-24.04\home\tdooner\.files\alacritty.toml --command wsl`
3. Set up keybindings to make Windows mimic Mac modifier keys
    * Install Powertoys
    * Restore the backup in `powertoys-backup.zip`
4. WSL settings
    * For docker, enable autoMemoryReclaim: https://learn.microsoft.com/en-us/windows/wsl/wsl-config#experimental-settings
    ```
    # C:\Users\<UserName>\.wslconfig
    [experimental]
    autoMemoryReclaim = gradual
    ```


## Troubleshooting

### Slow network inside WSL
If network is slow, run this in an admin Powershell:
```
netsh int ipv4 set interface "Wi-Fi 2" forwarding=enable
```
(thanks to: https://github.com/microsoft/WSL/issues/4901#issuecomment-1939587570)
