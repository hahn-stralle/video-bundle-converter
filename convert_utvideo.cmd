@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem 出力動画ファイル拡張子。
set export_file_extension=.utvideo

rem 一時的動画ファイル拡張子。
set temporary_file_extension=.avi

rem 出力ディレクトリパス追記。
set export_directory_path=%3%export_file_extension%\

if not %1==return (
	call %~dp0bundle_video.cmd %~nx0 %*
) else (
	rem 入力動画ファイルをutvideoに変換して出力します。
	mkdir %export_directory_path% 2>nul
	echo ◇これから処理を行う動画ファイル。%2
	set /p size="◇HD解像度にリサイズしますか？(y=はい。/y以外=いいえ。)>"
	if !size!==y (
		set size= -s 1280x720
	) else (
		set size=
	)
	ffmpeg -i %2 -an!size! -r 24 -c:v utvideo %export_directory_path%%~n2%temporary_file_extension%
	cd %export_directory_path%
	ren %~n2%temporary_file_extension% %~n2%export_file_extension%
	cd %~dp0
)
endlocal
exit /b