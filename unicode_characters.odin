package xterm

/*
https://home.unicode.org/
https://unicode.org/charts/nameslist/
https://unicode.org/charts/nameslist/n_2580.html
https://en.wikipedia.org/wiki/Block_Elements
https://en.wikipedia.org/wiki/Box_Drawing
https://vt100.net/docs/vt220-rm/chapter2.html#T2-4

		0	1	2	3	4	5	6	7	8	9	A	B	C	D	E	F
U+258x	▀	▁	▂	▃	▄	▅	▆	▇	█	▉	▊	▋	▌	▍	▎	▏
U+259x	▐	░	▒	▓	▔	▕	▖	▗	▘	▙	▚	▛	▜	▝	▞	▟

*/

upper_half_block									:: "\u2580" // ▀
lower_one_eighth_block								:: "\u2581" // ▁
lower_one_quarter_block								:: "\u2582" // ▂
lower_three_eighths_block							:: "\u2583" // ▃
lower_half_block									:: "\u2584" // ▄
lower_five_eighths_block							:: "\u2585" // ▅
lower_three_quarters_block							:: "\u2586" // ▆
lower_seven_eighths_block							:: "\u2587" // ▇
full_block											:: "\u2588" // █
left_seven_eighths_block							:: "\u2589" // ▉
left_three_quarters_block							:: "\u258A" // ▊
left_five_eighths_block								:: "\u258B" // ▋
left_half_block										:: "\u258C" // ▌
left_three_eighths_block							:: "\u258D" // ▍
left_one_quarter_block								:: "\u258E" // ▎
left_one_eighth_block								:: "\u258F" // ▏
right_half_block									:: "\u2590" // ▐
light_shade											:: "\u2591" // ░
medium_shade										:: "\u2592" // ▒
dark_shade											:: "\u2593" // ▓
upper_one_eighth_block								:: "\u2594" // ▔
right_one_eighth_block								:: "\u2595" // ▕
quadrant_lower_left									:: "\u2596" // ▖
quadrant_lower_right								:: "\u2597" // ▗
quadrant_upper_left									:: "\u2598" // ▘
quadrant_upper_left_and_lower_left_and_lower_right	:: "\u2599" // ▙
quadrant_upper_left_and_lower_right					:: "\u259A" // ▚
quadrant_upper_left_and_upper_right_and_lower_left	:: "\u259B" // ▛
quadrant_upper_left_and_upper_right_and_lower_right	:: "\u259C" // ▜
quadrant_upper_right								:: "\u259D" // ▝
quadrant_upper_right_and_lower_left					:: "\u259E" // ▞
quadrant_upper_right_and_lower_left_and_lower_right	:: "\u259F" // ▟

middle_dot     :: "\u00B7" // ·
no_break_space :: "\u00A0" // nbsp
