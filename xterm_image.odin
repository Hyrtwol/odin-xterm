// +vet
package xterm

import "core:bytes"
import "core:image"

print_image :: proc(img: ^image.Image, dot_alpha: bool = false) -> int {
	pix: []byte = bytes.buffer_to_bytes(&img.pixels)

	if len(pix) == 0 || len(pix) < img.width * img.height * int(img.channels) {
		return 1
	}

	space_block := dot_alpha ? middle_dot : no_break_space

	dp := img.depth
	switch dp {
	case 8:
		ch := img.channels
		w, h := img.width, img.height
		wb := w * ch
		switch ch {
		case 3:
			cf, cb: rgb
			i, yb, yf: int
			for k in 0 ..< h / 2 {
				yb = (k * 2) * wb
				yf = yb + wb
				for x in 0 ..< w {
					i = x * ch
					cb = ((^rgb)(&pix[yb + i]))^
					cf = ((^rgb)(&pix[yf + i]))^

					set_background_color(cb)
					set_foreground_color(cf)
					print(lower_half_block)
				}

				restore_color()
				println()
			}
		case 4:
			cf, cb: rgba
			i, yb, yf: int
			for k in 0 ..< h / 2 {
				yb = (k * 2) * wb
				yf = yb + wb
				for x in 0 ..< w {
					i = x * ch
					cb = ((^rgba)(&pix[yb + i]))^
					cf = ((^rgba)(&pix[yf + i]))^

					flg := (int(cb.a > 0) & 1) | ((int(cf.a > 0) & 1) << 1)

					switch flg {
					case 0:
						restore_color()
						print(space_block)
					case 1:
						restore_color()
						set_foreground_color(cb.rgb)
						print(upper_half_block)
					case 2:
						restore_color()
						set_foreground_color(cf.rgb)
						print(lower_half_block)
					case 3:
						set_background_color(cb.rgb)
						set_foreground_color(cf.rgb)
						print(lower_half_block)
					}
				}

				restore_color()
				println()
			}
		case:
			return 3
		}
	case:
		return 2
	}
	return 0
}
