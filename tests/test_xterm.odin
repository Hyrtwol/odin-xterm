package test_xterm

import vt ".."
import "core:bytes"
import "core:fmt"
import "core:runtime"
import "core:testing"
import win32 "core:sys/windows"
//import _o "shared:ounit"

@(test)
verify_constants :: proc(t: ^testing.T) {
	exp := "\x1b"
	testing.expectf(t, vt.ESC == exp, "%v != %v", vt.ESC, exp)
	exp = "\x1b["
	testing.expectf(t, vt.CSI == exp, "%v != %v", vt.CSI, exp)
}

@(test)
xterm_init :: proc(t: ^testing.T) {
	testing.expectf(t, vt.code_page == vt.CODEPAGE.UTF8, "%v != %v", vt.code_page, win32.CODEPAGE.UTF8)
	testing.expectf(t, vt.has_terminal_colours, "%v != %v", vt.has_terminal_colours, true)
}

@(test)
write_colors :: proc(t: ^testing.T) {
	col := vt.rgb{255, 200, 100}
	vt.printfln(col, "hello")
	fmt.println("bye", "bye")
}

@(test)
write_border :: proc(t: ^testing.T) {
	size := vt.int2{10,10}
	vt.print_horizontal_border(size, true)
	fmt.println()
	vt.print_vertical_border(size, "Hello")
	fmt.println()
	vt.print_horizontal_border(size, false)
	fmt.println()
}
