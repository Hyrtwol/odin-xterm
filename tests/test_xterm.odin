#+vet
package test_xterm

import xt ".."
import "core:testing"
import "core:unicode/utf8"
import "core:encoding/ansi"

@(test)
verify_constants :: proc(t: ^testing.T) {
	exp := "\x1b"
	testing.expectf(t, ansi.ESC == exp, "%v != %v", ansi.ESC, exp)
	exp = "\x1b["
	testing.expectf(t, ansi.CSI == exp, "%v != %v", ansi.CSI, exp)
}

//@(test) not working with msbuild
xterm_init :: proc(t: ^testing.T) {
	testing.expectf(t, xt.enabled_virtual_terminal_processing == {.STD_OUTPUT, .STD_ERROR}, "%v", xt.enabled_virtual_terminal_processing)
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
