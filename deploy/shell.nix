{ pkgs ? import <nixpkgs> {} # here we import the nixpkgs package set
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
  all_inventories=""; #-i inventories/";

  # Graph and list the inventory
  invgraph = pkgs.writeScriptBin "inv_graph" ''
    ${ansible_inventory} ${all_inventories} --graph
  '';
  invlist = pkgs.writeScriptBin "inv_list" ''
    ${ansible_inventory} ${all_inventories} --list
  '';
  # Graph and list the nmap inventory
  invnmapgraph = pkgs.writeScriptBin "inv_nmap_graph" ''
	  ${ansible_inventory} -i inventories/nmap.yml --graph -y
  '';
  invnmaplist = pkgs.writeScriptBin "inv_nmap_list" ''
	  ${ansible_inventory} -i inventories/nmap.yml --list -y
  '';
  # Ping all machines found in the inventory
  ping_all = pkgs.writeScriptBin "ping_all" ''
    echo "Pinging all detected machines"
    ${ansible_playbook} ${all_inventories} playbooks/ping.yml
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
  runpasswordlesshost = pkgs.writeScriptBin "runpasswordlessonly" ''
    echo "Running playbook: $1"
    ${ansible_playbook} ${all_inventories} --extra-vars "playbook_groups=$1" playbooks/oneoff_tools/password_less_sudo_role.yml -K
  '';
  runplayonly = pkgs.writeScriptBin "runplayonly" ''
    echo "Running playbook: $1"
    ${ansible_playbook} ${all_inventories} $1
  '';
  runplay = pkgs.writeScriptBin "runplay" ''
    echo "Running playbook: $@"
    ${ansible_playbook} ${all_inventories} $@
  '';
  runplayhost = pkgs.writeScriptBin "runplayhost" ''
    echo "Running playbook: $1 on $2"
    ${ansible_playbook} ${all_inventories} --extra-vars "playbook_groups=$1" $2
  '';
  runplayhostpass = pkgs.writeScriptBin "runplayhostpass" ''
    echo "Running playbook with become password: $1 on $2"
    ${ansible_playbook} ${all_inventories} --extra-vars "playbook_groups=$1" $2 -K
  '';
  basepkgs = [
    pkgs.poetry
    pkgs.ansible
    pkgs.nmap
    pkgs.git
    pkgs.helix
  ];
  scripthelpers = [
    invgraph
    invlist
    invnmapgraph
    invnmaplist
    ansible_galaxy_install
    ping_all
    protect
    unprotect
    runpasswordlesshost
    runplayonly
    runplay
    runplayhost
    runplayhostpass
  ];
  # config = ./config/bash;
  # configpath = builtins.toString ./.;
in pkgs.mkShell {       # mkShell is a helper function
  name="deploy_ctl";    # that requires a name
  # And a list of build inputs
  buildInputs = if pkgs.stdenv.isDarwin then 
      basepkgs ++ scripthelpers
    else 
        basepkgs ++ [
        pkgs.azure-cli
        pkgs.awscli
      ] ++ scripthelpers;
  # Then will run this script before give the user the shell
  shellHook = ''
    # declare -xp
    #set -xp
    # Colours
    txtblk='\[\e[0;30m\]' # Black - Regular
    txtred='\[\e[0;31m\]' # Red
    txtgrn='\[\e[0;32m\]' # Green
    txtylw='\[\e[0;33m\]' # Yellow
    txtblu='\[\e[0;34m\]' # Blue
    txtpur='\[\e[0;35m\]' # Purple
    txtcyn='\[\e[0;36m\]' # Cyan
    txtwht='\[\e[0;37m\]' # White

    bldblk='\[\e[1;30m\]' # Black - Bold
    bldred='\[\e[1;31m\]' # Red
    bldgrn='\[\e[1;32m\]' # Green
    bldylw='\[\e[1;33m\]' # Yellow
    bldblu='\[\e[1;34m\]' # Blue
    bldpur='\[\e[1;35m\]' # Purple
    bldcyn='\[\e[1;36m\]' # Cyan
    bldwht='\[\e[1;37m\]' # White

    unkblk='\[\e[4;30m\]' # Black - Underline
    undred='\[\e[4;31m\]' # Red
    undgrn='\[\e[4;32m\]' # Green
    undylw='\[\e[4;33m\]' # Yellow
    undblu='\[\e[4;34m\]' # Blue
    undpur='\[\e[4;35m\]' # Purple
    undcyn='\[\e[4;36m\]' # Cyan
    undwht='\[\e[4;37m\]' # White

    bakblk='\[\e[40m\]'   # Black - Background
    bakred='\[\e[41m\]'   # Red
    badgrn='\[\e[42m\]'   # Green
    bakylw='\[\e[43m\]'   # Yellow
    bakblu='\[\e[44m\]'   # Blue
    bakpur='\[\e[45m\]'   # Purple
    bakcyn='\[\e[46m\]'   # Cyan
    bakwht='\[\e[47m\]'   # White
    txtrst='\[\e[0m\]'    # Text Reset

    alias ll='ls -al'

    # bash to run when you enter the shell
    PROMPT=$bldgrn"NIX-\u@\h ["$bldpur"\w"$bldgrn"]"$txtrst'$(BRANCH=`git rev-parse --abbrev-ref HEAD 2> /dev/null`; if [ -n "$BRANCH" ]; then DIRTY=`git status --porcelain 2> /dev/null`; if [ -n "$DIRTY" ]; then echo "'$txtylw' ($BRANCH) '$txtrst'"; else echo "'$txtgrn' ($BRANCH) '$txtrst'"; fi fi;)'$txtcyn"\n\$ "$txtrst
    OLD_PS1=$PS1
    export PS1=$PROMPT
    echo "Start developing...system = '${pkgs.system}'"                                        
    # poetry install
    # poetry shell
  '';
}