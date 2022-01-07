title=OBS Grading Scopes (Virtual Camera)
set /a cpuT=%NUMBER_OF_PROCESSORS%-1
goto :instruction
:scope
ffplay -hide_banner -filter_threads %cpuT% -an -sn ^
-f dshow -i video="OBS Virtual Camera" ^
-window_title "OBS Virtual Camera" ^
-vf split=3[parade][luma][vector];^

[vector]format=yuv420p,^
vectorscope=mode=color4:colorspace=709:graticule=invert:flags=white+name,^
drawbox=w=4:h=4:t=1:x=104-2:y=98-2:c=invert,^
drawbox=w=4:h=4:t=1:x=110-2:y=106-2:c=invert,^
drawbox=w=4:h=4:t=1:x=116-2:y=113-2:c=invert,^
drawbox=w=4:h=4:t=1:x=122-2:y=120-2:c=invert^
[vector];^

[luma]scale=256:ih,format=yuv420p,^
waveform=filter=lowpass:scale=ire:graticule=orange:flags=dots+numbers^
[luma];^

[parade]scale=512:ih,format=gbrp,^
waveform=filter=lowpass:components=7:display=overlay^
[parade];^

[luma][vector]hstack[yuv],[yuv][parade]vstack
if errorlevel 9009 (
	cls
	title=OBS Grading Scopes - Error
	ffplay
	echo.
	echo Missing FFplay.exe software.
	echo Please check your user Environment Variables in system settings.
	echo.
	echo You can download FFplay packages at:
	echo https://ffmpeg.org
	echo.
	echo ...press any key to visit download website
	pause
	start https://ffmpeg.org/download.html#build-windows
	goto :eof
)
echo.
pause
cls
:instruction
echo  Key bindings:
echo  ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo  ³"Q",ESC ³ Quit              ³
echo  ³"F"     ³ Toggle full-screen³
echo  ³"P",SPC ³ Pause             ³
echo  ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo.
goto :scope
