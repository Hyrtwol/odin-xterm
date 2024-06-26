// +vet
package test_xterm

import vt ".."
import "core:fmt"
import "core:unicode/utf8"
import "core:testing"

@(test)
verify_constants :: proc(t: ^testing.T) {
	exp := "\x1b"
	testing.expectf(t, vt.ESC == exp, "%v != %v", vt.ESC, exp)
	exp = "\x1b["
	testing.expectf(t, vt.CSI == exp, "%v != %v", vt.CSI, exp)
}

@(test)
xterm_init :: proc(t: ^testing.T) {
	testing.expectf(t, vt.has_terminal_colors == {.STD_OUTPUT, .STD_ERROR}, "%v", vt.has_terminal_colors)
}

@(test)
write_colors :: proc(t: ^testing.T) {
	col := vt.rgb{255, 200, 100}
	vt.printfln(col, "hello")
	fmt.println(vt.GRINNING_FACE)
	fmt.println(vt.BUG)
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

@(test)
check_unicode_blocks :: proc(t: ^testing.T) {
	testing.expectf(t, size_of(vt.FULL_BLOCK) == 16 , "%v != %v", size_of(vt.FULL_BLOCK), 16)
	testing.expectf(t, len(vt.FULL_BLOCK) == 3 , "%v != %v", len(vt.FULL_BLOCK), 3)
	testing.expectf(t, utf8.rune_count(vt.FULL_BLOCK) == 1 , "%v != %v", len(vt.FULL_BLOCK), 1)
}
