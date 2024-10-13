#+vet
package colors

import xt "../.."
import "core:fmt"
import "core:time"
import "core:unicode/utf8"

list :: proc(uc: string, cnt: int = 64) {
	ch, _ := utf8.decode_rune(uc)
	for i in 0 ..< cnt {
		fmt.print(ch + rune(i))
		//fmt.print("\r")
		time.sleep(time.Millisecond * 100)
	}
	fmt.println()
}

main :: proc() {
	fmt.println("enabled_virtual_terminal_processing:", xt.enabled_virtual_terminal_processing)
	col := xt.rgb{255, 200, 100}
	xt.printfln(col, "hello")
	fmt.println(xt.GRINNING_FACE)
	fmt.println(xt.BUG)

	list(xt.GRINNING_FACE)
	list(xt.RAT)
	list(xt.HOT_DOG)

	fmt.println("bye", "bye")
}
