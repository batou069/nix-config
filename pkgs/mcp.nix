# /home/lf/nix/pkgs/mcp.nix
# This file defines the MCP (Model Context Protocol) servers to be installed on your system.
{ pkgs }:

let
  # The `mcp-server-fetch` utility is the core of adding new servers.
  # It's available on `pkgs` because you added the mcp-servers-nix overlay.
  mcp-server-fetch = pkgs.mcp-server-fetch;

  # --- Define Your MCP Servers Below ---

  # Each server is defined as a separate attribute in this `let` block.
  # You can fetch them from GitHub or any other source supported by Nix.

  # Example: The nixos-mcp-tools you are already using.
  # This gives the model (me) the ability to use nixos-search, nixos-info, etc.
  nixos-mcp-tools = mcp-server-fetch {
    name = "nixos-mcp-tools";
    version = "1.0.0"; # This is for information, the `rev` is what matters for git sources
    src = pkgs.fetchFromGitHub {
      owner = "natsukium";
      repo = "nixos-mcp-tools";
      # It's best to pin to a specific commit hash for reproducibility.
      rev = "651e7e2d088af252a8aff338882e80001cf0d366";
      # The sha256 hash ensures the source code is what you expect.
      # If the revision changes, this hash MUST be updated.
      sha256 = "sha256-Yd5Cj25Vv5A+aL8iYTfC2F8vj2wYj2wYj2wYj2wYj2w="; # Replace with the correct hash
    };
  };

  # Add another server here, for example:
  context7 = mcp-server-fetch {
    name = "context7";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "upstash";
      repo = "context7";
      rev = "d2083b92a79ec02579e75e2fac6548c057b8c0a8";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with the correct hash
    };
  };

in
  # --- List the Servers to Install ---
  # This list determines which of the servers defined above will actually be
  # installed on your system.
  [
    nixos-mcp-tools
    context7
  ]
