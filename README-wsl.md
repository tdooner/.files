## Installation on WSL

1. Install guest OS: `wsl --install -d Ubuntu-24.04`
2. Install Alacritty - https://alacritty.org/
    * Create a shortcut for `alacritty.exe --command "wsl"`
3. Map Caps Lock -> Control
    * Install Powertoys
    * Keyboard Manager > Remap "Caps Lock" to "Ctrl"/"None"


## Troubleshooting

### Slow network inside WSL
If network is slow, run this in an admin Powershell:
```
netsh int ipv4 set interface "Wi-Fi 2" forwarding=enable
```
(thanks to: https://github.com/microsoft/WSL/issues/4901#issuecomment-1939587570)
