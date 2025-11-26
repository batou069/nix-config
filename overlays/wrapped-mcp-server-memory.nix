# pkgs/wrapped-mcp-server-memory.nix
# This package takes another package as an argument and wraps its binary.
{ pkgs
, original-mcp-server-memory
,
}:
pkgs.runCommand "wrapped-mcp-server-memory" { } ''
  mkdir -p $out/bin
  cat > $out/bin/wrapped-mcp-server-memory <<EOF
  #!${pkgs.bash}/bin/bash
  # This script executes the original binary with a persistent, writable storage path
  MEMORY_FILE="$HOME/.local/share/mcp/memory.json"
  mkdir -p "$(dirname "$MEMORY_FILE")"
  exec ${original-mcp-server-memory}/bin/mcp-server-memory --file "$MEMORY_FILE" "$@"
  EOF
  chmod +x $out/bin/wrapped-mcp-server-memory
''
