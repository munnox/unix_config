from ansible.module_utils._text import to_bytes, to_native, to_text
from ansible.errors import AnsibleError, AnsibleFilterError, AnsibleFilterTypeError
from ansible.utils.display import Display
from ansible.parsing.yaml.dumper import AnsibleDumper
import yaml
import uuid
from textwrap import dedent

from jinja2.filters import pass_environment

display = Display()

UUID_NAMESPACE_ANSIBLE = uuid.UUID('461E6D51-FAEC-444A-9079-341386DA8E2E')

@pass_environment
def munnox_machine_definition(environment, machines, virt_uri, image_dir, download_dir, *args, **kw):
    '''Define VM's '''
    # default_flow_style = kw.pop('default_flow_style', None)
    # try:
    #     transformed = yaml.dump(a, Dumper=AnsibleDumper, allow_unicode=True, default_flow_style=default_flow_style, **kw)
    # except Exception as e:
    #     raise AnsibleFilterError("to_yaml - %s" % to_native(e), orig_exc=e)
    vms = []
    for vm in machines:
        seed_path = f"{ image_dir }/{ vm['name'] }-seed.img"
        main_disk_path =  f"{ image_dir }/{ vm['name'] }.{ vm['disk_type_ext'] }"
        print(vm)
        vm_built = {
            "vm": vm,
            "image_path": f"{ download_dir }/{ vm['image_name'] }",
            "main_disk_path":  main_disk_path,
            "seed_path": seed_path,
            "cloud_config_path":  f"{ download_dir }/{ vm['name'] }_cloud_init.cfg",
            "network_config_path": f"{ download_dir }/{ vm['name'] }_snetwork_config_static.cfg",
            "virsh_cmd": dedent(rf"""
              virt-install --connect { virt_uri } --name { vm['name'] } \
                --virt-type kvm --memory { vm['memory_gib'] * 1024 } --vcpus { vm['cpus'] } \
                --boot hd,menu=on \
                --disk path={ seed_path },device=cdrom \
                --disk path={ main_disk_path },device=disk \
                --graphics vnc \
                --os-type Linux --os-variant ubuntu20.04 \
                --network { vm['network_connection'] } \
                --console pty,target_type=serial \
                --wait 0
            """).strip(" \n"),
            # "virsh_cmd_default": """
            #   virt-install --connect {{ virt_uri }} --name {{ vm.name }} \
            #     --virt-type kvm --memory {{ new_memory_mib }} --vcpus 2 \
            #     --boot hd,menu=on \
            #     --disk path={{ seed_path }},device=cdrom \
            #     --disk path={{ main_disk_path }},device=disk \
            #     --graphics vnc \
            #     --os-type Linux --os-variant ubuntu20.04 \
            #     --network network:default \
            #     --console pty,target_type=serial
            # """,
        }
        vms.append(vm_built)
    return vms

class FilterModule(object):
    ''' Ansible core jinja2 filters '''

    def filters(self):
        return {
            'machine_definition': munnox_machine_definition,
            # debug
            'type_debug': lambda o: o.__class__.__name__,
        }