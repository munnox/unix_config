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
  basepkgs = [
    pkgs.poetry
    pkgs.ansible
    pkgs.nmap
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
  ];
in pkgs.mkShell {               # mkShell is a helper function
  name="deploy_ctl";    # that requires a name
  buildInputs = if pkgs.stdenv.isDarwin then basepkgs ++ scripthelpers else basepkgs ++ [
      pkgs.azure-cli
      pkgs.aws
    ] ++ scripthelpers;

  shellHook = ''
    # bash to run when you enter the shell     
    echo "Start developing...system = '${pkgs.system}'"                                          
    # poetry install
    # poetry shell
  '';               
}