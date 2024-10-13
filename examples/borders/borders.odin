#+vet
package borders

import xt "../.."
import "core:fmt"

main :: proc() {
	size := xt.int2{10, 10}
	fmt.println("xterm border demo")
	xt.print_horizontal_border(size, true)
	fmt.println()
	xt.print_vertical_border(size, "Hello")
	fmt.println()
	xt.print_horizontal_border(size, false)
	fmt.println()
}
