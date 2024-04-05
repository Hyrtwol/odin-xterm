package xterm

import "core:fmt"
import "core:intrinsics"
import win32 "core:sys/windows"

L :: intrinsics.constant_utf16_cstring
wstring :: win32.wstring
utf8_to_wstring :: win32.utf8_to_wstring
wstring_to_utf8 :: win32.wstring_to_utf8
CODEPAGE :: win32.CODEPAGE

has_terminal_colours := false
code_page := CODEPAGE.UTF8

wtprintf :: proc(col: rgb, format: string, args: ..any) -> win32.wstring {
	str := fmt.tprintf(format, ..args)
	return utf8_to_wstring(str)
}

wprint :: proc(col: rgb, wtext: wstring) {
	text, err := wstring_to_utf8(wtext, 256)
	if err != .None {return}
	print(col, text)
}

wprintln :: proc(col: rgb, wtext: wstring) {
	text, err := wstring_to_utf8(wtext, 256)
	if err != .None {return}
	println(col, text)
}

@(init)
init_console :: proc() {
	hnd := win32.GetStdHandle(win32.STD_ERROR_HANDLE)
	mode: win32.DWORD = 0
	if win32.GetConsoleMode(hnd, &mode) {
		if win32.SetConsoleMode(hnd, mode | win32.ENABLE_VIRTUAL_TERMINAL_PROCESSING) {
			has_terminal_colours = true
		}
	}
	win32.SetConsoleCP(code_page)
	win32.SetConsoleOutputCP(code_page)
}
