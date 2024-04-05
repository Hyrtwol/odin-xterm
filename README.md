# Virtual Terminal

Console Virtual Terminal aka xterm

To use the lib clone it in the shared folder in the odin root.

```bat
cd %ODIN_ROOT%
git clone ssh://git@gitea.ontogenesis.com:2222/odin/odin-xterm.git shared/xterm
```

- <https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences>
- <https://learn.microsoft.com/en-us/windows/console/registering-a-control-handler-function>
- <https://invisible-island.net/xterm/ctlseqs/ctlseqs.html>
- <https://vt100.net/>
- <https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#screen-colors>

```txt
38 ; 2 ; <r> ; <g> ; <b>	Set foreground color to RGB value specified in <r>, <g>, <b> parameters*
48 ; 2 ; <r> ; <g> ; <b>	Set background color to RGB value specified in <r>, <g>, <b> parameters*

ESC :: "\x1b"
CSI :: "\x1b["

ESC [ <n> A	CUU	Cursor Up	Cursor up by <n>
ESC [ <n> B	CUD	Cursor Down	Cursor down by <n>
ESC [ <n> C	CUF	Cursor Forward	Cursor forward (Right) by <n>
ESC [ <n> D	CUB	Cursor Backward	Cursor backward (Left) by <n>
ESC [ <n> E	CNL	Cursor Next Line	Cursor down <n> lines from current position
ESC [ <n> F	CPL	Cursor Previous Line	Cursor up <n> lines from current position
ESC [ <n> G	CHA	Cursor Horizontal Absolute	Cursor moves to <n>th position horizontally in the current line
ESC [ <n> d	VPA	Vertical Line Position Absolute	Cursor moves to the <n>th position vertically in the current column
ESC [ <y> ; <x> H	CUP	Cursor Position	*Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
ESC [ <y> ; <x> f	HVP	Horizontal Vertical Position	*Cursor moves to <x>; <y> coordinate within the viewport, where <x> is the column of the <y> line
ESC [ s	ANSISYSSC	Save Cursor – Ansi.sys emulation	**With no parameters, performs a save cursor operation like DECSC
ESC [ u	ANSISYSRC	Restore Cursor – Ansi.sys emulation	**With no parameters, performs a restore cursor operation like DECRC

ESC [ <n> S	SU	Scroll Up	Scroll text up by <n>. Also known as pan down, new lines fill in from the bottom of the screen
ESC [ <n> T	SD	Scroll Down	Scroll down by <n>. Also known as pan up, new lines fill in from the top of the screen

ESC ] 4 ; <i> ; rgb : <r> / <g> / <b> <ST>	Modify Screen Colors	Sets the screen color palette index <i> to the RGB values specified in <r>, <g>, <b>


38 ; 2 ; <r> ; <g> ; <b>	Set foreground color to RGB value specified in <r>, <g>, <b> parameters*
48 ; 2 ; <r> ; <g> ; <b>	Set background color to RGB value specified in <r>, <g>, <b> parameters*
38 ; 5 ; <s>	Set foreground color to <s> index in 88 or 256 color table*
48 ; 5 ; <s>	Set background color to <s> index in 88 or 256 color table*

// Try some Set Graphics Rendition (SGR) terminal escape sequences
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

fmt.printf("\x1B[38;2;%d;%d;%dm%s\033[0m", col.b, col.g, col.r, block)

// Write the sequence for clearing the display.
DWORD written = 0;
PCWSTR sequence = L"\x1b[2J";

//fmt.print("\x1b[2J") // clear ?
//fmt.print("\x1b[3J") // clear ?
//fmt.print("\x1b[H")
```
