@echo off
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations /v ModRiskFileTypes /t REG_SZ /d .exe;.bat;.vbs;.rar;.zip;.7z /f
gpupdate /force
exit