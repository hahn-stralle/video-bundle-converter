@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem 出力ディレクトリパス追記。
set export_directory_path=%3.sector\

if not %1==return (
	call %~dp0bundle_video.cmd %~nx0 %*
) else (
	rem 入力動画ファイルを抽出して無劣化出力します。
	:loop
	echo ◇これから抽出を行う動画ファイル。%2
	set /p time_begin="◇抽出開始の時刻を入力してください。(hh:mm:ss)>"
	set /p time_end="◇抽出終了の時刻を入力してください。(hh:mm:ss)>"
	mkdir %export_directory_path% 2>nul
	ffmpeg -i %2 -ss !time_begin! -to !time_end! -an -c:v copy %export_directory_path%%~n2___be!time_begin::=!_en!time_end::=!%~x2
	set /p loop="◇もう一度、同じ動画ファイルで抽出をしますか？(y=はい。/y以外=いいえ。)>"
	if !loop!==y (
		set loop=n
		echo.
		goto :loop
	)
)
endlocal
exit /b
