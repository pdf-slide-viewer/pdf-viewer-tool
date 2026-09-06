@echo off
cd /d "%~dp0"
set "PORT=8777"
set "PY="

rem Python があるか実際に動かして確かめる
rem （where だけだと Windows 標準の Microsoft Store スタブに騙される）
py -3 -c "pass" >nul 2>&1
if not errorlevel 1 set "PY=py -3"
if not defined PY (
  python -c "pass" >nul 2>&1
  if not errorlevel 1 set "PY=python"
)
if not defined PY goto direct

echo ローカルサーバーを起動します: http://localhost:%PORT%/
echo このウィンドウを閉じるとサーバーも停止します。
echo.
start "" /b cmd /c "ping -n 2 127.0.0.1 >nul & start http://localhost:%PORT%/index.html"
%PY% -m http.server %PORT% --bind 127.0.0.1
echo.
echo サーバーが終了しました。
echo ポート %PORT% が他のソフトに使われている可能性があります。
pause
goto :eof

:direct
echo Python が見つかりませんでした。index.html を直接開きます。
echo そのまま問題なく使えます。ページ送りが重いと感じたときだけ、
echo Python を入れてからこのファイルで起動してください。
echo.
start "" "%~dp0index.html"
