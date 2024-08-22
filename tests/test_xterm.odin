// +vet
package test_xterm

import xt ".."
import "core:fmt"
import "core:testing"
import "core:unicode/utf8"

@(test)
verify_constants :: proc(t: ^testing.T) {
	exp := "\x1b"
	testing.expectf(t, xt.ESC == exp, "%v != %v", xt.ESC, exp)
	exp = "\x1b["
	testing.expectf(t, xt.CSI == exp, "%v != %v", xt.CSI, exp)
}

@(test)
xterm_init :: proc(t: ^testing.T) {
	testing.expectf(t, xt.has_terminal_colors == {.STD_OUTPUT, .STD_ERROR}, "%v", xt.has_terminal_colors)
}

@(test)
write_colors :: proc(t: ^testing.T) {
	col := xt.rgb{255, 200, 100}
	xt.printfln(col, "hello")
	fmt.println(xt.GRINNING_FACE)
	fmt.println(xt.BUG)
	fmt.println("bye", "bye")
}

@(test)
write_border :: proc(t: ^testing.T) {
	size := xt.int2{10, 10}
	xt.print_horizontal_border(size, true)
	fmt.println()
	xt.print_vertical_border(size, "Hello")
	fmt.println()
	xt.print_horizontal_border(size, false)
	fmt.println()
}

@(test)
check_unicode_blocks :: proc(t: ^testing.T) {
	testing.expectf(t, size_of(xt.FULL_BLOCK) == 16, "%v != %v", size_of(xt.FULL_BLOCK), 16)
	testing.expectf(t, len(xt.FULL_BLOCK) == 3, "%v != %v", len(xt.FULL_BLOCK), 3)
	testing.expectf(t, utf8.rune_count(xt.FULL_BLOCK) == 1, "%v != %v", len(xt.FULL_BLOCK), 1)
}

@(test)
verify_ascii :: proc(t: ^testing.T) {
	testing.expect_value(t, u8(xt.control_characters.BEL), u8('\a'))
	testing.expect_value(t, u8(xt.control_characters.BS), u8('\b'))
	testing.expect_value(t, u8(xt.control_characters.TAB), u8('\t'))
	testing.expect_value(t, u8(xt.control_characters.LF), u8('\n'))
	testing.expect_value(t, u8(xt.control_characters.VT), u8('\v'))
	testing.expect_value(t, u8(xt.control_characters.FF), u8('\f'))
	testing.expect_value(t, u8(xt.control_characters.CR), u8('\r'))
}
