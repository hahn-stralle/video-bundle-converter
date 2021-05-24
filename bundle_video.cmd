@echo off
setlocal enabledelayedexpansion

rem 入力動画ファイルの対象拡張子一覧です。こちらに書かれなかった拡張子はスルーされ、対象から外れます。
set import_file_extension=.avi .mp4 .mkv

rem 出力ディレクトリパス。
set export_directory_path=C:\workbench\video\

set /a lap=0
for %%f in (%*) do (
	if !lap! equ 1 (
		if exist "%%f\" (
			cd %%f
			for /r %%r in (*) do (
				call :function %1 %%r
			)
			cd..
		) else (
			call :function %1 %%f
		)
	) else (
		set /a lap+=1
	)
)
endlocal
exit /b

:function
for %%e in (%import_file_extension%) do (
	if %~x2==%%e (
		rem 入力動画ファイルパスを一つずつ呼び出し元に返します。
		echo.
		%~dp0%1 return %2 %export_directory_path%
	)
)
exit /b