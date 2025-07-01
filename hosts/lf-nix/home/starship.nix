{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = let
     	darkgray = "242";
      	rosewater = "#f5e0dc";
	flamingo = "#f2cdcd";
	pink = "#f5c2e7";
	mauve = "#cba6f7";
	red = "#f38ba8";
	maroon = "#eba0ac";
	peach = "#fab387";
	yellow = "#f9e2af";
	green = "#a6e3a1";
	teal = "#94e2d5";
	sky = "#89dceb";
	sapphire = "#74c7ec";
	blue = "#89b4fa";
	lavender = "#b4befe";
	text = "#cdd6f4";
	subtext1 = "#bac2de";
	subtext0 = "#a6adc8";
	overlay2 = "#9399b2";
	overlay1 = "#7f849c";
	overlay0 = "#6c7086";
	surface2 = "#585b70";
	surface1 = "#45475a";
	surface0 = "#313244";
	base = "#1e1e2e";
	mantle = "#181825";
	crust = "#11111b";
    in {
      format = lib.concatStrings [
        "$username"
        "($hostname )"
        "$directory"
        "($git_branch )"
        "($git_state )"
        "($git_status )"
        "($git_metrics )"
        "($cmd_duration )"
        "$line_break"
        "($python )"
        "($nix_shell )"
        "($direnv )"
        "$character"
      ];
      
      directory = {
       # style = "blue";
       # read_only = " !";
        style = "bold ${peach}";
	truncate_to_repo = true;
	truncation_length = 0;
	truncation_symbol = "repo: ";
	read_only = "\uf456";
#	read_only = "\";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style)";
        # style = darkgray;
        symbol = " ";
	style = "bold ${green}";
      };

      git_status = {
        ahead = "";
	behind = "";
	deleted = "x";
	diverged = "";
	style = "text";
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted )](218)($ahead_behind$stashed)]($style)";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        stashed = "≡";
      };

      git_state = {
        format = "[$state( $progress_current/$progress_total)]($style)";
        style = "dimmed";
        rebase = "rebase";
        merge = "merge";
        revert = "revert";
        cherry_pick = "pick";
        bisect = "bisect";
        am = "am";
        am_or_rebase = "am/rebase";
      };

      sudo = {
	  disabled = false;
      };	

      git_metrics = {
      	disabled = false;
	      added_style = "bold ${green}";
	      format = "[+$added]($added_style)/[-$deleted]($deleted_style)";
      };


      cmd_duration = {
       # format = "[$duration]($style)";
#        style = "yellow";
        disabled = false;
	style="bold ${flamingo}";
	format = "took [$duration]($style)";
	show_milliseconds = true;
	show_notifications = true;
	min_time_to_notify = 30000;
      };

      python = {
        format = "[$virtualenv]($style)";
        style = darkgray;
      };

      nix_shell = {
        format = "❄️";
        style = darkgray;
        heuristic = true;
#        format = "via [$symbol(($name))]($style)";
      };

      direnv = {
        format = "[($loaded/$allowed)]($style)";
        style = darkgray;
        disabled = false;
        loaded_msg = "";
        allowed_msg = "";
      };

      username = {
				format = " [$user]($style)";
				show_always = true;
				style_root = "bold ${red}";
				style_user = "bold ${mauve}";
      };

      hostname = {
        format = "@[$hostname]($style) in";
        disabled = false;
	ssh_only = false;
	style = "bold ${maroon}";
	ssh_symbol = " ";
	};
 
	battery = {
  		display = [
		    { # 0% to 15%
		      disabled = false;
		      style = "bold ${red}";
		      threshold = 15;
		    }
		    { # 15% to 50%
		      disabled = true;
		      style = "bold ${peach}";
		      threshold = 50;
		    }
		    { # 50% to 90%
		      disabled = true;
		      style = "bold ${green}";
		      threshold = 90;
		    }
		  ];
	};
	
	status = {
	disabled = false;
	format = "[\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\ = {($style)";
	map_symbol = true;
	pipestatus = true;
	symbol = "✖";
	not_executable_symbol = "";
	not_found_symbol = "";
	sigint_symbol = "󰟾";
	signal_symbol = "";
	};
	
	os = {
	disabled = false;
	format = " [$symbol]($style)";
	style = "bold ${mauve}";
	};
#	character = {
#	error_symbol = "";
#	success_symbol = "❯(bold green)";
#	};
	# SYMBOLS
	git_commit = {
	tag_symbol = "  ";
	};
	golang = {
	symbol = " ";
	};
	guix_shell = {
	symbol = " ";
	};
	haskell = {
	symbol = " ";
	};
	haxe = {
	symbol = " ";
	};
	hg_branch = {
	symbol = " ";
	};
	java = {
	symbol = " ";
	};
	julia = {
	symbol = " ";
	};
	kotlin = {
	symbol = " ";
	};
	lua = {
	symbol = " ";
	};
	memory_usage = {
	symbol = "󰍛 ";
	};
	meson = {
	symbol = "󰔷 ";
	};
	nim = {
	symbol = "󰆥 ";
	};
	nodejs = {
	symbol = " ";
	};
	ocaml = {
	symbol = " ";
	};
	os.symbols = {
	Alpaquita = " ";
	Alpine = " ";
	AlmaLinux = " ";
	Amazon = " ";
	Android = " ";
	Arch = " ";
	Artix = " ";
	CentOS = " ";
	Debian = " ";
	DragonFly = " ";
	Emscripten = " ";
	EndeavourOS = " ";
	Fedora = " ";
	FreeBSD = " ";
	Garuda = "󰛓 ";
	Gentoo = " ";
	HardenedBSD = "󰞌 ";
	Illumos = "󰈸 ";
	Kali = " ";
	Linux = " ";
	Mabox = " ";
	Macos = " ";
	Manjaro = " ";
	Mariner = " ";
	MidnightBSD = " ";
	Mint = " ";
	NetBSD = " ";
	NixOS = " ";
	OpenBSD = "󰈺 ";
	openSUSE = " ";
	OracleLinux = "󰌷 ";
	Pop = " ";
	Raspbian = " ";
	Redhat = " ";
	RedHatEnterprise = " ";
	RockyLinux = " ";
	Redox = "󰀘 ";
	Solus = "󰠳 ";
	SUSE = " ";
	Ubuntu = " ";
	Unknown = " ";
	Void = " ";
	Windows = "󰍲 ";
	};

	package = {
	symbol = "󰏗 ";
};
	perl = {
	symbol = " ";
};
	php = {
	symbol = " ";
};
	pijul_channel = {
	symbol = " ";
};
	python = {
	symbol = " ";
};
	rlang = {
	symbol = "󰟔 ";
};
	ruby = {
	symbol = " ";
};
	rust = {
	symbol = "󱘗 ";
};
	scala = {
	symbol = " ";
};
	swift = {
	symbol = " ";
};
	zig = {
	symbol = " ";
};
	gradle = {
	symbol = " "	;
	};
      };
    };
  }

