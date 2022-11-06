{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "robert";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/user/robert" else "/home/robert";

  # Packages that should be installed to the user profile.
  home.packages = [                            
    #pkgs.htop
    pkgs.ansible
    pkgs.rnix-lsp
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