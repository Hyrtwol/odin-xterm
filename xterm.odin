package xterm

import "core:fmt"
import "core:strings"

ESC :: "\x1B"
CSI :: ESC + "["

rgb :: [3]u8
int2 :: [2]i32

set_foreground_color :: #force_inline proc(col: rgb) {
	fmt.printf("%s38;2;%d;%d;%dm", CSI, col.r, col.g, col.b)
}

set_background_color :: #force_inline proc(col: rgb) {
	fmt.printf("%s48;2;%d;%d;%dm", CSI, col.r, col.g, col.b)
}

restore_color :: #force_inline proc() {
	fmt.printf("%s0m", CSI)
}

enter_line_drawing_mode :: #force_inline proc() {
	fmt.printf("%s(0", CSI)
}

exit_line_drawing_mode :: #force_inline proc() {
	fmt.printf("%s(B", CSI)
}

set_cursor_position :: #force_inline proc(pos: int2) {
	fmt.printf("%s%d;%dH", CSI, pos.x, pos.y)
}

set_cursor_position_home :: #force_inline proc() {
	fmt.printf("%sH", CSI)
}

clear :: #force_inline proc(mode: i32) {
	fmt.printf("%s%dJ", CSI, mode)
}

vertical_bar :: proc() {
	// Enter Line drawing mode
	// in line drawing mode, \x78 -> \u2502 "Vertical Bar"
	// exit line drawing mode
	fmt.print(ESC + "(0" + "x" + ESC + "(B")
}

print_vertical_border :: proc(Size: int2, text: string) {
	fmt.print(CSI + "104;93m") // bright yellow on bright blue
	vertical_bar()
	cc := int(Size.x - 2)
	l := len(text)
	if l > cc {
		fmt.print(text[:cc], flush = false)
	} else {
		fmt.print(text, flush = false)
		for _ in l ..< cc {fmt.print(" ", flush = false)}
	}

	vertical_bar()
	restore_color()
}

print_horizontal_border :: proc(Size: int2, fIsTop: bool) {
	fmt.print(ESC + "(0") // Enter Line drawing mode
	fmt.print(CSI + "104;93m") // Make the border bright yellow on bright blue
	if fIsTop {fmt.print("l")} else {fmt.print("m")}
	// in line drawing mode, \x71 -> \u2500 "HORIZONTAL SCAN LINE-5"
	for _ in 1 ..< Size.x - 1 {fmt.print("q")}
	if fIsTop {fmt.print("k")} else {fmt.print("j")}
	restore_color()
	fmt.print(ESC + "(B") // exit line drawing mode
}

print :: proc(col: rgb, args: ..any) {
	set_foreground_color(col)
	fmt.print(args)
	restore_color()
}

_print :: proc {
	fmt.print,
	print,
}

println :: proc(col: rgb, text: string) {
	print(col, text)
	fmt.println()
}

printf :: proc(col: rgb, format: string, args: ..any, flush := true) {
	set_foreground_color(col)
	fmt.printf(format, args = args, flush = flush)
	restore_color()
}

printfln :: proc(col: rgb, format: string, args: ..any, flush := true) {
	printf(col, format, args = args, flush = flush)
	fmt.println()
}
