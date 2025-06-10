TO get oh-my-posh on windows terminal (powershell):

1.) Invoke-WebRequest https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/sonicboom_dark.omp.json -OutFile "$HOME\sonicboom_dark.omp.json"

2) oh-my-posh init pwsh --config "$HOME\sonicboom_dark.omp.json" | Invoke-Expression    { to temporarily apply theme}

3)notepad $PROFILE { to make it permanent }

4)oh-my-posh init pwsh --config "$HOME\sonicboom_dark.omp.json" | Invoke-Expression



if notepad $PROFILE does not work as .ps1 file may not be present :

do : open Run and paste :notepad C:\Users\hp\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 { this will open the notepad even if file isn't present}

now to step 4 !!

done !!



