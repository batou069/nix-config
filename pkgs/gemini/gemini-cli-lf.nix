{ pkgs, config, lib, cfg, ... }:

let
	gemini-cli-custom = pkgs.callPackage ./package.nix { inherit pkgs lib; };
in
 {
	environment.systemPackages = [
		gemini-cli-custom
	];

	# Install systemd service
	# systemd.services."duplicacy-web" = {
	# 	enable = true;
	# 	wants = [ "network-online.target" ];
	# 	after = [ "syslog.target" "network-online.target" ];
	# 	description = "Start the Duplicacy backup service and web UI";
	# 	serviceConfig = {
	# 		Type = "simple";
	# 		ExecStart = ''${duplicacy-web}/duplicacy-web'';
	# 		Restart = "on-failure";
	# 		RestartSrc = 10;
	# 		KillMode = "process";
	# 		Environment = "HOME=${config.users.users.aires.home}";
	# 	};
	# };
}
