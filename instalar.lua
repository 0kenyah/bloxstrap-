getgenv().autosetup = {
    path = 'Bloxstrap',
    setup = true
}

loadstring(game:HttpGet(
    'https://raw.githubusercontent.com/qwertyui-is-back/Bloxstrap/refs/heads/main/installer.lua',
    true
))()
