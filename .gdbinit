# Disables auto-download messages
set debuginfod enabled off
# Disables output pagination. Don't pause long output with --More--
set pagination off
# Allow breakpoints in not-yet-loaded libs
set breakpoint pending on
# Auto breakpoint at exit
b exit
