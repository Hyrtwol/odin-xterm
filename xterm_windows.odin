#+build windows
package xterm

import "base:intrinsics"
import "core:fmt"
import win32 "core:sys/windows"

OS_NEWLINE :: "\r\n"
OS_LIST_SEP :: ";"

wanted_code_page := win32.CODEPAGE.UTF8

L :: intrinsics.constant_utf16_cstring
wstring :: win32.wstring
utf8_to_wstring :: win32.utf8_to_wstring
wstring_to_utf8 :: win32.wstring_to_utf8

@(init)
init_console :: proc() {
	enable_virtual_terminal_processing :: proc(which: win32.DWORD) -> bool {
		hnd := win32.GetStdHandle(which)
		mode: win32.DWORD = 0
		if win32.GetConsoleMode(hnd, &mode) {
			if win32.SetConsoleMode(hnd, mode | win32.ENABLE_VIRTUAL_TERMINAL_PROCESSING) {
				return true
			}
		}
		return false
	}
	has_terminal_colors = {}
	if enable_virtual_terminal_processing(win32.STD_OUTPUT_HANDLE) {
		has_terminal_colors |= {.STD_OUTPUT}
	}
	if enable_virtual_terminal_processing(win32.STD_ERROR_HANDLE) {
		has_terminal_colors |= {.STD_ERROR}
	}

	cpi, cpo := win32.GetConsoleCP(), win32.GetConsoleOutputCP()
	if cpi != wanted_code_page {
		if !win32.SetConsoleCP(wanted_code_page) {fmt.panicf("Unable to set codepage to %v", wanted_code_page)}
	}
	if cpo != wanted_code_page {
		if !win32.SetConsoleOutputCP(wanted_code_page) {fmt.panicf("Unable to set codepage to %v", wanted_code_page)}
	}
}
