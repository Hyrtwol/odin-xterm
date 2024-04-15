//+build windows
package xterm

import "core:fmt"
import "core:intrinsics"
import win32 "core:sys/windows"

L :: intrinsics.constant_utf16_cstring
wstring :: win32.wstring
utf8_to_wstring :: win32.utf8_to_wstring
wstring_to_utf8 :: win32.wstring_to_utf8
CODEPAGE :: win32.CODEPAGE

code_page := CODEPAGE.UTF8

@(init)
init_console :: proc() {
	hnd := win32.GetStdHandle(win32.STD_ERROR_HANDLE)
	mode: win32.DWORD = 0
	if win32.GetConsoleMode(hnd, &mode) {
		if win32.SetConsoleMode(hnd, mode | win32.ENABLE_VIRTUAL_TERMINAL_PROCESSING) {
			has_terminal_colours = true
		}
	}

	cpi, cpo := win32.GetConsoleCP(), win32.GetConsoleOutputCP()
	if cpi != code_page {
		if !win32.SetConsoleCP(code_page) {fmt.panicf("Unable to set codepage to %v", code_page)}
	}
	if cpo != code_page {
		if !win32.SetConsoleOutputCP(code_page) {fmt.panicf("Unable to set codepage to %v", code_page)}
	}
}
