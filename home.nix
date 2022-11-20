{ config, pkgs, ... }:
let
  PROJECT_ROOT=builtins.toString ./.;
  debugtrace = x: pkgs.lib.traceSeq x x;
  git_alias_file = (builtins.readFile ./configs/git/git_alias.ini);
  git_alias_imported = (builtins.fromTOML git_alias_file).alias;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "robert";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/user/robert" else "/home/robert";

  # Packages that should be installed to the user profile.
  home.packages = [                            
    #pkgs.htop
    # pkgs.ansible
    pkgs.ansible-lint
    pkgs.rnix-lsp
    pkgs.python310
    # pkgs.tmux
    # pkgs.zellij
    #pkgs.python310
    #pkgs.poetry
    #pkgs.docker
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.git.enable = true;
  programs.git = {
    # enable = true;
    userName = "Robert Munnoch";
    userEmail = "robert@munnox.com";
    # aliases =  git_alias_imported;
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.extraConfig
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      url = {
        "https:/github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        "https:/gitlab.com/" = {
          insteadOf = [
            "gl:"
            "gitlab:"
          ];
        };
      };
      core = {
        editor = "hx";
      };
    };
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.includes
    includes = [
      { path = "${./configs}/git/git_diff.ini"; }
      { path = "${./configs}/git/git_alias.ini"; }
    ];
  };
  
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''

    if status is-interactive
        # Commands to run in interactive sessions can go here
    end

    function fish_prompt --description 'Informative prompt'
        #Save the return status of the previous command
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

        if functions -q fish_is_root_user; and fish_is_root_user
            printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                             and set_color $fish_color_cwd_root
                                                             or set_color $fish_color_cwd) \
                                    (prompt_pwd) (set_color normal)
        else
            set -l status_color (set_color $fish_color_status)
            set -l statusb_color (set_color --bold $fish_color_status)
            set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

            printf '[%s] %s%s@%s %s%s %s%s%s \n> ' (date "+%H:%M:%S") (set_color brblue) \
                $USER (prompt_hostname) (set_color $fish_color_cwd) $PWD $pipestatus_string \
                (set_color normal)
        end
    end
  '';

  programs.helix.enable = true;
  programs.helix.settings = {
    theme = "night_owl";
    keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "{" = ["goto_prev_paragraph" "collapse_selection"];
        "}" = ["goto_next_paragraph" "collapse_selection"];
    };
    keys.insert = {
        j.j = "normal_mode";
        "C-c" = "normal_mode";
    };
    keys.select = {
      "{" = ["goto_prev_paragraph" "collapse_selection"];
      "}" = ["goto_next_paragraph" "collapse_selection"];
    };
  };
  programs.zellij.enable = true;
  programs.tmux.enable = true;
  programs.gitui.enable = true;

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    scrolling.history = 1000;
    window.opacity = 1.0;
    selection. save_to_clipboard = true;
    live_config_reload = true;
    shell.program = "${pkgs.bash}/bin/bash";
    shell.args = ["--login"];
    alt_send_esc = true;
    debug.render_time = true;
    # Log level None,Error,Warn,Info,Debug,Trace
    # debug.log_level = "Warn";
    debug.print_events = true;
    font.normal.family = "Hack";
    font.bold.family = "Hack";
    font.italic.family = "Hack";
    # font.size= 14.0;

    key_bindings = [
      { key = "F"; mods = "Alt"; chars = "\\x1bf"; }
      { key = "B"; mods = "Alt"; chars = "\\x1bb"; }  
      { key = "N"; mods = "Alt"; chars = "\\x1bn"; }  
      { key = "H"; mods = "Alt"; chars = "\\x1bh"; }  
      { key = "J"; mods = "Alt"; chars = "\\x1bj"; }  
      { key = "K"; mods = "Alt"; chars = "\\x1bk"; }  
      { key = "L"; mods = "Alt"; chars = "\\x1bl"; }  
      # { key = "Left";  mods = "Shift";   chars = "\\x1b[1;2D";                   }
      # { key = "Left";  mods = "Control"; chars = "\\x1b[1;5D";                   }
      { key = "Left";  mods = "Alt";     chars = "\\x1b[1;3D";                   }
      # { key = "Left";                    chars = "\\x1b[D"; mode = "~AppCursor"; }
      # { key = "Left";                    chars = "\\x1bOD"; mode = "AppCursor" ; }
      # { key = "Right"; mods = "Shift";   chars = "\\x1b[1;2C";                   }
      # { key = "Right"; mods = "Control"; chars = "\\x1b[1;5C";                   }
      { key = "Right"; mods = "Alt";     chars = "\\x1b[1;3C";                   }
      # { key = "Right";                   chars = "\\x1b[C"; mode = "~AppCursor"; }
      # { key = "Right";                   chars = "\\x1bOC"; mode = "AppCursor" ; }
      # { key = "Up";    mods = "Shift";   chars = "\\x1b[1;2A";                   }
      # { key = "Up";    mods = "Control"; chars = "\\x1b[1;5A";                   }
      # { key = "Up";    mods = "Alt";     chars = "\\x1b[1;3A";                   }
      # { key = "Up";                      chars = "\\x1b[A"; mode = "~AppCursor"; }
      # { key = "Up";                      chars = "\\x1bOA"; mode = "AppCursor" ; }
      # { key = "Down";  mods = "Shift";   chars = "\\x1b[1;2B";                   }
      # { key = "Down";  mods = "Control"; chars = "\\x1b[1;5B";                   }
      { key = "Down";  mods = "Alt";     chars = "\\x1b[1;3B";                   }
      # { key = "Down";                    chars = "\\x1b[B"; mode = "~AppCursor"; }
      { key = "Down";                    chars = "\\x1bOB"; mode = "AppCursor" ; }
      # {
      #   key = "K";
      #   mods = "Control";
      #   chars = "\\x0c";
      # }
    ];
  };
  
  # programs.
#   programs.emacs = {                            
#     enable = true;
#     extraPackages = epkgs: [
#       epkgs.nix-mode
#       epkgs.magit
#     ];
#   };

#   services.gpg-agent = {                    
#     enable = true;
#     defaultCacheTtl = 1800;
#     enableSshSupport = true;
#   };
}
