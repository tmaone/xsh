import Base:
    string,
    Sys,
    char,
    CPU_CORES

XSH_BIN = "xsh"
XSH_SYMBOL = string(char(0xb83))
XSH_PROGRAM = "$(XSH_BIN).$(XSH_SYMBOL)"
XSH_DESCRIPTION = "$(XSH_PROGRAM) v$(xsh.VERSION)"
XSH_DESCRIPTION_LONG = "$(XSH_PROGRAM) v$(xsh.VERSION) [$(Sys.MACHINE)-cpu$(CPU_CORES)]"
XSH_ARG_DESCRIPTION = "xsh. A modern shell environment for your terminal needs written in Julia language."
XSH_ARG_EPILOGUE = ""
XSH_ARG_USAGE = "usage: xsh [-hvqVdHilmnEce] <cmd> [script]"
