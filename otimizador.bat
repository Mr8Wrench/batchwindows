@echo off

title Otimizador Patelson
cls


:menu 
mode 77,40
color 4                                                                 
time /t
date /t  

echo =============================================================================
echo *         ######                                                            *
echo *         #     #   ##   ##### ###### #       ####   ####  #    #           *
echo *         #     #  #  #    #   #      #      #      #    # ##   #           *
echo *         ######  #    #   #   #####  #       ####  #    # # #  #           *
echo *         #       ######   #   #      #           # #    # #  # #           *
echo *         #       #    #   #   #      #      #    # #    # #   ##           *
echo *         #       #    #   #   ###### ######  ####   ####  #    #           *
echo *___________________________________________________________________________*
echo *                                                                           *
echo * [1] - Otimizar                                                            *
echo * [2] - Atualizar Programas                                                 *
echo * [3] - Reparar                                                             *
echo * [4] - Atualizar Windows                                                   *
echo * [5] - Verificacao de Virus                                                *
echo * [6] - Desfragmentar Disco Local                                           *
echo * [7] - Checar Memoria RAM                                                  *
echo * [8] - Checar Processador                                                  *
echo * [0] - SAIR                                                 by @Mr8Wrench  *
echo =============================================================================
echo.
echo.

set /p op= Digite sua opcao:
if %op% equ 1 goto 1
if %op% equ 2 goto 2
if %op% equ 3 goto 3
if %op% equ 4 goto 4
if %op% equ 5 goto 5
if %op% equ 6 goto 6
if %op% equ 7 goto 7
if %op% equ 8 goto 8
if %op% equ 0 goto 0(
)else(
	cls
	goto menu
)
	

:1
	cls
	del /s /q /f C:\Windows\Prefetch\*.*	
	del /s /q /f C:\Windows\Temp\*.*
	del /s /q /f C:\Users\ADMINI~1\AppData\Local\Temp\*.*
	del /s /q /f C:\*.old 
	del /s /q /f C:\~*.bak 
	del /s /q /f C:\Windows\Cookies\*.*
	del /s /q /f C:\*.chk
	del /s /q /f C:\~*.*
	del /ah *.*
	
	rem Limpa o cache do navegador
	taskkill /f /im iexplore.exe
	del /s /q /f %userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*

	rem Limpa a lixeira
	rd /s /q /f %userprofile%\Recycle Bin

	rem Limpa a pasta de arquivos temporários
	del /s /q /f %systemroot%\Temp\*.*

	rem Limpa a pasta de arquivos de log
	del /s /q /f %systemroot%\System32\LogFiles\*.*
	
	cleanmgr /sagerun
		
	echo.
	echo.
	echo Limpeza Concluida !!!!
	echo.
	pause
	cls
goto menu


:2 
	cls
	winget source update
	winget upgrade --all 
	echo.
	echo.
	echo Programas Atualizados!!!!
	echo.
	pause
	cls
goto menu

:3
	cls
	dism /online /cleanup-image /checkhealth
	dism /online /cleanup-image /restorehealt
	sfc /scannow
	echo.
	echo.
	echo Reparacao Concluida!!!!
	echo.
	pause
	cls
goto menu

:4
	cls
	UsoClient StartScan
	USOClient.exe StartInteractiveScan
	UsoClient StartDownload
	UsoClient StartInstallWait
	UsoClient StartInstall
	echo.
	echo.
	echo Para concluir a atualizacao por favor reinicie o computador!!!!
	echo.
	set /p "rein=Deseja reiniciar (Y/n)?"

	if /i "%rein%"=="Y" (
		shutdown /r /t 0
	) else if /i "%rein%"=="n" (
		goto menu
	) else (
		echo Valor invalido! Por favor, digite apenas "Y" ou "n".
		pause
		cls
		goto :4
	)



:5
	cls
	REM Verifica se o Windows Defender está habilitado
	reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware >nul
	if %errorlevel% equ 0 (
		echo Windows Defender esta desabilitado. Habilite e tente novamente.
		goto menu
	)

	REM Inicia uma verificação rápida
	echo Iniciando verificacao rapida...
	"C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1

	REM Exclui arquivos suspeitos encontrados durante a verificação
	echo Excluindo arquivos suspeitos...
	"C:\Program Files\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All

	echo.
	echo.
	echo. Verificacao Concluida.
	echo.
	pause
	cls
goto menu

:6
	cls
	rem Desfragmentação
	defrag C:
	
	echo.
	echo.
	echo. Desfragmentacao Concluida!!!!
	echo.
	pause
	cls
goto menu

:7
	cls
	
	rem Verificar velocidade da memória RAM
	wmic memorychip get speed

	echo.
	echo.
	echo. Verificacao Concluida!!!!
	echo.
	pause
	cls
goto menu

:8
	cls
	
	wmic cpu get numberofLogicalProcessors
	echo.
	echo.
	echo. Verificacao Concluida!!!!
	echo.
	pause
	cls
goto menu
	
:0
	exit
