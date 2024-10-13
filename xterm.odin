#+vet
package xterm

import "core:encoding/ansi"
import "core:fmt"

terminal_color_flag :: enum {
	STD_OUTPUT,
	STD_ERROR,
}
enabled_virtual_terminal_processing: bit_set[terminal_color_flag] = {}

rgb :: [3]u8
rgba :: [4]u8
int2 :: [2]i32

print :: proc {
	fmt.print,
	rgb_print,
}

printf :: proc {
	fmt.printf,
	rgb_printf,
}

println :: proc {
	fmt.println,
	rgb_println,
}

printfln :: proc {
	fmt.printfln,
	rgb_printfln,
}

rgb_print :: #force_inline proc(col: rgb, args: ..any, sep := " ", flush := true) {
	set_foreground_color(col)
	print(args, sep = sep, flush = flush)
	restore_color()
}

rgb_printf :: #force_inline proc(col: rgb, format: string, args: ..any, flush := true) {
	set_foreground_color(col)
	printf(format, args = args, flush = flush)
	restore_color()
}

rgb_println :: #force_inline proc(col: rgb, args: ..any, sep := " ", flush := true) {
	rgb_print(col, args = args, sep = sep, flush = flush)
	println()
}

rgb_printfln :: #force_inline proc(col: rgb, format: string, args: ..any, flush := true) {
	rgb_printf(col, format, args = args, flush = flush)
	println()
}


rgb_set_foreground_color :: #force_inline proc(col: rgb) {
	printf(ansi.CSI + ansi.FG_COLOR_24_BIT + ";%d;%d;%d" + ansi.SGR, col.r, col.g, col.b)
}

rgb_set_background_color :: #force_inline proc(col: rgb) {
	printf(ansi.CSI + ansi.BG_COLOR_24_BIT + ";%d;%d;%d" + ansi.SGR, col.r, col.g, col.b)
}

rgba_set_foreground_color :: #force_inline proc(col: rgba) {
	rgb_set_foreground_color(col.rgb)
}

rgba_set_background_color :: #force_inline proc(col: rgba) {
	rgb_set_background_color(col.rgb)
}

set_foreground_color :: proc {
	rgb_set_foreground_color,
	rgba_set_foreground_color,
}

set_background_color :: proc {
	rgb_set_background_color,
	rgba_set_background_color,
}

restore_color :: #force_inline proc() {
	print(ansi.CSI + ansi.RESET + ansi.SGR)
}

enter_line_drawing_mode :: #force_inline proc() {
	print(ansi.ESC + "(0")
}

exit_line_drawing_mode :: #force_inline proc() {
	print(ansi.ESC + "(B")
}

set_cursor_position :: #force_inline proc(pos: int2) {
	printf(ansi.CSI + "%d;%d" + ansi.CUP, pos.x, pos.y)
}

set_cursor_position_home :: #force_inline proc() {
	print(ansi.CSI + ansi.CUP)
}

clear :: #force_inline proc(mode: i32) {
	print(ansi.CSI + "%d" + ansi.ED, mode)
}

vertical_bar :: proc() {
	// enter Line drawing mode
	enter_line_drawing_mode()
	// in line drawing mode, \x78 -> \u2502 "Vertical Bar"
	print("x")
	// exit line drawing mode
	exit_line_drawing_mode()
}

print_vertical_border :: proc(Size: int2, text: string) {
	print(ansi.CSI + ansi.BG_BRIGHT_BLUE + ";" + ansi.FG_BRIGHT_YELLOW + ansi.SGR) // bright yellow on bright blue
	vertical_bar()
	cc := int(Size.x - 2)
	l := len(text)
	if l > cc {
		print(text[:cc], flush = false)
	} else {
		print(text, flush = false)
		for _ in l ..< cc {print(" ", flush = false)}
	}

	vertical_bar()
	restore_color()
}

print_horizontal_border :: proc(Size: int2, fIsTop: bool) {
	// Enter Line drawing mode
	enter_line_drawing_mode()
	print(ansi.CSI + ansi.BG_BRIGHT_BLUE + ";" + ansi.FG_BRIGHT_YELLOW + ansi.SGR) // Make the border bright yellow on bright blue
	if fIsTop {print("l")} else {print("m")}
	// in line drawing mode, \x71 -> \u2500 "HORIZONTAL SCAN LINE-5"
	for _ in 1 ..< Size.x - 1 {print("q")}
	if fIsTop {print("k")} else {print("j")}
	restore_color()
	// exit line drawing mode
	exit_line_drawing_mode()
}
