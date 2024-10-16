#+vet
package xterm_image_viewer

import "core:os"
import xt "../.."
import "core:fmt"
import "core:image"
import "core:image/png"

_ :: png

main :: proc() {
	path := "odin.png"
	img, err := image.load_from_file(path)
	if err != nil || img == nil {
		fmt.println("Image load error:", err, path)
		os.exit(int((cast(^u64)&err)^))
	}
	defer image.destroy(img)

	fmt.printfln("path: %s size: %d x %d channels: %d depth: %d", path, img.width, img.height, img.channels, img.depth)
	xt.print_image(img)
}
