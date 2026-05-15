on run
	set homePath to POSIX path of (path to home folder)
	
	set wordFile to (POSIX file (homePath & "Downloads/toeic_word/memo.docx")) as alias
	set excelFile1 to (POSIX file (homePath & "Downloads/toeic_word/result.xlsx")) as alias
	set excelFile2 to (POSIX file (homePath & "Downloads/toeic_word/words.xlsx")) as alias
	
	-- 調整値
	set dockOffset to 40 -- 左Dockぶんの余白
	set topMargin to 20 -- 上の少し余白
	set rightMargin to 10
	set bottomMargin to 10
	set verticalShift to 80 -- 上下の分割線を上にずらす量
	
	tell application "Finder"
		set screenBounds to bounds of window of desktop
	end tell
	
	set screenLeft to item 1 of screenBounds
	set screenTop to item 2 of screenBounds
	set screenRight to item 3 of screenBounds
	set screenBottom to item 4 of screenBounds
	
	-- Dockと余白を考慮した作業領域
	set workLeft to screenLeft + dockOffset
	set workTop to screenTop + topMargin
	set workRight to screenRight - rightMargin
	set workBottom to screenBottom - bottomMargin
	
	-- 左右中央
	set midX to (workLeft + workRight) / 2
	
	-- 通常の半分より少し上に分割線を置く
	set normalMidY to (workTop + workBottom) / 2
	set midY to normalMidY - verticalShift
	
	-- 念のため極端にならないように補正
	if midY < (workTop + 150) then set midY to workTop + 150
	if midY > (workBottom - 150) then set midY to workBottom - 150
	
	-- 左上: result.xlsx
	tell application "Microsoft Excel"
		activate
		open excelFile1
		delay 1.5
		set bounds of front window to {workLeft, workTop, midX, midY}
	end tell
	
	-- 右上: Safari
	tell application "Safari"
		activate
		open location "https://www.google.com"
		delay 1.5
		set bounds of front window to {midX, workTop, workRight, midY}
	end tell
	
	-- 右下: memo.docx
	tell application "Microsoft Word"
		activate
		open wordFile
		delay 1.5
		set bounds of front window to {midX, midY, workRight, workBottom}
	end tell
	
	-- 左下: words.xlsx
	tell application "Microsoft Excel"
		activate
		open excelFile2
		delay 1.5
		set bounds of front window to {workLeft, midY, midX, workBottom}
	end tell
end run