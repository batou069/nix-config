{ ... }: {
  environment.etc."wireplumber/policy/10-hide-monitors.conf".text = ''
    context.modules = [
      { name = libpipewire-module-filter-chain }
    ]

    policy.rules = [
      {
        matches = [
          { "node.name" = "~.*monitor$" }
        ]
        actions = {
          "update-props" = { "node.hidden" = true }
        }
      }
    ]
  '';
}
