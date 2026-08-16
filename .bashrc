# Only the reusable bit worth tracking — machine-specific PATH/env exports
# (Ruby gems, Ghidra, PYTHONPATH, etc.) are left out of this repo on purpose.

# zoxide: smarter `cd` that jumps to frecent directories (`z <partial-name>`)
eval "$(zoxide init bash)"
