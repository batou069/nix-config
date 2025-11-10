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
  # This script executes the original binary but redirects its stderr to /dev/null
  ${original-mcp-server-memory}/bin/mcp-server-memory "$@" 2>/dev/null
  EOF
  chmod +x $out/bin/wrapped-mcp-server-memory
''
