# Use Intel syntax for disassembly (instead of the default AT&T syntax)
set disassembly-flavor intel

# Disable debuginfod (avoid GDB trying to auto-fetch debug info from the network)
set debuginfod enabled off

# Target architecture is MIPS (for router/embedded firmware analysis, e.g. RTL8196E-based devices)
set architecture mips

# Enable the TUI (Text User Interface) — split-pane view instead of plain command-line GDB
tui enable

# TUI layout: show disassembly alongside source/command window
layout asm

# TUI layout: also show the registers window
layout regs

# Keep keyboard focus on the command window (so typing goes to the GDB prompt, not the TUI panes)
focus cmd

# Custom command: "connect" — sets up a remote debugging session
# Usage: just type `connect` at the GDB prompt
define connect
  # Connect to a remote gdbserver/stub listening on this IP:port
  # (update the IP/port to match your target device, e.g. qemu -s or a router's gdbserver)
  target remote 192.168.1.1:1234
end
