# xterm

Console Virtual Terminal

To use the lib clone it in the shared folder in the odin root.

```bat
cd %ODIN_ROOT%
git clone ssh://git@gitea.ontogenesis.com:2222/odin/odin-xterm.git shared/xterm
```

## Virtual Terminal

- <https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences>
- <https://learn.microsoft.com/en-us/windows/console/registering-a-control-handler-function>
- <https://invisible-island.net/xterm/ctlseqs/ctlseqs.html>
- <https://vt100.net/>
- <https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#screen-colors>
- <https://en.wikipedia.org/wiki/ANSI_escape_code>

## Unicode

- <https://home.unicode.org/>
- <https://unicode.org/charts/nameslist/>
- <https://unicode.org/charts/nameslist/n_2580.html>
- <https://en.wikipedia.org/wiki/Block_Elements>
- <https://en.wikipedia.org/wiki/Box_Drawing>
- <https://vt100.net/docs/vt220-rm/chapter2.html#T2-4>

## Terminal Sequences

```txt
ESC :: "\x1b"
CSI :: "\x1b["
```

Command								| Sequence										| Description
------------------------------------|-----------------------------------------------|------------
Cursor Up							| `ESC [ <n> A	CUU`	                        | Cursor up by `<n>`
Cursor Down							| `ESC [ <n> B	CUD`	                        | Cursor down by `<n>`
Cursor Forward						| `ESC [ <n> C	CUF`	                        | Cursor forward (Right) by `<n>`
Cursor Backward						| `ESC [ <n> D	CUB`	                        | Cursor backward (Left) by `<n>`
Cursor Next Line					| `ESC [ <n> E	CNL`                            | Cursor down `<n>` lines from current position
Cursor Previous Line				| `ESC [ <n> F	CPL`                            | Cursor up `<n>` lines from current position
Cursor Horizontal Absolute			| `ESC [ <n> G	CHA`                            | Cursor moves to `<n>`th position horizontally in the current line
Vertical Line Position Absolute		| `ESC [ <n> d	VPA`                            | Cursor moves to the `<n>`th position vertically in the current column
Cursor Position						| `ESC [ <y> ; <x> H	CUP`	                | *Cursor moves to `<x>`; `<y>` coordinate within the viewport, where `<x>` is the column of the `<y>` line
Horizontal Vertical Position		| `ESC [ <y> ; <x> f	HVP`	                | *Cursor moves to `<x>`; `<y>` coordinate within the viewport, where `<x>` is the column of the `<y>` line
Save Cursor – Ansi.sys emulation	| `ESC [ s	ANSISYSSC`	                        | **With no parameters, performs a save cursor operation like DECSC
Restore Cursor – Ansi.sys emulation	| `ESC [ u	ANSISYSRC`	                        | **With no parameters, performs a restore cursor operation like DECRC
Scroll Up							| `ESC [ <n> S	SU`	                            | Scroll text up by `<n>`. Also known as pan down, new lines fill in from the bottom of the screen
Scroll Down							| `ESC [ <n> T	SD`	                            | Scroll down by `<n>`. Also known as pan up, new lines fill in from the top of the screen
Modify Screen Colors				| `ESC ] 4 ; <i> ; rgb : <r> / <g> / <b> <ST>`	| Sets the screen color palette index `<i>` to the RGB values specified in `<r>`, `<g>`, `<b>`
Set foreground color				| `38 ; 2 ; <r> ; <g> ; <b>`	                | Set foreground color to RGB value specified in `<r>`, `<g>`, `<b>` parameters*
Set background color				| `48 ; 2 ; <r> ; <g> ; <b>`	                | Set background color to RGB value specified in `<r>`, `<g>`, `<b>` parameters*
Set foreground color				| `38 ; 5 ; <s>`	                            | Set foreground color to `<s>` index in 88 or 256 color table*
Set background color				| `48 ; 5 ; <s>`	                            | Set background color to `<s>` index in 88 or 256 color table*


Try some Set Graphics Rendition (SGR) terminal escape sequences

```c
wprintf(L"\x1b[31mThis text has a red foreground using SGR.31.\r\n");
wprintf(L"\x1b[1mThis text has a bright (bold) red foreground using SGR.1 to affect the previous color setting.\r\n");
wprintf(L"\x1b[mThis text has returned to default colors using SGR.0 implicitly.\r\n");
wprintf(L"\x1b[34;46mThis text shows the foreground and background change at the same time.\r\n");
wprintf(L"\x1b[0mThis text has returned to default colors using SGR.0 explicitly.\r\n");
wprintf(L"\x1b[31;32;33;34;35;36;101;102;103;104;105;106;107mThis text attempts to apply many colors in the same command. Note the colors are applied from left to right so only the right-most option of foreground cyan (SGR.36) and background bright white (SGR.107) is effective.\r\n");
wprintf(L"\x1b[39mThis text has restored the foreground color only.\r\n");
wprintf(L"\x1b[49mThis text has restored the background color only.\r\n");

printf(CSI "0m"); // restore color

printf(ESC "(0"); // Enter Line drawing mode
printf(ESC "(B"); // exit line drawing mode

// Write the sequence for clearing the display.
printf("\x1b[2J")
printf("\x1b[3J")
printf("\x1b[H")
```
