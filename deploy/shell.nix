{
  pkgs ? import <nixpkgs> {}, # here we import the nixpkgs package set
  self ? {packages.aarch64-darwin.unix_config = {__toString= self: "self_unix_config";};}
}:
let
  python_run = "";
  ansible_playbook = "${python_run} ansible-playbook";
  ansible_inventory = "${python_run} ansible-inventory";
  
  # # OVH Openstack inventory
  # openstack_inventory = " -i inventories/openstack.yml -i inventories/extra_openstack.yml";
  # ans_openstack_playbook = "${ansible_playbook} ${openstack_inventory}";
  # vault_openstack = " --vault-password-file vault_password_openstack";
  # ansible_vault_openstack="${ans_openstack_playbook} ${vault_openstack}";

  # # Azure inventory
  # azure_inventory = " -i inventories/azure.yml -i inventories/extra_azure.yml";
  # ans_azure_playbook = "${ansible_playbook} ${azure_inventory}";
  # vault_azure = " --vault-password-file vault_password_azure";
  # ansible_vault_azure = "${ans_azure_playbook} ${vault_azure}";

  # # AWS inventory
  # aws_inventory = " -i inventories/aws_ec2.yml -i inventories/extra_aws.yml";
  # ansible_playbook_aws = "${ansible_playbook} ${aws_inventory}";
  # vault_aws = " --vault-password-file vault_password_aws";
  # ansible_vault_aws="${ansible_playbook_aws} ${vault_aws}";

  # Collecting all the inventories
  # all_inventories="-i inventories/inventory.yml ${openstack_inventory} ${aws_inventory} ${vault_openstack} ${vault_aws}";
  # all_inventories="-i inventories/inventory.yml";
  all_inventories = ""; #-i inventories/";

  switchhome = pkgs.writeScriptBin "switchhome" ''
    #echo "Switch to ${./.}"
    #cd ${./.}
    nix build ".#homeconfigurations.aarch64-darwin.robert.activationpackage"
    ./result/activate
  '';

  # Graph and list the inventory
  invgraph = pkgs.writeScriptBin "inv_graph" ''
    ${ansible_inventory} ${all_inventories} --graph
  '';
  invlist = pkgs.writeScriptBin "inv_list" ''
    ${ansible_inventory} ${all_inventories} --list
  '';

  # Ping all machines found in the inventory
  ping_all = pkgs.writeScriptBin "ping_all" ''
    echo "Pinging all detected machines"
    ${ansible_playbook} ${all_inventories} --extra-vars playbook_groups=all playbooks/oneoff_tools/ping_role.yml
  '';

  protect = pkgs.writeScriptBin "secrets_protect" ''
	  ${ansible_playbook} playbooks/local_protect_credentials.yml --tag encrypt
  '';
  unprotect = pkgs.writeScriptBin "secrets_unprotect" ''
	  ${ansible_playbook} playbooks/local_protect_credentials.yml --tag decrypt
  '';

  ansible_galaxy_install = pkgs.writeScriptBin "ansible_requirements" ''
    echo "Running playbook: $1"
    ansible-galaxy collection install -r requirements.yml
  '';

  # runpasswordlesshost = pkgs.writeScriptBin "runpasswordlessonly" ''
  #   echo "Running playbook: $1"
  #   ${ansible_playbook} ${all_inventories} --extra-vars "playbook_groups=$1" playbooks/oneoff_tools/password_less_sudo_role.yml -K
  # '';

  runplay = pkgs.writeScriptBin "runplay" ''
    echo "Running playbook with args: $@"
    ${ansible_playbook} ${all_inventories} $@
  '';
  runplayhost = pkgs.writeScriptBin "runplayhost" ''
    echo "Running playbook: $1 on $2 further args \"''${@:3}\""
    ${ansible_playbook} ${all_inventories} --extra-vars "playbook_groups=$1" $2 ''${@:3}
  '';
  # runplayhostpass = pkgs.writeScriptBin "runplayhostpass" ''
  #   echo "Running playbook with become password: $1 on $2"
  #   ${ansible_playbook} ${all_inventories} --extra-vars "playbook_groups=$1" $2 -K
  # '';
  basepkgs = [
    pkgs.poetry
    pkgs.ansible
    pkgs.nmap
    pkgs.git
    pkgs.helix
    pkgs.tmux
    pkgs.python310Packages.jmespath
    pkgs.fish
  ];
  darwin_only = [];
  linux_only = [
    pkgs.openstackclient
    pkgs.azure-cli
    pkgs.awscli
  ];
  scripthelpers = [
    switchhome
    invgraph
    invlist
    ansible_galaxy_install
    ping_all
    protect
    unprotect
    # runpasswordlesshost
    runplay
    runplayhost
    # runplayhostpass
  ];
  debug = x: pkgs.lib.traceSeq x x;
  # config = ./config/bash;
  # configpath = builtins.toString ./.;
in pkgs.mkShell rec {       # mkShell is a helper function
  name="unix_config_deploy";    # that requires a name
  # And a list of build inputs
  buildInputs = if pkgs.stdenv.isDarwin then 
    basepkgs ++ darwin_only ++ scripthelpers
  else 
    basepkgs ++ linux_only ++ scripthelpers;
  # Then will run this script before give the user the shell
  shellHook = ''
    source "${../.}/configs/bash/bashrc"

    # bash to run when you enter the shell
    #PROMPT=$bldgrn"NIX-\u@\h ["$bldpur"\w"$bldgrn"]"$txtrst'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$txtylw' ($BRANCH) '$txtrst'"; else echo "'$txtgrn' ($BRANCH) '$txtrst'"; fi fi;)'$txtcyn"\n\$ "$txtrst
    #OLD_PS1=$PS1
    #export PS1=$PROMPT
    export PS1=$txtred"NIX✅$txtrst-"$txtblu"${name}"$txtrst"\n$PS1"
    echo "Start developing...system = '${pkgs.system}'"                                        
    # poetry install
    # poetry shell
   # '';
}