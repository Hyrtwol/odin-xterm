// +vet
package xterm

import "core:bytes"
import "core:image"

print_image :: proc(img: ^image.Image) -> int {
	pix: []byte = bytes.buffer_to_bytes(&img.pixels)

	if len(pix) == 0 || len(pix) < img.width * img.height * int(img.channels) {
		return 1
	}

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

					if cb.a == 0 || cf.a == 0 {
						restore_color()
						if cb.a == 0 && cf.a == 0 {
							//print(middle_dot)
							print(no_break_space)
						} else {
							if cb.a > 0 {
								//set_background_color(cb.rgb)
								//print(lower_half_block)
								set_foreground_color(cb.rgb)
								print(upper_half_block)
							} else {
								set_foreground_color(cf.rgb)
								print(lower_half_block)
							}
						}

					} else {
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
